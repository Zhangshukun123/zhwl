import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zhwlzlxt_project/Controller/serial_msg.dart';
import 'package:zhwlzlxt_project/Controller/ultrasonic_controller.dart';
import 'package:zhwlzlxt_project/base/globalization.dart';
import 'package:zhwlzlxt_project/cofig/config.dart';
import 'package:zhwlzlxt_project/entity/set_value_state.dart';
import 'package:zhwlzlxt_project/page/user_head_view.dart';
import 'package:zhwlzlxt_project/utils/dialog_utils.dart';
import 'package:zhwlzlxt_project/utils/event_bus.dart';
import 'package:zhwlzlxt_project/utils/sp_utils.dart';
import 'package:zhwlzlxt_project/utils/treatment_type.dart';
import 'package:zhwlzlxt_project/utils/utils_tool.dart';
import 'package:zhwlzlxt_project/widget/connect_port.dart';
import 'package:zhwlzlxt_project/widget/details_dialog.dart';
import 'package:zhwlzlxt_project/widget/set_value.dart';

import '../Controller/treatment_controller.dart';
import '../base/run_state_page.dart';
import '../entity/ultrasonic_entity.dart';
import '../entity/ultrasonic_sound.dart';
import '../utils/utils.dart';
import '../widget/container_bg.dart';
import '../widget/popup_menu_btn.dart';
import 'control_page.dart';

class UltrasonicPage extends StatefulWidget {
  const UltrasonicPage({Key? key}) : super(key: key);

  @override
  State<UltrasonicPage> createState() => _UltrasonicPageState();
}

class _UltrasonicPageState extends State<UltrasonicPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  //定义四个页面

  bool startSelected = false;
  late TabController _tabController;

  DetailsDialog? dialog;

  var frequency = 1;

  Ultrasonic? ultrasonic;

  final TreatmentController controller = Get.find();
  final UltrasonicController ultrasonicController =
      Get.put(UltrasonicController());

  //计时器
  Timer? _timer;
  String? prowText = '3';
  String? unline = Globalization.unlink.tr;
  String? wdText = Globalization.temperatureNormals.tr;
  bool onLine = false;
  bool wdOnline = true;
  int _countdownTime = 0;

  @override
  void initState() {
    super.initState();
    dialog = DetailsDialog(
        index: 1); //1:超声疗法；2：脉冲磁疗法；3：红外偏光；4：痉挛肌；5：经皮神经电刺激；6：神经肌肉点刺激；7：中频/干扰电治疗；
    ultrasonic = Ultrasonic();
    ultrasonic?.init(false);
    ultrasonic?.time = "20";
    _tabController =
        TabController(length: dialog?.tabs.length ?? 0, vsync: this);
    _tabController.addListener(() {});

    dialog?.setTabController(_tabController);

    eventBus.on<TreatmentType>().listen((event) {
      if (!mounted) {
        return;
      }
      ultrasonic?.user = userMap[TreatmentType.ultrasonic];
    });
    SerialMsg.platform.setMethodCallHandler(flutterMethod);

    eventBus.on<Language>().listen((event) {
      ultrasonic?.init(false);
      unline = Globalization.unlink.tr;
      wdText = Globalization.temperatureNormals.tr;
      setState(() {});
    });

  }

  Future<dynamic> flutterMethod(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'UltrasonicState03':
        String value = methodCall.arguments;
        Uint8List list = toUnitList(value);
        if (list[4] == 16) {
          if (list[12] == 1) {
            wdText = Globalization.temperatureAnomaly.tr;
            wdOnline = false;
            ultrasonic?.init(true);
            ultrasonic?.start(false,false);
            Future.delayed(const Duration(milliseconds: 500), () {
              eventBus.fire(SetValueState(TreatmentType.ultrasonic));
            });
            startSelected = false;
            cureState = startSelected;
            DialogUtil.alert(title: "", message: Globalization.temperatureNormals.tr, okLabel: "确定");
          } else {
            wdText =  Globalization.temperatureNormals.tr;
            wdOnline = true;
          }
        } else if (list[11] == 1) {
          ultrasonic?.frequency = "1";
          prowText = '1';
          onLine = true;
          unline =Globalization.onLine.tr;
        } else {
          unline = Globalization.unlink.tr;
          onLine = false;
        }

        setState(() {});
        break;
      case 'UltrasonicState04':
        String value = methodCall.arguments;
        Uint8List list = toUnitList(value);

        if (list[4] == 16) {
          if (list[12] == 1) {
            wdText = Globalization.temperatureAnomaly.tr;
            wdOnline = false;
            ultrasonic?.init(true);
            ultrasonic?.start(false,false);
            Future.delayed(const Duration(milliseconds: 500), () {
              eventBus.fire(SetValueState(TreatmentType.ultrasonic));
            });
            startSelected = false;
            cureState = startSelected;
            DialogUtil.alert(title: "", message: "检查到温度异常", okLabel: "确定");
          } else {
            wdText = Globalization.temperatureNormals.tr;
            wdOnline = true;
          }
        } else if (list[11] == 1) {
          ultrasonic?.frequency = "3";
          prowText = '3';
          onLine = true;
          unline = Globalization.onLine.tr;
        } else {
          unline =Globalization.unlink.tr;
          onLine = false;
        }

        setState(() {});
        break;
    }
  }

  sendHeart(value) {
    if (value == AppConfig.connect_time) {
      showConnectPort(Globalization.connectionTimeout.tr, Globalization.reconnect.tr);
    }
    if (value == "102") {
      if (isShow) {
        Get.back();
        isShow = false;
      }
    }
  }

  bool isShow = false;

  showConnectPort(title, con) async {
    ultrasonicController.title.value = title;
    ultrasonicController.context.value = con;

    if (!isShow) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return ConnectPort(
              restConnect: (value) {
                if (value) {}
                // ultrasonicController.startTimer();
                SerialMsg().startPort().then((value) => {
                      if (value == AppConfig.port_start) Get.back(),
                      isShow = false
                    });
              },
            );
          });
      isShow = true;
    }
  }

  void save(int userId) {
    SpUtils.set(UltrasonicField.UltrasonicKey, userId);
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
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
        ultrasonic?.init(true);
        ultrasonic?.start(false,false);
        Future.delayed(const Duration(milliseconds: 500), () {
          eventBus.fire(SetValueState(TreatmentType.ultrasonic));
        });
        this.startSelected = false;
        cureState = this.startSelected;
        setState(() {
          showToastMsg(msg: Globalization.endOfTreatment.tr);
        });
      } else {
        _countdownTime = _countdownTime - 1;
        if (_countdownTime < 1) {
          _timer?.cancel();
          ultrasonic?.init(true);
          ultrasonic?.start(false,false);
          Future.delayed(const Duration(milliseconds: 500), () {
            eventBus.fire(SetValueState(TreatmentType.ultrasonic));
          });
          this.startSelected = false;
          cureState = this.startSelected;
          setState(() {
            showToastMsg(msg: Globalization.endOfTreatment.tr);
          });
          return;
        }
        ultrasonic?.time = _countdownTime.toString();
        RunTime runTime = RunTime(_countdownTime.toDouble(), 1001);
        eventBus.fire(runTime);
        ultrasonic?.start(this.startSelected,false);
      }
    }

    _timer = Timer.periodic(oneSec, callback);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            UserHeadView(
              type: TreatmentType.ultrasonic,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 35.w, right: 35.w, top: 11.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        height: 150.h,
                        child: Row(
                          children: [
                            ContainerBg(
                                child: Column(
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(top: 15.h, bottom: 10.h),
                                  width: 120.w,
                                  child: TextButton(
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/2.0x/icon_moshi.png',
                                            fit: BoxFit.fitWidth,
                                            width: 22.w,
                                            height: 22.h,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            Globalization.mode.tr,
                                            style: TextStyle(
                                                fontSize: 22.sp,
                                                color: const Color(0xFF999999)),
                                          ),
                                        ],
                                      )),
                                ),
                                PopupMenuBtn(
                                  index: 0,
                                  patternStr: ultrasonic?.pattern ??
                                      Globalization.intermittentOne.tr,
                                  enabled: true,
                                  popupListener: (value) {
                                    ultrasonic?.pattern = value;
                                    // save();
                                  },
                                ),
                              ],
                            )),
                            ContainerBg(
                                margin: EdgeInsets.only(left: 30.w),
                                padding: EdgeInsets.only(top: 40.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              prowText ?? '1',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 26.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              'MHz',
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 22,
                                        ),
                                        Text(
                                          Globalization.Hz.tr,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0xff666666)),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Image.asset(
                                          onLine
                                              ? 'assets/images/icon_line.png'
                                              : 'assets/images/icon_un_line.png',
                                          fit: BoxFit.fill,
                                          width: 30.w,
                                          height: 30.h,
                                        ),
                                        const SizedBox(
                                          height: 22,
                                        ),
                                        Text(
                                          unline ?? Globalization.unlink.tr,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0xff666666)),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Image.asset(
                                          wdOnline
                                              ? 'assets/images/icon_wd_online.gif'
                                              : 'assets/images/icon_wd_unline.gif',
                                          fit: BoxFit.fitWidth,
                                          width: 40.w,
                                          height: 40.h,
                                        ),
                                        // const SizedBox(
                                        //   height: 10,
                                        // ),
                                        Text(
                                          wdText ?? Globalization.temperatureNormals.tr,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0xff666666)),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 15.h),
                        height: 150.h,
                        child: Row(
                          children: [
                            ContainerBg(
                                child: SetValue(
                              enabled: startSelected,
                              type: TreatmentType.ultrasonic,
                              title: Globalization.pPower.tr,
                              isEventBus: true,
                              assets: 'assets/images/2.0x/icon_gonglv.png',
                              initialValue:
                                  double.tryParse(ultrasonic?.power ?? '0'),
                              appreciation: 0.6,
                              unit: 'W',
                              // ignore: unrelated_type_equality_checks
                              maxValue: prowText == "1"
                                  ? 7.2
                                  : 3,
                              //输出功率：1Mhz - 0～7.2W可调，级差0.6W;  3Mhz - 0～3W可调，级差0.6W;
                              isInt: false,
                              valueListener: (value) {
                                ultrasonic?.power = value.toStringAsFixed(2);
                                if (ultrasonicController
                                        .ultrasonic.frequency.value ==
                                    1) {
                                  ultrasonic?.soundIntensity =
                                      (value / 4).toStringAsFixed(2);
                                  eventBus.fire(UltrasonicSound((value / 4)));
                                } else {
                                  ultrasonic?.soundIntensity =
                                      (value / 2).toStringAsFixed(2);
                                  eventBus.fire(UltrasonicSound((value / 2)));
                                }
                                if (startSelected) {
                                  ultrasonic?.start(startSelected,false);
                                }
                                // cPower.add(value.toString());
                              },
                            )),
                            ContainerBg(
                                margin: EdgeInsets.only(left: 30.w),
                                child: SetValue(
                                  enabled: false,
                                  isInt: false,
                                  isViImg: false,
                                  indexType: 1,
                                  type: TreatmentType.ultrasonic,
                                  isEventBus: true,
                                  IntFixed: 2,
                                  title: Globalization.pSoundIntensity.tr,
                                  assets:
                                      'assets/images/2.0x/icon_shengqiang.png',
                                  initialValue: double.tryParse(
                                      ultrasonic?.soundIntensity ?? '0.0'),
                                  // //有效声强：1Mhz -    0W/cm2～1.8W/cm2可调，级差0.15W/cm2; 3Mhz -     0W/cm2～1.5W/cm2可调，级差0.3W/cm2;
                                  unit: 'W/cm²',
                                  valueListener: (value) {
                                    ultrasonic?.soundIntensity =
                                        value.toStringAsFixed(2);
                                  },
                                )),
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 15.h),
                        height: 150.h,
                        child: Row(
                          children: [
                            ContainerBg(
                                child: SetValue(
                              enabled: !startSelected,
                              type: TreatmentType.ultrasonic,
                              title: Globalization.time.tr,
                              isClock: true,
                              isAnimate: startSelected,
                              assets: 'assets/images/2.0x/icon_shijian.png',
                              initialValue:
                                  double.tryParse(ultrasonic?.time ?? '1'),
                              minValue: 1,
                              maxValue: 30,
                              indexType: 1001,
                              unit: 'min',
                              valueListener: (value) {
                                ultrasonic?.time = value.toString();
                              },
                            )),
                            ContainerBg(
                                margin: EdgeInsets.only(left: 30.w),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
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
                                                    color:
                                                        const Color(0xFF009CB4),
                                                    fontSize: 18.sp),
                                              ),
                                            ],
                                          )),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              if (!onLine) {
                                                showToastMsg(msg: Globalization.unlink.tr);
                                                return;
                                              }
                                              startSelected = !startSelected;
                                              if (!startSelected) {
                                                ultrasonic?.init(true);
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 500), () {
                                                  eventBus.fire(SetValueState(
                                                      TreatmentType
                                                          .ultrasonic));
                                                });
                                              }
                                              ultrasonic?.start(startSelected,startSelected);
                                              cureState = startSelected;

                                              setState(() {
                                                double? tmp = double.tryParse(
                                                    ultrasonic?.time ?? '1');
                                                _countdownTime =
                                                    ((tmp?.toInt())!);
                                                startCountdownTimer(
                                                    startSelected);
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
                                                      fontWeight:
                                                          FontWeight.w600),
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
                        )),
                  ],
                ),
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
