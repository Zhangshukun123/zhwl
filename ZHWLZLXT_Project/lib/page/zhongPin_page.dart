import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/base/globalization.dart';
import 'package:zhwlzlxt_project/base/run_state_page.dart';
import 'package:zhwlzlxt_project/entity/set_value_entity.dart';
import 'package:zhwlzlxt_project/entity/zhongPin_entity.dart';

import '../entity/Electrotherapy.dart';
import '../entity/set_value_state.dart';
import '../entity/ultrasonic_sound.dart';
import '../utils/event_bus.dart';
import '../utils/sp_utils.dart';
import '../utils/treatment_type.dart';
import '../utils/utils_tool.dart';
import '../widget/popup_menu_btn.dart';
import '../widget/set_value_horizontal.dart';

class ZhongPinPage extends StatefulWidget {
  const ZhongPinPage({Key? key}) : super(key: key);

  @override
  State<ZhongPinPage> createState() => _ZhongPinPageState();
}

class _ZhongPinPageState extends State<ZhongPinPage>
    with AutomaticKeepAliveClientMixin {
  bool yiStartSelected = false;
  bool erStartSelected = false;
  bool aliveAuto = false;

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
    midFrequency?.init(false);
    midFrequency?.init2(false);
    midFrequency?.timeA = "20";
    midFrequency?.timeB = "20";
    // eventBus.on<UserEvent>().listen((event) {
    //   if (event.type == TreatmentType.frequency) {
    //     midFrequency?.userId = event.user?.userId;
    //     save(event.user?.userId ?? -1);
    //   }
    // });

    eventBus.on<TreatmentType>().listen((event) {
      if (!mounted) {
        return;
      }
      midFrequency?.user = userMap[TreatmentType.frequency];
    });

    eventBus.on<Electrotherapy>().listen((event) {
      if (yiStartSelected) {
        _timer1?.cancel();
        midFrequency?.init(true);
        midFrequency?.start1(false, false);
        midFrequency?.patternA = "1";
        yiStartSelected = false;
        if (aliveAuto) {
          midFrequency?.init2(false);
          midFrequency?.patternB = "1";
          eventBus.fire(RunTime(20, 2009));
          erStartSelected = false;
          aliveAuto = false;
        }
        electrotherapyIsRunIng = yiStartSelected || erStartSelected;
        ZpgrdCureState = yiStartSelected || erStartSelected;
        eventBus.fire(Notify());
        setState(() {
          eventBus.fire(RunTime(20, 2008));
          Future.delayed(const Duration(milliseconds: 500), () {
            eventBus.fire(SetValueState(TreatmentType.frequency));
          });
        });
      }

      Future.delayed(const Duration(milliseconds: 500), () {
        if (erStartSelected) {
          _timer2?.cancel();
          midFrequency?.init2(true);
          midFrequency?.start2(false);
          midFrequency?.patternB = "1";
          erStartSelected = false;
          electrotherapyIsRunIng = yiStartSelected || erStartSelected;
          ZpgrdCureState = yiStartSelected || erStartSelected;
          setState(() {
            eventBus.fire(RunTime(20, 2009));
            Future.delayed(const Duration(milliseconds: 500), () {
              eventBus.fire(SetValueState(TreatmentType.frequency));
            });
          });
        }
      });

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
    const oneSec = Duration(minutes: 1);
    callback(timer) {
      _countdownTime1 = _countdownTime1 - 1;
      midFrequency?.timeA = _countdownTime1.toString();
      RunTime runTime = RunTime(_countdownTime1.toDouble(), 2008);
      eventBus.fire(runTime);

      if (aliveAuto) {
        RunTime runTime = RunTime(_countdownTime1.toDouble(), 2009);
        eventBus.fire(runTime);
      }

      if (_countdownTime1 < 1) {
        _timer1?.cancel();
        midFrequency?.init(true);
        midFrequency?.start1(false, false);
        midFrequency?.patternA = "1";
        yiStartSelected = false;
        if (aliveAuto) {
          midFrequency?.init2(false);
          midFrequency?.patternB = "1";
          eventBus.fire(RunTime(20, 2009));
          erStartSelected = false;
          aliveAuto = false;
        }
        electrotherapyIsRunIng = yiStartSelected || erStartSelected;
        ZpgrdCureState = yiStartSelected || erStartSelected;
        eventBus.fire(Notify());
        setState(() {
          eventBus.fire(RunTime(20, 2008));
          Future.delayed(const Duration(milliseconds: 500), () {
            eventBus.fire(SetValueState(TreatmentType.frequency));
          });
          showToastMsg(msg: Globalization.endOfTreatment.tr);
        });
        return;
      }

      midFrequency?.start1(yiStartSelected, false);
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
      midFrequency?.timeB = _countdownTime2.toString();
      RunTime runTime = RunTime(_countdownTime2.toDouble(), 2009);
      eventBus.fire(runTime);
      if (_countdownTime2 < 1) {
        _timer2?.cancel();
        midFrequency?.init2(true);
        midFrequency?.start2(false);
        midFrequency?.patternB = "1";
        erStartSelected = false;
        electrotherapyIsRunIng = yiStartSelected || erStartSelected;
        ZpgrdCureState = yiStartSelected || erStartSelected;
        setState(() {
          eventBus.fire(RunTime(20, 2009));
          Future.delayed(const Duration(milliseconds: 500), () {
            eventBus.fire(SetValueState(TreatmentType.frequency));
          });
          showToastMsg(msg: Globalization.endOfTreatment.tr);
        });
        return;
      }
      midFrequency?.start2(erStartSelected);
    }

    _timer2 = Timer.periodic(oneSec, callback);
  }

  @override
  Widget build(BuildContext context) {
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
                  margin: EdgeInsets.only(top: 11.h),
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
                                //20 22 23
                                index: 7,
                                patternStr: midFrequency?.patternA ?? "1",
                                enabled: !yiStartSelected,
                                popupListener: (value) {
                                  if ((int.parse(value) > 50) &&
                                      erStartSelected) {
                                    setState(() {});
                                    showToastMsg(
                                        msg: Globalization.hint_020.tr);
                                    return;
                                  }
                                  midFrequency?.patternA = value;
                                  aliveAuto = (int.parse(value) > 50);
                                  setState(() {});
                                  if (aliveAuto) {
                                    midFrequency?.patternB = value;
                                    eventBus.fire(SetValueEntity(
                                      value: double.tryParse(
                                          midFrequency?.timeA ?? '1'),
                                      power: -1,
                                    ));
                                  }
                                  if (!aliveAuto &&
                                      int.parse(midFrequency?.patternB ?? '1') >
                                          50) {
                                    midFrequency?.patternB = value;
                                    if (value == "20" ||
                                        value == "22" ||
                                        value == "23") {
                                      midFrequency?.timeB = "30";
                                      RunTime runTime = RunTime(30, 2009);
                                      eventBus.fire(runTime);
                                    } else {
                                      midFrequency?.timeB = "20";
                                      RunTime runTime = RunTime(20, 2009);
                                      eventBus.fire(runTime);
                                    }
                                  }
                                  if (value == "20" ||
                                      value == "22" ||
                                      value == "23") {
                                    midFrequency?.timeA = "30";
                                    RunTime runTime = RunTime(30, 2008);
                                    eventBus.fire(runTime);
                                  } else {
                                    midFrequency?.timeA = "20";
                                    if (aliveAuto) {
                                      midFrequency?.timeB = "20";
                                      RunTime runTime = RunTime(20, 2009);
                                      eventBus.fire(runTime);
                                    }
                                    RunTime runTime = RunTime(20, 2008);
                                    eventBus.fire(runTime);
                                  }
                                  setState(() {});
                                },
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 120.h,
                          enabled: false,
                          isVisJa: false,
                          type: TreatmentType.frequency,
                          title: Globalization.time.tr,
                          indexType: 2008,
                          assets: 'assets/images/2.0x/icon_shijian.png',
                          isClock: true,
                          isAnimate: aliveAuto
                              ? electrotherapyIsRunIng
                              : yiStartSelected,
                          initialValue:
                              double.tryParse(midFrequency?.timeA ?? '1'),
                          minValue: 1,
                          maxValue: 30,
                          unit: 'min',
                          valueListener: (value) {
                            midFrequency?.timeA = value.toString();
                            if (aliveAuto) {
                              midFrequency?.timeB = value.toString();
                              eventBus.fire(
                                  SetValueEntity(value: value, power: -1));
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 120.h,
                          enabled: yiStartSelected,
                          indexType: 13,
                          type: TreatmentType.frequency,
                          title: Globalization.intensity.tr,
                          assets: 'assets/images/2.0x/icon_qiangdu.png',
                          initialValue:
                              double.tryParse(midFrequency?.powerA ?? '0'),
                          maxValue: 99,
                          minValue: 0,
                          valueListener: (value) {
                            midFrequency?.powerA = value.toString();
                            if (aliveAuto) {
                              midFrequency?.powerB = value.toString();
                              eventBus.fire(
                                  SetValueEntity(power: value, value: -1));
                            }
                            midFrequency?.start1(true, false);
                          },
                        ),
                      ),
                      Row(
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
                                  midFrequency?.init(true);
                                  if (aliveAuto) {
                                    erStartSelected = yiStartSelected;
                                    midFrequency?.init2(true);
                                    midFrequency?.timeB = "20";
                                    midFrequency?.patternB = "1";
                                    aliveAuto = false;
                                    electrotherapyIsRunIng =
                                        yiStartSelected || erStartSelected;
                                  }
                                  Future.delayed(
                                      const Duration(milliseconds: 500), () {
                                    eventBus.fire(
                                        SetValueState(TreatmentType.frequency));
                                  });
                                }
                                midFrequency?.start1(
                                    yiStartSelected, yiStartSelected, back: () {
                                  electrotherapyIsRunIng =
                                      yiStartSelected || erStartSelected;
                                  eventBus.fire(Notify());
                                  ZpgrdCureState =
                                      yiStartSelected || erStartSelected;
                                  setState(() {
                                    double? tmp = double.tryParse(
                                        midFrequency?.timeA ?? '1');
                                    _countdownTime1 = ((tmp?.toInt())!);
                                    startCountdownTimer1(yiStartSelected);
                                  });


                                  if (!yiStartSelected) {
                                    midFrequency?.patternA = "1";
                                  }
                                  if (aliveAuto) {
                                    erStartSelected = yiStartSelected;
                                  }

                                }, finish: () {
                                  yiStartSelected = false;
                                  if (aliveAuto) {
                                    erStartSelected = false;
                                  }
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
                                enabled: !erStartSelected,
                                popupListener: (value) {
                                  if ((int.parse(value) > 50) &&
                                      yiStartSelected) {
                                    setState(() {});
                                    showToastMsg(
                                        msg: Globalization.hint_020.tr);
                                    return;
                                  }
                                  midFrequency?.patternB = value;
                                  aliveAuto = (int.parse(value) > 50);
                                  if (aliveAuto) {
                                    midFrequency?.patternA = value;
                                  }
                                  if (!aliveAuto &&
                                      int.parse(midFrequency?.patternA ?? '1') >
                                          50) {
                                    midFrequency?.patternA = value;
                                    if (value == "20" ||
                                        value == "22" ||
                                        value == "23") {
                                      midFrequency?.timeA = "30";
                                      RunTime runTime = RunTime(30, 2008);
                                      eventBus.fire(runTime);
                                    } else {
                                      midFrequency?.timeA = "20";
                                      RunTime runTime = RunTime(20, 2008);
                                      eventBus.fire(runTime);
                                    }
                                  }
                                  if (value == "20" ||
                                      value == "22" ||
                                      value == "23") {
                                    midFrequency?.timeB = "30";
                                    RunTime runTime = RunTime(30, 2009);
                                    eventBus.fire(runTime);
                                  } else {
                                    midFrequency?.timeB = "20";
                                    if (aliveAuto) {
                                      midFrequency?.timeA = "20";
                                      RunTime runTime1 = RunTime(20, 2008);
                                      eventBus.fire(runTime1);
                                    }
                                    RunTime runTime = RunTime(20, 2009);
                                    eventBus.fire(runTime);
                                  }
                                  setState(() {});
                                },
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 120.h,
                          enabled: false,
                          isVisJa: false,
                          type: TreatmentType.frequency,
                          title: Globalization.time.tr,
                          indexType: 2009,
                          assets: 'assets/images/2.0x/icon_shijian.png',
                          isClock: true,
                          isAnimate: aliveAuto
                              ? electrotherapyIsRunIng
                              : erStartSelected,
                          initialValue:
                              double.tryParse(midFrequency?.timeB ?? '1'),
                          maxValue: 30,
                          minValue: 1,
                          unit: 'min',
                          valueListener: (value) {
                            midFrequency?.timeB = value.toString();
                            if (aliveAuto) {
                              midFrequency?.timeA = value.toString();
                              eventBus.fire(
                                  SetValueEntity(value: value, power: -1));
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 120.h,
                          enabled: erStartSelected,
                          indexType: 13,
                          type: TreatmentType.frequency,
                          title: Globalization.intensity.tr,
                          assets: 'assets/images/2.0x/icon_qiangdu.png',
                          initialValue:
                              double.tryParse(midFrequency?.powerB ?? '0'),
                          maxValue: 99,
                          minValue: 0,
                          valueListener: (value) {
                            midFrequency?.powerB = value.toString();
                            if (aliveAuto) {
                              midFrequency?.powerA = value.toString();
                              eventBus.fire(
                                  SetValueEntity(value: -1, power: value));
                              midFrequency?.start1(true, false);
                            } else {
                              midFrequency?.start2(true);
                            }
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
                                if (!aliveAuto) {
                                  erStartSelected = !erStartSelected;

                                  if (!erStartSelected) {
                                    midFrequency?.init2(true);
                                    Future.delayed(
                                        const Duration(milliseconds: 500), () {
                                      eventBus.fire(SetValueState(
                                          TreatmentType.frequency));
                                    });
                                  }
                                  midFrequency?.start2(erStartSelected,
                                      isOpenStart: true, back: () {
                                    electrotherapyIsRunIng =
                                        yiStartSelected || erStartSelected;
                                    eventBus.fire(Notify());
                                    ZpgrdCureState =
                                        yiStartSelected || erStartSelected;
                                    setState(() {
                                      //点击开始治疗
                                      double? tmp = double.tryParse(
                                          midFrequency?.timeB ?? '1');
                                      _countdownTime2 = ((tmp?.toInt())!);
                                      startCountdownTimer2(erStartSelected);

                                      if (!erStartSelected) {
                                        midFrequency?.patternB = "1";
                                      }

                                    });
                                  }, finish: () {
                                    erStartSelected = false;
                                    setState(() {});
                                  });

                                } else {
                                  yiStartSelected = !yiStartSelected;
                                  erStartSelected = !erStartSelected;
                                  if (!yiStartSelected) {
                                    midFrequency?.init(true);
                                    midFrequency?.init2(true);
                                    aliveAuto = false;
                                    Future.delayed(
                                        const Duration(milliseconds: 500), () {
                                      eventBus.fire(SetValueState(
                                          TreatmentType.frequency));
                                    });
                                  }
                                  midFrequency
                                      ?.start1(yiStartSelected, yiStartSelected,
                                          back: () {
                                    electrotherapyIsRunIng =
                                        yiStartSelected || erStartSelected;
                                    eventBus.fire(Notify());
                                    ZpgrdCureState =
                                        yiStartSelected || erStartSelected;
                                    erStartSelected = yiStartSelected;
                                    setState(() {
                                      //点击开始治疗
                                      double? tmp = double.tryParse(
                                          midFrequency?.timeA ?? '1');
                                      _countdownTime1 = ((tmp?.toInt())!);
                                      startCountdownTimer1(yiStartSelected);

                                      if (!yiStartSelected) {
                                        midFrequency?.timeA = "20";
                                        midFrequency?.timeB = "20";
                                        midFrequency?.patternA = "1";
                                        midFrequency?.patternB = "1";
                                      }

                                    });
                                  }, finish: () {
                                    yiStartSelected = false;
                                    erStartSelected = false;
                                    setState(() {});
                                  });

                                }
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
