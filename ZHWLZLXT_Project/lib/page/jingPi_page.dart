import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zhwlzlxt_project/base/globalization.dart';
import 'package:zhwlzlxt_project/base/run_state_page.dart';
import 'package:zhwlzlxt_project/widget/container_bg.dart';

import '../entity/Electrotherapy.dart';
import '../entity/jingPi_entity.dart';
import '../entity/set_value_state.dart';
import '../entity/ultrasonic_sound.dart';
import '../utils/event_bus.dart';
import '../utils/sp_utils.dart';
import '../utils/treatment_type.dart';
import '../utils/utils_tool.dart';
import '../widget/popup_menu_btn.dart';
import '../widget/set_value_horizontal.dart';
import 'control_page.dart';

class JingPiPage extends StatefulWidget {
  const JingPiPage({Key? key}) : super(key: key);

  @override
  State<JingPiPage> createState() => _JingPiPageState();
}

class _JingPiPageState extends State<JingPiPage>
    with AutomaticKeepAliveClientMixin {
  bool yiStartSelected = false;
  bool erStartSelected = false;

  Percutaneous? percutaneous;

  //计时器
  Timer? _timer1;
  int _countdownTime1 = 0;

  Timer? _timer2;
  int _countdownTime2 = 0;

  @override
  void initState() {
    super.initState();
    percutaneous = Percutaneous();
    percutaneous?.init(false);
    percutaneous?.initB(false);
    percutaneous?.timeA = "20";
    percutaneous?.timeB = "20";
    eventBus.on<TreatmentType>().listen((event) {
      if (!mounted) {
        return;
      }
      percutaneous?.user = userMap[TreatmentType.percutaneous];
    });
    eventBus.on<Language>().listen((event) {
      percutaneous?.init(false);
      percutaneous?.initB(false);
      setState(() {});
    });

    eventBus.on<Electrotherapy>().listen((event) {
      if (yiStartSelected && event.channel == 9) {
        _timer1?.cancel();
        percutaneous?.init(true);
        percutaneous?.start1(false, false);
        yiStartSelected = false;
        electrotherapyIsRunIng = yiStartSelected || erStartSelected;
        JpsjCureState = yiStartSelected || erStartSelected;
        eventBus.fire(Notify());
        setState(() {
          RunTime runTime = RunTime(double.tryParse('20'), 2002);
          eventBus.fire(runTime);
          Future.delayed(const Duration(milliseconds: 500), () {
            eventBus.fire(SetValueState(TreatmentType.percutaneous));
          });
        });
      }
      if (erStartSelected && event.channel == 10) {
        _timer2?.cancel();
        percutaneous?.initB(true);
        percutaneous?.start2(false, false);
        erStartSelected = false;
        electrotherapyIsRunIng = yiStartSelected || erStartSelected;
        JpsjCureState = yiStartSelected || erStartSelected;
        setState(() {
          RunTime runTime = RunTime(double.tryParse('20'), 2002);
          eventBus.fire(runTime);
          Future.delayed(const Duration(milliseconds: 500), () {
            eventBus.fire(SetValueState(TreatmentType.percutaneous));
          });
        });
      }
    });
  }

  void save(int userId) {
    SpUtils.set(PercutaneousField.PercutaneousKey, userId);
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
      _countdownTime1 = _countdownTime1 - 1;
      percutaneous?.timeA = _countdownTime1.toString();
      RunTime runTime = RunTime(_countdownTime1.toDouble(), 2002);
      eventBus.fire(runTime);
      if (_countdownTime1 < 1) {
        _timer1?.cancel();
        percutaneous?.init(true);
        percutaneous?.start1(false, false);
        yiStartSelected = false;
        electrotherapyIsRunIng = yiStartSelected || erStartSelected;
        JpsjCureState = yiStartSelected || erStartSelected;
        eventBus.fire(Notify());
        setState(() {
          RunTime runTime = RunTime(double.tryParse('20'), 2002);
          eventBus.fire(runTime);
          showToastMsg(msg: Globalization.endOfTreatment.tr);
          Future.delayed(const Duration(milliseconds: 500), () {
            eventBus.fire(SetValueState(TreatmentType.percutaneous));
          });
        });
        return;
      }
      percutaneous?.start1(yiStartSelected, false);
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
      _countdownTime2 = _countdownTime2 - 1;
      percutaneous?.timeB = _countdownTime2.toString();
      RunTime runTime = RunTime(_countdownTime2.toDouble(), 2003);
      eventBus.fire(runTime);
      if (_countdownTime2 < 1) {
        _timer2?.cancel();
        percutaneous?.initB(true);
        percutaneous?.start2(false, false);
        erStartSelected = false;
        electrotherapyIsRunIng = yiStartSelected || erStartSelected;
        JpsjCureState = yiStartSelected || erStartSelected;
        setState(() {
          RunTime runTime = RunTime(double.tryParse('20'), 2003);
          eventBus.fire(runTime);
          showToastMsg(msg: Globalization.endOfTreatment.tr);
          Future.delayed(const Duration(milliseconds: 500), () {
            eventBus.fire(SetValueState(TreatmentType.percutaneous));
          });
        });
        return;
      }
      percutaneous?.start2(erStartSelected, false);
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
                  height: 487.h,
                  margin: EdgeInsets.only(top: 9.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ContainerBg(
                          width: 340.w,
                          height: 70.h,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
                                child: TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Image.asset(
                                            'assets/images/2.0x/icon_moshi.png',
                                            fit: BoxFit.fitWidth,
                                            width: 15.w),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Text(
                                          Globalization.mode.tr,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0xFF999999)),
                                        ),
                                      ],
                                    )),
                              ),
                              PopupMenuBtn(
                                index: 3,
                                patternStr: percutaneous?.patternA ??
                                    Globalization.continuous.tr,
                                enabled: !yiStartSelected,
                                popupListener: (value) {
                                  percutaneous?.patternA = value;
                                },
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 70.h,
                          type: TreatmentType.percutaneous,
                          enabled: !yiStartSelected,
                          title: Globalization.time.tr,
                          isClock: true,
                          isAnimate: yiStartSelected,
                          assets: 'assets/images/2.0x/icon_shijian.png',
                          initialValue:
                              double.tryParse(percutaneous?.timeA ?? '1'),
                          minValue: 1,
                          indexType: 2002,
                          maxValue: 30,
                          unit: 'min',
                          valueListener: (value) {
                            percutaneous?.timeA = value.toString();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 70.h,
                          enabled: yiStartSelected,
                          type: TreatmentType.percutaneous,
                          title: Globalization.intensity.tr,
                          assets: 'assets/images/2.0x/icon_qiangdu.png',
                          initialValue:
                              double.tryParse(percutaneous?.powerA ?? '1'),
                          maxValue: 99,
                          minValue: 0,
                          valueListener: (value) {
                            percutaneous?.powerA = value.toString();
                            percutaneous?.start1(true, false);
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 70.h,
                          enabled: !yiStartSelected,
                          type: TreatmentType.percutaneous,
                          title: Globalization.frequency.tr,
                          assets: 'assets/images/2.0x/icon_pinlv.png',
                          initialValue:
                              double.tryParse(percutaneous?.frequencyA ?? '2'),
                          minValue: 2,
                          maxValue: 160,
                          unit: 'Hz',
                          valueListener: (value) {
                            percutaneous?.frequencyA = value.toString();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 70.h,
                          enabled: !yiStartSelected,
                          type: TreatmentType.percutaneous,
                          title: Globalization.pulseWidth.tr,
                          assets: 'assets/images/2.0x/icon_maikuan.png',
                          initialValue:
                              double.tryParse(percutaneous?.pulseA ?? '60'),
                          minValue: 60,
                          maxValue: 520,
                          appreciation: 10,
                          unit: 'μs',
                          valueListener: (value) {
                            percutaneous?.pulseA = value.toString();
                          },
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                                visible: yiStartSelected,
                                maintainState: false,
                                maintainAnimation: false,
                                maintainSize: false,
                                child: Container(
                                    margin: EdgeInsets.only(top: 10.h),
                                    child: Image.asset(
                                      'assets/images/2.0x/gif_recording.gif',
                                      width: 34.w,
                                      height: 34.h,
                                      fit: BoxFit.fitWidth,
                                    ))),
                            Container(
                              width: 120.w,
                              height: 45.h,
                              margin: EdgeInsets.only(top: 10.h),
                              decoration: BoxDecoration(
                                  color: yiStartSelected
                                      ? const Color(0xFF00C290)
                                      : const Color(0xFF00A8E7),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.w),
                                  )),
                              child: TextButton(
                                onPressed: () {
                                  yiStartSelected = !yiStartSelected;
                                  if (!yiStartSelected) {
                                    percutaneous?.init(true);
                                    Future.delayed(
                                        const Duration(milliseconds: 500), () {
                                      eventBus.fire(SetValueState(
                                          TreatmentType.percutaneous));
                                    });
                                  }
                                  percutaneous
                                      ?.start1(yiStartSelected, yiStartSelected,
                                          back: () {
                                    electrotherapyIsRunIng =
                                        yiStartSelected || erStartSelected;
                                    eventBus.fire(Notify());
                                    JpsjCureState =
                                        yiStartSelected || erStartSelected;
                                    setState(() {
                                      //点击开始治疗
                                      double? tmp = double.tryParse(
                                          percutaneous?.timeA ?? '1');
                                      _countdownTime1 = ((tmp?.toInt())!);
                                      startCountdownTimer1(yiStartSelected);
                                    });
                                  }, finish: () {
                                    yiStartSelected = false;
                                    electrotherapyIsRunIng =
                                        yiStartSelected || erStartSelected;
                                    eventBus.fire(Notify());
                                    JpsjCureState =
                                        yiStartSelected || erStartSelected;
                                    setState(() {});
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
                                    Image.asset(
                                      'assets/images/2.0x/icon_kaishi.png',
                                      fit: BoxFit.fitWidth,
                                      width: 18.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      yiStartSelected
                                          ? Globalization.stop.tr
                                          : Globalization.start.tr,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
                  height: 487.h,
                  // color: Colors.white,
                  // decoration: const BoxDecoration(
                  //   image: DecorationImage(
                  //       image: AssetImage('assets/images/2.0x/img_tongdaoyi.png'),
                  //     fit: BoxFit.contain,
                  //   ),
                  // ),
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
                              )),
                          width: 340.w,
                          height: 70.h,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
                                child: TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/2.0x/icon_moshi.png',
                                          fit: BoxFit.fitWidth,
                                          width: 15.w,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Text(
                                          Globalization.mode.tr,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0xFF999999)),
                                        ),
                                      ],
                                    )),
                              ),
                              PopupMenuBtn(
                                index: 3,
                                patternStr: percutaneous?.patternB ??
                                    Globalization.continuous.tr,
                                enabled: !erStartSelected,
                                popupListener: (value) {
                                  percutaneous?.patternB = value;
                                },
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 70.h,
                          enabled: !erStartSelected,
                          type: TreatmentType.percutaneous,
                          title: Globalization.time.tr,
                          assets: 'assets/images/2.0x/icon_shijian.png',
                          isClock: true,
                          isAnimate: erStartSelected,
                          initialValue:
                              double.tryParse(percutaneous?.timeB ?? '1'),
                          maxValue: 30,
                          indexType: 2003,
                          minValue: 1,
                          unit: 'min',
                          valueListener: (value) {
                            percutaneous?.timeB = value.toString();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 70.h,
                          enabled: erStartSelected,
                          type: TreatmentType.percutaneous,
                          title: Globalization.intensity.tr,
                          assets: 'assets/images/2.0x/icon_qiangdu.png',
                          initialValue:
                              double.tryParse(percutaneous?.powerB ?? '0'),
                          maxValue: 99,
                          minValue: 0,
                          valueListener: (value) {
                            percutaneous?.powerB = value.toString();
                            percutaneous?.start2(true, false);
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 70.h,
                          enabled: !erStartSelected,
                          type: TreatmentType.percutaneous,
                          title: Globalization.frequency.tr,
                          assets: 'assets/images/2.0x/icon_pinlv.png',
                          initialValue:
                              double.tryParse(percutaneous?.frequencyB ?? '2'),
                          minValue: 2,
                          maxValue: 160,
                          unit: 'Hz',
                          valueListener: (value) {
                            percutaneous?.frequencyB = value.toString();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 70.h,
                          enabled: !erStartSelected,
                          type: TreatmentType.percutaneous,
                          title: Globalization.pulseWidth.tr,
                          assets: 'assets/images/2.0x/icon_maikuan.png',
                          initialValue:
                              double.tryParse(percutaneous?.pulseB ?? '60'),
                          minValue: 60,
                          maxValue: 520,
                          appreciation: 10,
                          unit: 'μs',
                          valueListener: (value) {
                            percutaneous?.pulseB = value.toString();
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                              visible: erStartSelected,
                              maintainState: false,
                              maintainAnimation: false,
                              maintainSize: false,
                              child: Container(
                                  margin: EdgeInsets.only(top: 10.h),
                                  child: Image.asset(
                                    'assets/images/2.0x/gif_recording.gif',
                                    width: 34.w,
                                    height: 34.h,
                                    fit: BoxFit.fitWidth,
                                  ))),
                          Container(
                            child: Container(
                              width: 120.w,
                              height: 45.h,
                              margin: EdgeInsets.only(top: 10.h),
                              decoration: BoxDecoration(
                                  color: erStartSelected
                                      ? const Color(0xFF00C290)
                                      : const Color(0xFF00A8E7),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.w),
                                  )),
                              child: TextButton(
                                onPressed: () {
                                  erStartSelected = !erStartSelected;

                                  if (!erStartSelected) {
                                    percutaneous?.initB(true);
                                    Future.delayed(
                                        const Duration(milliseconds: 500), () {
                                      eventBus.fire(SetValueState(
                                          TreatmentType.percutaneous));
                                    });
                                  }

                                  percutaneous
                                      ?.start2(erStartSelected, erStartSelected,
                                          back: () {
                                    electrotherapyIsRunIng =
                                        erStartSelected || yiStartSelected;
                                    eventBus.fire(Notify());
                                    JpsjCureState =
                                        erStartSelected || yiStartSelected;
                                    setState(() {
                                      double? tmp = double.tryParse(
                                          percutaneous?.timeB ?? '1');
                                      _countdownTime2 = ((tmp?.toInt())!);
                                      startCountdownTimer2(erStartSelected);
                                    });
                                  }, finish: () {
                                    erStartSelected = false;
                                    electrotherapyIsRunIng =
                                        erStartSelected || yiStartSelected;
                                    eventBus.fire(Notify());
                                    JpsjCureState =
                                        erStartSelected || yiStartSelected;
                                    setState(() {});
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/2.0x/icon_kaishi.png',
                                      fit: BoxFit.fitWidth,
                                      width: 18.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      erStartSelected
                                          ? Globalization.stop.tr
                                          : Globalization.start.tr,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
