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
import 'package:zhwlzlxt_project/entity/jingLuan_entity.dart';

import '../entity/set_value_state.dart';
import '../entity/ultrasonic_sound.dart';
import '../utils/event_bus.dart';
import '../utils/sp_utils.dart';
import '../utils/treatment_type.dart';
import '../widget/set_value_horizontal.dart';
import 'control_page.dart';

class JingLuanPage extends StatefulWidget {
  const JingLuanPage({Key? key}) : super(key: key);

  @override
  State<JingLuanPage> createState() => _JingLuanPageState();
}

class _JingLuanPageState extends State<JingLuanPage>
    with AutomaticKeepAliveClientMixin {
  bool jingStartSelected = true;
  bool startSelected = false;

  Spastic? spastic;

  //计时器
  Timer? _timer;
  int _countdownTime = 0;

  @override
  void initState() {
    super.initState();
    spastic = Spastic();
    spastic?.init(false);

    eventBus.on<TreatmentType>().listen((event) {
      if (!mounted) {
        return;
      }
      spastic?.user = userMap[TreatmentType.spasm];
    });

    // eventBus.on<UserEvent>().listen((event) {
    //   if (event.type == TreatmentType.spasm) {
    //     spastic?.userId = event.user?.userId;
    //     spastic?.user = event.user;
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer?.cancel();
    }
  }

  void startCountdownTimer(bool startSelected) {
    if (_timer != null) {
      _timer?.cancel();
    }

    if (!startSelected) {
      _timer?.cancel();
      return;
    }
    const oneSec = Duration(minutes: 1);
    callback(timer) {
      if (_countdownTime < 1) {
        _timer?.cancel();
        //计时结束
        //结束治疗
        spastic?.init(true);
        spastic?.start(false);
        this.startSelected = false;
        JljCureState = this.startSelected;
        electrotherapyIsRunIng = startSelected;
        eventBus.fire(Notify());
        setState(() {
          Future.delayed(const Duration(milliseconds: 500), () {
            eventBus.fire(SetValueState(TreatmentType.spasm));
          });
          Fluttertoast.showToast(msg: '治疗结束!');
        });
      } else {
        _countdownTime = _countdownTime - 1;
        if (_countdownTime < 1) {
          _timer?.cancel();
          //计时结束
          //结束治疗
          spastic?.init(true);
          spastic?.start(false);
          this.startSelected = false;
          electrotherapyIsRunIng = startSelected;
          JljCureState = this.startSelected;
          eventBus.fire(Notify());
          setState(() {
            Future.delayed(const Duration(milliseconds: 500), () {
              eventBus.fire(SetValueState(TreatmentType.spasm));
            });
            Fluttertoast.showToast(msg: '治疗结束!');
          });
          return;
        }

        spastic?.time = _countdownTime.toString();
        RunTime runTime = RunTime(_countdownTime.toDouble(), 2001);
        eventBus.fire(runTime);
        spastic?.start(startSelected);
      }
    }

    _timer = Timer.periodic(oneSec, callback);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 35.w, right: 35.w),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SetValueHorizontal(
                    enabled: !startSelected,
                    type: TreatmentType.spasm,
                    title: Globalization.time.tr,
                    assets: 'assets/images/2.0x/icon_shijian.png',
                    isClock: true,
                    isAnimate: startSelected,
                    initialValue: double.tryParse(spastic?.time ?? '1'),
                    maxValue: 30,
                    minValue: 1,
                    indexType: 2001,
                    unit: 'min',
                    valueListener: (value) {
                      spastic?.time = value.toString();
                    },
                  ),
                  SetValueHorizontal(
                    enabled: !startSelected,
                    isInt: false,
                    type: TreatmentType.spasm,
                    title: Globalization.pulseWidthA.tr,
                    assets: 'assets/images/2.0x/icon_maikuan.png',
                    initialValue: double.tryParse(spastic?.widthA ?? '0.1'),
                    appreciation: 0.1,
                    minValue: 0.1,
                    maxValue: 0.5,
                    unit: 'ms',
                    valueListener: (value) {
                      spastic?.widthA = value.toString();
                    },
                  ),
                  SetValueHorizontal(
                    enabled: !startSelected,
                    isInt: false,
                    type: TreatmentType.spasm,
                    title: Globalization.pulseWidthB.tr,
                    assets: 'assets/images/2.0x/icon_maikuan.png',
                    initialValue: double.tryParse(spastic?.widthB ?? '0.1'),
                    appreciation: 0.1,
                    minValue: 0.1,
                    maxValue: 0.5,
                    unit: 'ms',
                    valueListener: (value) {
                      spastic?.widthB = value.toString();
                    },
                  ),
                  SetValueHorizontal(
                    enabled: !startSelected,
                    isInt: false,
                    type: TreatmentType.spasm,
                    title: Globalization.delayTime.tr,
                    assets: 'assets/images/2.0x/icon_yanshi.png',
                    initialValue: double.tryParse(spastic?.delayTime ?? '0.1'),
                    appreciation: 0.1,
                    indexType: 10086,
                    maxValue:
                        (double.tryParse(spastic?.circle ?? '1')! - 0.1) > 1.5
                            ? 1.5
                            : (double.tryParse(spastic?.circle ?? '1')! - 0.1),
                    minValue: 0.1,
                    unit: 's',
                    valueListener: (value) {
                      spastic?.delayTime = value.toString();
                    },
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 30.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SetValueHorizontal(
                      enabled: !startSelected,
                      isInt: false,
                      type: TreatmentType.spasm,
                      title: Globalization.pulsePeriod.tr,
                      assets: 'assets/images/2.0x/icon_maichong.png',
                      initialValue: double.tryParse(spastic?.circle ?? '1'),
                      appreciation: 0.1,
                      minValue: 1,
                      maxValue: 2,
                      unit: 's',
                      valueListener: (value) {
                        spastic?.circle = value.toString();
                        if (double.tryParse(spastic?.delayTime ?? '0.1')! >
                            (double.tryParse(spastic?.circle ?? '1')! - 0.1)) {
                          MC mc = MC(
                              double.tryParse(spastic?.circle ?? '1')! - 0.1,
                              10086);
                          eventBus.fire(mc);
                        }
                        setState(() {});
                      },
                    ),
                    SetValueHorizontal(
                      enabled: startSelected,
                      isInt: true,
                      type: TreatmentType.spasm,
                      title: Globalization.intensityA.tr,
                      assets: 'assets/images/2.0x/icon_qiangdu.png',
                      initialValue: double.tryParse(spastic?.powerA ?? '1'),
                      maxValue: 99,
                      minValue: 0,
                      valueListener: (value) {
                        spastic?.powerA = value.toString();
                        spastic?.start(true);
                      },
                    ),
                    SetValueHorizontal(
                      enabled: startSelected,
                      isInt: true,
                      type: TreatmentType.spasm,
                      title: Globalization.intensityB.tr,
                      assets: 'assets/images/2.0x/icon_qiangdu.png',
                      initialValue: double.tryParse(spastic?.powerB ?? '1'),
                      maxValue: 99,
                      minValue: 0,
                      valueListener: (value) {
                        spastic?.powerB = value.toString();
                        spastic?.start(true);
                      },
                    ),
                    Container(
                        width: 340.w,
                        height: 100.h,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                                visible: startSelected,
                                maintainState: false,
                                maintainAnimation: false,
                                maintainSize: false,
                                child: Image.asset(
                                  'assets/images/2.0x/gif_recording.gif',
                                  width: 34.w,
                                  height: 34.h,
                                  fit: BoxFit.fitWidth,
                                )),
                            Container(
                              width: 120.w,
                              height: 55.h,
                              decoration: BoxDecoration(
                                  color: startSelected
                                      ? const Color(0xFF00C290)
                                      : const Color(0xFF00A8E7),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.w),
                                  )),
                              child: TextButton(
                                onPressed: () {
                                  startSelected = !startSelected;
                                  if (!startSelected) {
                                    spastic?.init(true);
                                    Future.delayed(
                                        const Duration(milliseconds: 500), () {
                                      eventBus.fire(
                                          SetValueState(TreatmentType.spasm));
                                    });
                                  }
                                  spastic?.start(startSelected);
                                  electrotherapyIsRunIng = startSelected;
                                  JljCureState = startSelected;
                                  eventBus.fire(Notify());
                                  setState(() {
                                    //点击开始治疗
                                    double? tmp =
                                    double.tryParse(spastic?.time ?? '1');
                                    _countdownTime = ((tmp?.toInt())!);
                                  });
                                  startCountdownTimer(startSelected);
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
                                      startSelected
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
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
