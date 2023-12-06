import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zhwlzlxt_project/base/globalization.dart';
import 'package:zhwlzlxt_project/entity/shenJing_entity.dart';

import '../entity/set_value_state.dart';
import '../entity/ultrasonic_sound.dart';
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
  Timer? _timer1;
  int _countdownTime1 = 0;

  Timer? _timer2;
  int _countdownTime2 = 0;

  @override
  void initState() {
    super.initState();
    neuromuscular = Neuromuscular();
    neuromuscular?.init();


    // eventBus.on<UserEvent>().listen((event) {
    //   if (event.type == TreatmentType.neuromuscular) {
    //     neuromuscular?.userId = event.user?.userId;
    //     neuromuscular?.user = event.user;
    //     save(event.user?.userId ?? -1);
    //   }
    // });

    eventBus.on<TreatmentType>().listen((event) {
      if (!mounted) {
        return;
      }
      neuromuscular?.user = userMap[TreatmentType.ultrasonic];
    });

  }
  void save(int userId) {
    SpUtils.set(NeuromuscularField.NeuromuscularKey, userId);
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
    const oneSec = Duration(minutes: 1);
    callback(timer) {
      if (_countdownTime1 < 1) {
        _timer1?.cancel();
        //计时结束
        //结束治疗
        neuromuscular?.setARestValue();
        neuromuscular?.start1(false);
        yiStartSelected = false;
        electrotherapyIsRunIng = yiStartSelected||erStartSelected;
        setState(() {
          Future.delayed(
              const Duration(milliseconds: 500), () {
            eventBus.fire(SetValueState(
                TreatmentType.neuromuscular));
          });
          Fluttertoast.showToast(msg: '治疗结束!');
        });
      } else {
        _countdownTime1 = _countdownTime1 - 1;
        neuromuscular?.timeA = _countdownTime1.toString();
        RunTime runTime = RunTime(_countdownTime1.toDouble(), 2004);
        eventBus.fire(runTime);
        neuromuscular?.start1(yiStartSelected);
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
    const oneSec = Duration(minutes: 1);
    callback(timer) {
      if (_countdownTime2 < 1) {
        _timer2?.cancel();
        //计时结束
        //结束治疗
        neuromuscular?.setBRestValue();
        neuromuscular?.start2(false);
        erStartSelected = false;
        electrotherapyIsRunIng = yiStartSelected||erStartSelected;
        setState(() {
          Fluttertoast.showToast(msg: '治疗结束!');
          Future.delayed(
              const Duration(milliseconds: 500), () {
            eventBus.fire(SetValueState(
                TreatmentType.neuromuscular));
          });
        });
      } else {

        _countdownTime2 = _countdownTime2 - 1;
        neuromuscular?.timeB = _countdownTime2.toString();
        RunTime runTime = RunTime(_countdownTime2.toDouble(), 2005);
        eventBus.fire(runTime);
        neuromuscular
            ?.start2(erStartSelected);
      }
    }

    _timer2 = Timer.periodic(oneSec, callback);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
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
                              color: const Color(0xFFF0FAFE),
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
                                patternStr: neuromuscular?.patternA ?? Globalization.complete.tr,
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
                          enabled: !yiStartSelected,
                          title: Globalization.time.tr,
                          assets: 'assets/images/2.0x/icon_shijian.png',
                          isClock: true,
                          isAnimate: yiStartSelected,
                          initialValue: double.tryParse(neuromuscular?.timeA ?? '1'),
                          minValue: 1,
                          indexType: 2004,
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
                          enabled: yiStartSelected,
                          type: TreatmentType.neuromuscular,
                          isInt: true,
                          title: Globalization.intensity.tr,
                          assets: 'assets/images/2.0x/icon_qiangdu.png',
                          initialValue: double.tryParse(neuromuscular?.powerA ?? '0'),
                          maxValue: 99,
                          minValue: 0,
                          valueListener: (value) {
                            neuromuscular?.powerA = value.toString();
                            neuromuscular?.start1(true);
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 90.h,
                          enabled: !yiStartSelected,
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
                          width: 120.w,
                          height: 45.h,
                          margin: EdgeInsets.only(top: 10.h),
                          decoration: BoxDecoration(
                              color: yiStartSelected ? const Color(0xFF00C290) : const Color(0xFF00A8E7),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.w),
                              )),
                          child: TextButton(
                              onPressed: (){
                                yiStartSelected =
                                    neuromuscular?.start1(!yiStartSelected) ??
                                    false;
                                electrotherapyIsRunIng = yiStartSelected||erStartSelected;
                                eventBus.fire(Notify());
                                if (!yiStartSelected) {
                                  neuromuscular?.setARestValue();
                                  Future.delayed(const Duration(milliseconds: 500), () {
                                    eventBus.fire(SetValueState(TreatmentType.neuromuscular));
                                  });
                                }
                                setState(() {
                                  //点击开始治疗
                                  double? tmp = double.tryParse(neuromuscular?.timeA ?? '1');
                                  _countdownTime1 = ((tmp?.toInt())!);
                                  startCountdownTimer1(yiStartSelected);
                                });
                              },
                              // child: Image.asset(yiStartSelected ? 'assets/images/2.0x/btn_tingzhi_nor.png' : 'assets/images/2.0x/btn_kaishi_nor.png',fit: BoxFit.cover,width: 120.w,height: 45.h,)
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
                              color: const Color(0xFFF0FAFE),
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
                                patternStr: neuromuscular?.patternB ?? Globalization.complete.tr,
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
                          enabled: !erStartSelected,
                          type: TreatmentType.neuromuscular,
                          title: Globalization.time.tr,
                          assets: 'assets/images/2.0x/icon_shijian.png',
                          isClock: true,
                          isAnimate: erStartSelected,
                          initialValue: double.tryParse(neuromuscular?.timeB ?? '1'),
                          maxValue: 30,
                          indexType: 2005,
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
                          enabled: erStartSelected,
                          type: TreatmentType.neuromuscular,
                          isInt: true,
                          title: Globalization.intensity.tr,
                          assets: 'assets/images/2.0x/icon_qiangdu.png',
                          initialValue: double.tryParse(neuromuscular?.powerB ?? '0'),
                          minValue: 0,
                          maxValue: 99,
                          valueListener: (value) {
                            neuromuscular?.powerB = value.toString();
                            neuromuscular?.start2(true);
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 90.h,
                          enabled: !erStartSelected,
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
                          width: 120.w,
                          height: 45.h,
                          margin: EdgeInsets.only(top: 10.h),
                          decoration: BoxDecoration(
                              color: erStartSelected ? const Color(0xFF00C290) : const Color(0xFF00A8E7),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.w),
                              )),
                          child: TextButton(
                              onPressed: (){
                                erStartSelected = neuromuscular
                                    ?.start2(!erStartSelected) ??
                                    false;
                                electrotherapyIsRunIng = erStartSelected||yiStartSelected;
                                eventBus.fire(Notify());
                                if (!erStartSelected) {
                                  neuromuscular?.setBRestValue();
                                  Future.delayed(const Duration(milliseconds: 500), () {
                                    eventBus.fire(SetValueState(TreatmentType.neuromuscular));
                                  });
                                }
                                setState(() {
                                  //点击开始治疗
                                  double? tmp = double.tryParse(neuromuscular?.timeB ?? '1');
                                  _countdownTime2 = ((tmp?.toInt())!);
                                  startCountdownTimer2(erStartSelected);
                                });
                              },
                              // child: Image.asset(erStartSelected ? 'assets/images/2.0x/btn_tingzhi_nor.png' : 'assets/images/2.0x/btn_kaishi_nor.png',fit: BoxFit.cover,width: 120.w,height: 45.h,)
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
