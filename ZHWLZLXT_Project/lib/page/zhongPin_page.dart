import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zhwlzlxt_project/base/globalization.dart';
import 'package:zhwlzlxt_project/entity/zhongPin_entity.dart';

import '../entity/set_value_state.dart';
import '../utils/event_bus.dart';
import '../utils/sp_utils.dart';
import '../utils/treatment_type.dart';
import '../widget/popup_menu_btn.dart';
import '../widget/set_value_horizontal.dart';
import 'control_page.dart';

class ZhongPinPage extends StatefulWidget {
  const ZhongPinPage({Key? key}) : super(key: key);

  @override
  State<ZhongPinPage> createState() => _ZhongPinPageState();
}

class _ZhongPinPageState extends State<ZhongPinPage>
    with AutomaticKeepAliveClientMixin {
  bool yiStartSelected = false;
  bool erStartSelected = false;
  //计时器
  Timer? _timer1;
  int _countdownTime1 = 0;

  Timer? _timer2;
  int _countdownTime2 = 0;

  MidFrequency? midFrequency;

  @override
  void initState() {
    super.initState();
    midFrequency = MidFrequency();
    midFrequency?.init();

    eventBus.on<UserEvent>().listen((event) {
      if (event.type == TreatmentType.frequency) {
        midFrequency?.userId = event.user?.userId;
        save(event.user?.userId ?? -1);
      }
    });
  }

  void save(int userId) {
    SpUtils.set(MidFrequencyField.MidFrequencyKey, userId);
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer1 != null) {
      _timer1?.cancel();
    }
    if (_timer2 != null) {
      _timer2?.cancel();
    }
  }

  void startCountdownTimer1(bool startSelected) {
    if (_timer1 != null) {
      _timer1?.cancel();
    }

    if (!startSelected) {
      _timer1?.cancel();
      return;
    }
    const oneSec = Duration(seconds: 1);
    callback(timer) {
      if (_countdownTime1 < 1) {
        _timer1?.cancel();
        //计时结束
        //结束治疗
        midFrequency?.start1(false);
        yiStartSelected = false;
        midFrequency?.init();
        setState(() {
          Fluttertoast.showToast(msg: '治疗结束!');
        });
      } else {
        _countdownTime1 = _countdownTime1 - 1;
      }
    }

    _timer1 = Timer.periodic(oneSec, callback);
  }

  void startCountdownTimer2(bool startSelected) {
    if (_timer2 != null) {
      _timer2?.cancel();
    }

    if (!startSelected) {
      _timer2?.cancel();
      return;
    }
    const oneSec = Duration(seconds: 1);
    callback(timer) {
      if (_countdownTime2 < 1) {
        _timer2?.cancel();
        //计时结束
        //结束治疗
        midFrequency?.start2(false);
        erStartSelected = false;
        midFrequency?.init();
        setState(() {
          Fluttertoast.showToast(msg: '治疗结束!');
        });
      } else {
        _countdownTime2 = _countdownTime2 - 1;
      }
    }

    _timer2 = Timer.periodic(oneSec, callback);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: const Color(0xFFF0FAFE),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  margin: EdgeInsets.only(top: 11.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 15.w,
                                    offset: const Offset(0, 2),
                                    spreadRadius: 0)
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.w),
                              )),
                          width: 340.w,
                          height: 120.h,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
                                child: TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/2.0x/icon_chufang.png',
                                          fit: BoxFit.fitWidth,
                                          width: 15.w,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Text(
                                          Globalization.recipe.tr,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0xFF999999)),
                                        ),
                                      ],
                                    )),
                              ),
                              PopupMenuBtn(
                                index: 7,
                                patternStr: midFrequency?.patternA ?? "1",
                                enabled: yiStartSelected ? true : false,
                                popupListener: (value) {
                                  midFrequency?.patternA = value;
                                },
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 120.h,
                          enabled: yiStartSelected ? false : true,
                          type: TreatmentType.frequency,
                          title: Globalization.time.tr,
                          assets: 'assets/images/2.0x/icon_shijian.png',
                          initialValue:
                              double.tryParse(midFrequency?.timeA ?? '1'),
                          minValue: 1,
                          maxValue: 30,
                          unit: 'min',
                          valueListener: (value) {
                            midFrequency?.timeA = value.toString();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 120.h,
                          enabled: yiStartSelected ? true : false,
                          type: TreatmentType.frequency,
                          title: Globalization.intensity.tr,
                          assets: 'assets/images/2.0x/icon_qiangdu.png',
                          initialValue:
                              double.tryParse(midFrequency?.powerA ?? '0'),
                          maxValue: 99,
                          minValue: 0,
                          valueListener: (value) {
                            midFrequency?.powerA = value.toString();
                            midFrequency?.start1(false);
                          },
                        ),
                      ),
                      Container(
                        child: Container(
                          width: 120.w,
                          height: 45.h,
                          margin: EdgeInsets.only(top: 10.h),
                          decoration: BoxDecoration(
                              color: yiStartSelected ? const Color(0xFF00C290) : const Color(0xFF00A8E7),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.w),
                              )),
                          child: TextButton(
                              onPressed: () {
                                yiStartSelected =
                                    midFrequency?.start1(!yiStartSelected) ??
                                        false;
                                if (!yiStartSelected) {
                                  midFrequency?.init();
                                  Future.delayed(const Duration(milliseconds: 500), () {
                                    eventBus.fire(SetValueState(TreatmentType.frequency));
                                  });
                                }
                                setState(() {
                                  //点击开始治疗
                                  double? tmp = double.tryParse(midFrequency?.timeA ?? '1');
                                  _countdownTime1 = ((tmp?.toInt())! * 60)!;
                                  debugPrint('++++_countdownTime+++++$_countdownTime1');
                                  startCountdownTimer1(yiStartSelected);
                                });
                              },
                              // child: Image.asset(
                              //   yiStartSelected
                              //       ? 'assets/images/2.0x/btn_tingzhi_nor.png'
                              //       : 'assets/images/2.0x/btn_kaishi_nor.png',
                              //   fit: BoxFit.cover,
                              //   width: 120.w,
                              //   height: 45.h,
                              // )
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/2.0x/icon_kaishi.png',fit: BoxFit.fitWidth,width: 18.w,height: 18.h,),
                                SizedBox(width: 8.w,),
                                Text(yiStartSelected ? Globalization.stop.tr : Globalization.start.tr,style: TextStyle(color: Colors.white,fontSize: 18.sp,fontWeight: FontWeight.w600),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            Container(
                width: 1,
                height: 487.h,
                margin: EdgeInsets.only(top: 11.h),
                color: const Color(0xFFD6D6D6),
                child: Text(
                  '',
                  style: TextStyle(fontSize: 18.sp, color: Colors.black),
                )),
            Expanded(
              flex: 1,
              child: Container(
                  margin: EdgeInsets.only(top: 11.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 15.w,
                                    offset: const Offset(0, 2),
                                    spreadRadius: 0)
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.w),
                              )),
                          width: 340.w,
                          height: 120.h,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
                                child: TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/2.0x/icon_chufang.png',
                                          fit: BoxFit.fitWidth,
                                          width: 15.w,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Text(
                                          Globalization.recipe.tr,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0xFF999999)),
                                        ),
                                      ],
                                    )),
                              ),
                              PopupMenuBtn(
                                index: 7,
                                patternStr: midFrequency?.patternB ?? "1",
                                enabled: erStartSelected ? true : false,
                                popupListener: (value) {
                                  midFrequency?.patternB = value;
                                },
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 120.h,
                          enabled: erStartSelected ? false : true,
                          type: TreatmentType.frequency,
                          title: Globalization.time.tr,
                          assets: 'assets/images/2.0x/icon_shijian.png',
                          initialValue:
                              double.tryParse(midFrequency?.timeB ?? '1'),
                          maxValue: 30,
                          minValue: 1,
                          unit: 'min',
                          valueListener: (value) {
                            midFrequency?.timeB = value.toString();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 120.h,
                          enabled: erStartSelected ? true : false,
                          type: TreatmentType.frequency,
                          title: Globalization.intensity.tr,
                          assets: 'assets/images/2.0x/icon_qiangdu.png',
                          initialValue:
                              double.tryParse(midFrequency?.powerB ?? '0'),
                          maxValue: 99,
                          minValue: 0,
                          valueListener: (value) {
                            midFrequency?.powerB = value.toString();
                            midFrequency?.start2(false);
                          },
                        ),
                      ),
                      Container(
                        child: Container(
                          width: 120.w,
                          height: 45.h,
                          margin: EdgeInsets.only(top: 10.h),
                          decoration: BoxDecoration(
                              color: erStartSelected ? const Color(0xFF00C290) : const Color(0xFF00A8E7),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.w),
                              )),
                          child: TextButton(
                              onPressed: () {
                                erStartSelected =
                                    midFrequency?.start2(!erStartSelected) ??
                                        false;
                                if (!erStartSelected) {
                                  midFrequency?.init();
                                  Future.delayed(const Duration(milliseconds: 500), () {
                                    eventBus.fire(SetValueState(TreatmentType.frequency));
                                  });
                                }
                                setState(() {
                                  //点击开始治疗
                                  double? tmp = double.tryParse(midFrequency?.timeB ?? '1');
                                  _countdownTime2 = ((tmp?.toInt())! * 60)!;
                                  debugPrint('++++_countdownTime+++++$_countdownTime2');
                                  startCountdownTimer2(erStartSelected);
                                });
                              },
                              // child: Image.asset(
                              //   erStartSelected
                              //       ? 'assets/images/2.0x/btn_tingzhi_nor.png'
                              //       : 'assets/images/2.0x/btn_kaishi_nor.png',
                              //   fit: BoxFit.cover,
                              //   width: 120.w,
                              //   height: 45.h,
                              // )
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/2.0x/icon_kaishi.png',fit: BoxFit.fitWidth,width: 18.w,height: 18.h,),
                                SizedBox(width: 8.w,),
                                Text(erStartSelected ? Globalization.stop.tr : Globalization.start.tr,style: TextStyle(color: Colors.white,fontSize: 18.sp,fontWeight: FontWeight.w600),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
