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
import 'package:zhwlzlxt_project/utils/event_bus.dart';
import 'package:zhwlzlxt_project/utils/sp_utils.dart';
import 'package:zhwlzlxt_project/utils/treatment_type.dart';
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
  int _countdownTime = 0;

  @override
  void initState() {
    super.initState();
    dialog = DetailsDialog(
        index: 1); //1:超声疗法；2：脉冲磁疗法；3：红外偏光；4：痉挛肌；5：经皮神经电刺激；6：神经肌肉点刺激；7：中频/干扰电治疗；

    ultrasonic = Ultrasonic();
    ultrasonic?.init();

    // if (TextUtil.isEmpty(SpUtils.getString(UltrasonicField.UltrasonicKey))) {
    // } else {
    //   ultrasonic = Ultrasonic.fromJson(
    //       SpUtils.getString(UltrasonicField.UltrasonicKey)!);
    // }
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

    // eventBus.on<UserEvent>().listen((event) {
    //   if (event.type == TreatmentType.ultrasonic) {
    //     // ultrasonic?.userId = event.user?.userId;
    //     save(event.user?.userId ?? -1);
    //     ultrasonic?.user = event.user;
    //   }
    // });

    Future.delayed(Duration.zero, () {
      SerialMsg().startPort();
    });
    Timer.periodic(const Duration(seconds: 1), (timer) {
      SerialMsg().sendHeart().then((value) => {});
    });
  }

  Future<dynamic> flutterMethod(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'onSendComplete':
        String value = methodCall.arguments;
        Uint8List list = toUnitList(value);
        print("--------------------${list[3]}");

        if (value.length > 20) {
          if (value.substring(4, 6) == '02') {}
        }
        break;
    }
  }

  sendHeart(value) {
    if (value == AppConfig.connect_time) {
      showConnectPort('设备连接超时', "正在尝试重新连接");
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
    const oneSec = Duration(seconds: 1);
    callback(timer) {
      if (_countdownTime < 1) {
        _timer?.cancel();
        ultrasonic?.start(false);
        ultrasonic?.init();
        ultrasonicController.ultrasonic
            .frequency.value = 1;
        Future.delayed(
            const Duration(
                milliseconds: 500), () {
          eventBus.fire(SetValueState(
              TreatmentType.ultrasonic));
        });
        this.startSelected = false;
        setState(() {
          Fluttertoast.showToast(msg: '治疗结束!');
        });
      } else {
        _countdownTime = _countdownTime - 1;
        ultrasonic?.time = _countdownTime.toString();
        RunTime runTime = RunTime(_countdownTime.toDouble(), 1001);
        eventBus.fire(runTime);
        ultrasonic?.start(startSelected);
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
                                            width: 24.w,
                                            height: 24.h,
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
                                              '1',
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
                                          height: 8,
                                        ),
                                        const Text(
                                          '频率',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff666666)),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/icon_line.png',
                                          fit: BoxFit.fill,
                                          width: 30.w,
                                          height: 30.h,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          '链接正常',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff666666)),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Lottie.asset('assets/lottie/Animatio.json',
                                            repeat: true,
                                            width: 30.w,
                                            height: 30.h,
                                            fit: BoxFit.fitWidth),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          '温度正常',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff666666)),
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
                              maxValue: ultrasonicController
                                          .ultrasonic.frequency.value ==
                                      1
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
                                  ultrasonic?.start(startSelected);
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
                                    Center(
                                      child: Container(
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
                                            // startSelected = !startSelected;
                                            startSelected = ultrasonic
                                                    ?.start(!startSelected) ??
                                                false;


                                            cureState = startSelected;

                                            if (!startSelected) {
                                              ultrasonic?.init();
                                              ultrasonicController.ultrasonic
                                                  .frequency.value = 1;
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 500), () {
                                                eventBus.fire(SetValueState(
                                                    TreatmentType.ultrasonic));
                                              });
                                            }
                                            setState(() {
                                              double? tmp = double.tryParse(
                                                  ultrasonic?.time ?? '1');
                                              _countdownTime =
                                                  ((tmp?.toInt())!);
                                              startCountdownTimer(
                                                  startSelected);
                                            });
                                          },
                                          // child: Image.asset(
                                          //   startSelected
                                          //       ? 'assets/images/2.0x/btn_tingzhi_nor.png'
                                          //       : 'assets/images/btn_kaishi_nor.png',
                                          //   width: 100.w,
                                          //   fit: BoxFit.fitWidth,
                                          // ),
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
