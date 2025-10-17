import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zhwlzlxt_project/base/globalization.dart';
import 'package:zhwlzlxt_project/page/attention_page.dart';
import 'package:zhwlzlxt_project/utils/event_bus.dart';
import 'package:zhwlzlxt_project/utils/treatment_type.dart';
import 'package:zhwlzlxt_project/widget/container_bg.dart';
import 'package:zhwlzlxt_project/page/user_head_view.dart';

import '../Controller/serial_msg.dart';
import '../Controller/serial_port.dart';
import '../Controller/ultrasonic_controller.dart';
import '../base/run_state_page.dart';
import '../entity/port_data.dart';
import '../entity/set_value_state.dart';
import '../entity/ultrasonic_sound.dart';
import '../utils/sp_utils.dart';
import '../utils/treatment_type.dart';
import '../utils/utils_tool.dart';
import '../widget/details_dialog.dart';
import '../widget/popup_menu_btn.dart';
import '../widget/set_value.dart';
import 'control_page.dart';
import 'operate_page.dart';
import '../entity/infrared_entity.dart';

class InfraredPage extends StatefulWidget {
  const InfraredPage({Key? key}) : super(key: key);

  @override
  State<InfraredPage> createState() => _InfraredPageState();
}

class _InfraredPageState extends State<InfraredPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool thirdStartSelected = false;
  bool switchSelected = true;
  bool isScram = false;

  //定义四个页面
  late TabController _tabController;

  DetailsDialog? dialog;

  InfraredEntity? infraredEntity;

//计时器
  Timer? _timer;
  int _countdownTime = 0;

  var isDGW = false;

  @override
  void initState() {
    super.initState();
    dialog = DetailsDialog(
        index: 3); //1:超声疗法；2：脉冲磁疗法；3：红外偏光；4：痉挛肌；5：经皮神经电刺激；6：神经肌肉点刺激；7：中频/干扰电治疗；
    infraredEntity = InfraredEntity();
    infraredEntity?.init(false);
    infraredEntity?.time = "20";
    isDGW = (infraredEntity?.pattern != Globalization.continuous.tr);

    // infraredEntity = InfraredEntity();

    _tabController =
        TabController(length: dialog?.tabs.length ?? 0, vsync: this);
    _tabController.addListener(() {});

    dialog?.setTabController(_tabController);

    // 一定时间内 返回一个数据

    eventBus.on<TreatmentType>().listen((event) {
      if (!mounted) {
        return;
      }
      infraredEntity?.user = userMap[TreatmentType.infrared];
    });

    // checkInfrared();
    eventBus.on<Language>().listen((event) {
      infraredEntity?.init(false);
      setState(() {});
    });

    eventBus.on<MethodCall>().listen((methodCall) {
      switch (methodCall.method) {
        case 'onSendComplete':
          String value = methodCall.arguments;
          if (value.length > 20) {
            if (value.substring(4, 6) == '02') {
              if (value.substring(18, 20) == "01") {
                if (!isScram) {
                  _timer?.cancel();
                  isScram = true;
                  startSelected = false;
                  isDGW = false;
                  infraredEntity?.init(true);
                  infraredEntity?.start(false, false);
                  infraredEntity?.time = "20";
                  Future.delayed(const Duration(milliseconds: 500), () {
                    eventBus.fire(SetValueState(TreatmentType.infrared));
                  });
                  HwpzgCureState = startSelected;
                  infraredEntity?.user?.isCure = false;
                  setState(() {});
                }
              } else {
                if (isScram) {
                  isScram = false;
                  setState(() {});
                }
              }
            }
          }
          break;
        case 'openPg':
          if (isScram) {
            showToastMsg(msg: Globalization.hint_019.tr);
            return;
          }
          startSelected = true;
          infraredEntity?.start(startSelected, startSelected,back: (){});
          HwpzgCureState = startSelected;
          infraredEntity?.user?.isCure = startSelected;
          setState(() {
            //点击开始治疗
            double? tmp = double.tryParse(infraredEntity?.time ?? '1');
            _countdownTime = ((tmp?.toInt())!);
            startCountdownTimer(startSelected);
          });

          break;
        case 'closePg':
          _timer?.cancel();
          //计时结束
          infraredEntity?.init(true);
          infraredEntity?.start(false, false);
          Future.delayed(const Duration(milliseconds: 500), () {
            eventBus.fire(SetValueState(TreatmentType.infrared));
          });
          startSelected = false;
          isDGW = false;
          HwpzgCureState = startSelected;
          infraredEntity?.user?.isCure = startSelected;
          setState(() {
            RunTime runTime = RunTime(20, 1003);
            eventBus.fire(runTime);
            showToastMsg(msg: Globalization.endOfTreatment.tr);
          });
          break;
        case 'sendPg':
          infraredEntity?.start(startSelected, startSelected);
          break;
      }
    });
  }

  void save(int userId) {
    SpUtils.set(InfraredField.InfraredKey, userId);
  }

  bool startSelected = false;

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer?.cancel();
    }
    if (_timerCheck != null) {
      _timerCheck?.cancel();
    }
  }

  void startCountdownTimer(bool startSelected) {
    if (_countdownTime < 1) {
      _timer?.cancel();
      //计时结束
      infraredEntity?.init(true);
      infraredEntity?.start(false, false);
      Future.delayed(const Duration(milliseconds: 500), () {
        eventBus.fire(SetValueState(TreatmentType.infrared));
      });
      this.startSelected = false;
      isDGW = false;
      HwpzgCureState = this.startSelected;
      infraredEntity?.user?.isCure = this.startSelected;
      setState(() {
        RunTime runTime = RunTime(20, 1003);
        eventBus.fire(runTime);
        showToastMsg(msg: Globalization.endOfTreatment.tr);
      });
      return;
    }

    if (_timer != null) {
      _timer?.cancel();
    }

    if (!startSelected) {
      _timer?.cancel();
      return;
    }
    const oneSec = Duration(minutes: 1);
    callback(timer) {
      _countdownTime = _countdownTime - 1;
      infraredEntity?.time = _countdownTime.toString();
      RunTime runTime = RunTime(_countdownTime.toDouble(), 1003);
      eventBus.fire(runTime);
      if (_countdownTime < 1) {
        _timer?.cancel();
        //计时结束
        infraredEntity?.init(true);
        infraredEntity?.start(false, false);
        Future.delayed(const Duration(milliseconds: 500), () {
          eventBus.fire(SetValueState(TreatmentType.infrared));
        });
        this.startSelected = false;
        HwpzgCureState = this.startSelected;
        isDGW = false;
        infraredEntity?.user?.isCure = this.startSelected;
        setState(() {
          RunTime runTime = RunTime(20, 1003);
          eventBus.fire(runTime);
          showToastMsg(msg: Globalization.endOfTreatment.tr);
        });
        return;
      }
      infraredEntity?.start(startSelected, false);
    }

    _timer = Timer.periodic(oneSec, callback);
  }

  Timer? _timerCheck;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            UserHeadView(
              type: TreatmentType.infrared,
            ),
            Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 35.w, right: 35.w, top: 17.5.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ContainerBg(
                        width: 416.w,
                        height: 150.h,
                        child: SetValue(
                          enabled: !startSelected,
                          type: TreatmentType.infrared,
                          title: Globalization.time.tr,
                          assets: 'assets/images/2.0x/icon_shijian.png',
                          isClock: true,
                          isAnimate: startSelected,
                          initialValue:
                              double.tryParse(infraredEntity?.time ?? '12'),
                          maxValue: 99,
                          indexType: 1003,
                          minValue: 0,
                          unit: 'min',
                          valueListener: (value) {
                            infraredEntity?.time = value.toString();
                          },
                        ),
                      ),
                      ContainerBg(
                          margin: EdgeInsets.only(top: 25.h),
                          width: 416.w,
                          height: 150.h,
                          child: SetValue(
                            enabled: startSelected,
                            type: TreatmentType.infrared,
                            isEventBus: true,
                            title: Globalization.intensity.tr,
                            assets: 'assets/images/2.0x/icon_qiangdu.png',
                            initialValue:
                                double.tryParse(infraredEntity?.power ?? '1'),
                            maxValue: 8,
                            indexType: 10098,
                            minValue: isDGW ? 2 : 1,
                            isInt: true,
                            appreciation: 1,
                            valueListener: (value) {
                              infraredEntity?.power = value.toString();
                              if (startSelected) {
                                infraredEntity?.start(startSelected, false);
                              }
                            },
                          )),
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
                          margin: EdgeInsets.only(top: 25.h),
                          width: 416.w,
                          height: 150.h,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 29.h),
                                width: (Get.locale?.countryCode == "CN")
                                    ? 90.w
                                    : 100.w,
                                child: TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/2.0x/icon_moshi.png',
                                          fit: BoxFit.fitWidth,
                                          width: 16.w,
                                          height: 16.h,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          Globalization.mode.tr,
                                          style: TextStyle(
                                              fontSize: 24.sp,
                                              color: const Color(0xFF999999)),
                                        ),
                                      ],
                                    )),
                              ),
                              PopupMenuBtn(
                                index: 2,
                                patternStr: infraredEntity?.pattern ??
                                    Globalization.continuous.tr,
                                enabled: !startSelected,
                                popupListener: (value) {
                                  isDGW =
                                      (value != Globalization.continuous.tr);
                                  if (isDGW) {
                                    eventBus.fire(Infrared());
                                    eventBus.fire(RunTime(2, 10098));
                                    infraredEntity?.power = '2';
                                  } else {
                                    eventBus.fire(Infrared());
                                    eventBus.fire(RunTime(1, 10098));
                                    infraredEntity?.power = '1';
                                  }
                                  infraredEntity?.pattern = value;
                                  setState(() {});
                                },
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 17.5.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          width: 260.w,
                          height: 235.h,
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
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 30.h),
                                height: 100.h,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      isScram
                                          ? 'assets/images/2.0x/icon_jiting.png'
                                          : 'assets/images/2.0x/icon_zhengchang.png',
                                      fit: BoxFit.fitHeight,
                                      height: 100.h,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10.h),
                                child: Text(
                                  isScram
                                      ? Globalization.currEmStSt.tr
                                      : Globalization.infrared_start_onLine.tr,
                                  style: TextStyle(
                                      color: isScram
                                          ? const Color(0xFFFD5F1F)
                                          : Colors.black,
                                      fontSize: 18.sp),
                                ),
                              ),
                            ],
                          )),
                      Container(
                          width: 260.w,
                          height: 235.h,
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
                          margin: EdgeInsets.only(top: 30.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: (Get.locale?.countryCode == "CN")
                                    ? 78.w
                                    : 100.w,
                                margin: EdgeInsets.only(top: 15.5.h),
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/2.0x/img_xiangqing.png'),
                                  fit: BoxFit.fill, // 完全填充
                                )),
                                child: TextButton(
                                    onPressed: () {
                                      dialog?.showCustomDialog(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                          'assets/images/2.0x/icon_xiangqing.png',
                                          fit: BoxFit.fill,
                                          width: 18.w,
                                          height: 18.h,
                                        ),
                                        Text(
                                          Globalization.details.tr,
                                          style: TextStyle(
                                              color: const Color(0xFF009CB4),
                                              fontSize: 18.sp),
                                        ),
                                      ],
                                    )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Visibility(
                                      visible: startSelected,
                                      maintainState: false,
                                      maintainAnimation: false,
                                      maintainSize: false,
                                      child: Container(
                                          margin: EdgeInsets.only(top: 42.5.h),
                                          child: Image.asset(
                                            'assets/images/2.0x/gif_recording.gif',
                                            width: 34.w,
                                            height: 34.h,
                                            fit: BoxFit.fitWidth,
                                          ))),
                                  Container(
                                    margin: EdgeInsets.only(top: 50.5.h),
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
                                        EasyThrottle.throttle('start-btn2', const Duration(seconds: 1), () {
                                          if (isScram) {
                                            showToastMsg(
                                                msg: Globalization.hint_019.tr);
                                            return;
                                          }
                                          startSelected = !startSelected;
                                          if (!startSelected) {
                                            infraredEntity?.init(true);
                                            isDGW = false;
                                            Future.delayed(
                                                const Duration(milliseconds: 500),
                                                    () {
                                                  eventBus.fire(SetValueState(
                                                      TreatmentType.infrared));
                                                });
                                          }
                                          infraredEntity?.start(
                                              startSelected, startSelected,
                                              back: () {
                                                HwpzgCureState = startSelected;
                                                infraredEntity?.user?.isCure = startSelected;
                                                setState(() {
                                                  double? tmp = double.tryParse(
                                                      infraredEntity?.time ?? '1');
                                                  _countdownTime = ((tmp?.toInt())!);
                                                  startCountdownTimer(startSelected);
                                                });
                                              }, finish: () {
                                            if (startSelected) {
                                              startSelected = false;
                                            } else {
                                              startCountdownTimer(startSelected);
                                            }
                                            HwpzgCureState = false;
                                            infraredEntity?.user?.isCure = startSelected;
                                            setState(() {});
                                          });
                                        });

                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
