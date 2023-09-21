import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zhwlzlxt_project/base/globalization.dart';
import 'package:zhwlzlxt_project/entity/shenJing_entity.dart';

import '../entity/set_value_state.dart';
import '../utils/event_bus.dart';
import '../utils/sp_utils.dart';
import '../utils/treatment_type.dart';
import '../widget/popup_menu_btn.dart';
import '../widget/set_value_horizontal.dart';
import 'control_page.dart';

class ShenJingPage extends StatefulWidget {
  const ShenJingPage({Key? key}) : super(key: key);

  @override
  State<ShenJingPage> createState() => _ShenJingPageState();
}

class _ShenJingPageState extends State<ShenJingPage> with AutomaticKeepAliveClientMixin {
  bool yiStartSelected = false;
  bool erStartSelected = false;

  Neuromuscular? neuromuscular;
//计时器
  late Timer _timer1;
  int _countdownTime1 = 0;

  late Timer _timer2;
  int _countdownTime2 = 0;

  @override
  void initState() {
    super.initState();
    neuromuscular = Neuromuscular();
    neuromuscular?.init();


    eventBus.on<UserEvent>().listen((event) {
      if (event.type == TreatmentType.neuromuscular) {
        neuromuscular?.userId = event.user?.userId;
        save(event.user?.userId ?? -1);
      }
    });
  }
  void save(int userId) {
    SpUtils.set(NeuromuscularField.NeuromuscularKey, userId);
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer1 != null) {
      _timer1.cancel();
    }
    if (_timer2 != null) {
      _timer2.cancel();
    }
  }

  void startCountdownTimer1() {
    const oneSec = Duration(seconds: 1);
    callback(timer) => {
      setState(() {
        if (_countdownTime1 < 1) {
          _timer1.cancel();
          //计时结束
          //结束治疗
          neuromuscular?.start1(false);
          yiStartSelected = false;
          neuromuscular?.init();
          setState(() {
          });

        } else {
          _countdownTime1 = _countdownTime1 - 1;
        }
      })
    };
    _timer1 = Timer.periodic(oneSec, callback);
  }

  void startCountdownTimer2() {
    const oneSec = Duration(seconds: 1);
    callback(timer) => {
      setState(() {
        if (_countdownTime2 < 1) {
          _timer2.cancel();
          //计时结束
          //结束治疗
          neuromuscular?.start2(false);
          erStartSelected = false;
          neuromuscular?.init();
          setState(() {
          });

        } else {
          _countdownTime2 = _countdownTime2 - 1;
        }
      })
    };
    _timer2 = Timer.periodic(oneSec, callback);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
                margin: EdgeInsets.only(top: 9.h),
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
                              )
                          ),
                          width: 340.w,
                          height: 90.h,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
                                child: TextButton(
                                    onPressed: (){
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset('assets/images/2.0x/icon_moshi.png',fit: BoxFit.fitWidth,width: 16.w,height: 16.h,),
                                        SizedBox(width: 4.w,),
                                        Text(
                                          Globalization.mode.tr,
                                          style: TextStyle(fontSize: 16.sp,color: const Color(0xFF999999)),),
                                      ],
                                    )
                                ),
                              ),
                              PopupMenuBtn(
                                index: 5,
                                patternStr: neuromuscular?.patternA ?? "完全失神经",
                                enabled: true,
                                popupListener: (value) {
                                  neuromuscular?.patternA = value;
                                },
                              ),

                            ],
                          )
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 90.h,
                          type: TreatmentType.neuromuscular,
                          enabled: true,
                          title: Globalization.time.tr,
                          assets: 'assets/images/2.0x/icon_shijian.png',
                          initialValue: double.tryParse(neuromuscular?.timeA ?? '1'),
                          minValue: 1,
                          maxValue: 30,
                          unit: 'min',
                          valueListener: (value) {
                            neuromuscular?.timeA = value.toString();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 90.h,
                          enabled: true,
                          type: TreatmentType.neuromuscular,
                          isInt: true,
                          title: Globalization.intensity.tr,
                          assets: 'assets/images/2.0x/icon_qiangdu.png',
                          initialValue: double.tryParse(neuromuscular?.powerA ?? '1'),
                          maxValue: 99,
                          minValue: 1,
                          valueListener: (value) {
                            neuromuscular?.powerA = value.toString();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 90.h,
                          enabled: true,
                          type: TreatmentType.neuromuscular,
                          isInt: false,
                          title: Globalization.frequency.tr,
                          unit: 'Hz',
                          assets: 'assets/images/2.0x/icon_pinlv.png',
                          initialValue: double.tryParse(neuromuscular?.frequencyA ?? '0.5'),
                          minValue: 0.5,
                          maxValue: 5,
                          appreciation: 0.5,
                          valueListener: (value) {
                            neuromuscular?.frequencyA = value.toString();
                          },
                        ),
                      ),
                      Container(
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              )
                          ),
                          child: TextButton(
                              onPressed: (){
                                yiStartSelected =
                                    neuromuscular?.start1(!yiStartSelected) ??
                                    false;
                                if (yiStartSelected) {
                                  neuromuscular?.init();
                                  Future.delayed(const Duration(milliseconds: 500), () {
                                    eventBus.fire(SetValueState(TreatmentType.neuromuscular));
                                  });
                                }
                                setState(() {
                                  //点击开始治疗
                                  // double? tmp = double.tryParse(neuromuscular?.timeA ?? '1');
                                  // _countdownTime1 = ((tmp?.toInt())! * 60)!;
                                  // debugPrint('++++_countdownTime+++++$_countdownTime1');
                                  // startCountdownTimer1();
                                });
                              },
                              child: Image.asset(yiStartSelected ? 'assets/images/2.0x/btn_tingzhi_nor.png' : 'assets/images/2.0x/btn_kaishi_nor.png',fit: BoxFit.cover,width: 120.w,height: 45.h,)
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),
            Container(
                width: 1,
                height: 487.h,
                margin: EdgeInsets.only(top: 11.h),
                color: const Color(0xFFD6D6D6),
                child: Text('',style: TextStyle(fontSize: 18.sp,color: Colors.black),)
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: 9.h),
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
                              )
                          ),
                          width: 340.w,
                          height: 90.h,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
                                child: TextButton(
                                    onPressed: (){
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset('assets/images/2.0x/icon_moshi.png',fit: BoxFit.fitWidth,width: 16.w,height: 16.h,),
                                        SizedBox(width: 4.w,),
                                        Text(
                                          Globalization.mode.tr,
                                          style: TextStyle(fontSize: 16.sp,color: const Color(0xFF999999)),),
                                      ],
                                    )
                                ),
                              ),
                              PopupMenuBtn(
                                index: 5,
                                patternStr: neuromuscular?.patternB ?? "完全失神经",
                                enabled: true,
                                popupListener: (value) {
                                  neuromuscular?.patternB = value;
                                },
                              ),
                            ],
                          )
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 90.h,
                          enabled: true,
                          type: TreatmentType.neuromuscular,
                          title: Globalization.time.tr,
                          assets: 'assets/images/2.0x/icon_shijian.png',
                          initialValue: double.tryParse(neuromuscular?.timeB ?? '1'),
                          maxValue: 30,
                          minValue: 1,
                          unit: 'min',
                          valueListener: (value) {
                            neuromuscular?.timeB = value.toString();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 90.h,
                          enabled: true,
                          type: TreatmentType.neuromuscular,
                          isInt: true,
                          title: Globalization.intensity.tr,
                          assets: 'assets/images/2.0x/icon_qiangdu.png',
                          initialValue: double.tryParse(neuromuscular?.powerB ?? '1'),
                          minValue: 1,
                          maxValue: 99,
                          valueListener: (value) {
                            neuromuscular?.powerB = value.toString();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 90.h,
                          enabled: true,
                          isInt: false,
                          type: TreatmentType.neuromuscular,
                          title: Globalization.frequency.tr,
                          unit: 'Hz',
                          assets: 'assets/images/2.0x/icon_pinlv.png',
                          initialValue: double.tryParse(neuromuscular?.frequencyB ?? '0.5'),
                          minValue: 0.5,
                          maxValue: 5,
                          appreciation: 0.5,
                          valueListener: (value) {
                            neuromuscular?.frequencyB = value.toString();
                          },
                        ),
                      ),
                      Container(
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              )
                          ),
                          child: TextButton(
                              onPressed: (){
                                erStartSelected = neuromuscular
                                    ?.start2(!erStartSelected) ??
                                    false;
                                if (erStartSelected) {
                                  neuromuscular?.init();
                                  Future.delayed(const Duration(milliseconds: 500), () {
                                    eventBus.fire(SetValueState(TreatmentType.neuromuscular));
                                  });
                                }
                                setState(() {
                                  //点击开始治疗
                                  // double? tmp = double.tryParse(neuromuscular?.timeB ?? '1');
                                  // _countdownTime2 = ((tmp?.toInt())! * 60)!;
                                  // debugPrint('++++_countdownTime+++++$_countdownTime2');
                                  // startCountdownTimer2();
                                });
                              },
                              child: Image.asset(erStartSelected ? 'assets/images/2.0x/btn_tingzhi_nor.png' : 'assets/images/2.0x/btn_kaishi_nor.png',fit: BoxFit.cover,width: 120.w,height: 45.h,)
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
