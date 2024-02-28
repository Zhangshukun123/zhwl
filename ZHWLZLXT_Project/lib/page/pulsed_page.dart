import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/base/globalization.dart';
import 'package:zhwlzlxt_project/entity/pulsed_entity.dart';
import 'package:zhwlzlxt_project/page/user_head_view.dart';
import 'package:zhwlzlxt_project/utils/treatment_type.dart';
import 'package:zhwlzlxt_project/widget/container_bg.dart';
import 'package:zhwlzlxt_project/widget/set_value.dart';

import '../base/run_state_page.dart';
import '../entity/set_value_state.dart';
import '../entity/ultrasonic_sound.dart';
import '../utils/event_bus.dart';
import '../utils/sp_utils.dart';
import '../utils/utils_tool.dart';
import '../widget/details_dialog.dart';

class PulsedPage extends StatefulWidget {
  const PulsedPage({Key? key}) : super(key: key);

  @override
  State<PulsedPage> createState() => _PulsedPageState();
}

class _PulsedPageState extends State<PulsedPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  //定义四个页面
  late TabController _tabController;

  DetailsDialog? dialog;

  //初始化字段存储
  Pulsed? pulsed;

  //计时器
  Timer? _timer;
  int _countdownTime = 0;

  @override
  void initState() {
    super.initState();
    dialog = DetailsDialog(
        index: 2); //1:超声疗法；2：脉冲磁疗法；3：红外偏光；4：痉挛肌；5：经皮神经电刺激；6：神经肌肉点刺激；7：中频/干扰电治疗；
    pulsed = Pulsed();
    pulsed?.init(false);
    pulsed?.time = "20";
    // pulsed = Pulsed();

    _tabController =
        TabController(length: dialog?.tabs.length ?? 0, vsync: this);
    _tabController.addListener(() {});

    dialog?.setTabController(_tabController);

    eventBus.on<TreatmentType>().listen((event) {
      if (!mounted) {
        return;
      }
      pulsed?.user = userMap[TreatmentType.pulsed];
    });

    // eventBus.on<UserEvent>().listen((event) {
    //   if (event.type == TreatmentType.pulsed) {
    //     // pulsed?.userId = event.user?.userId;
    //     save(event.user?.userId ?? -1);
    //     pulsed?.user = event.user;
    //   }
    // });
  }

  void save(int userId) {
    SpUtils.set(PulsedField.PulsedKey, userId);
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
      _countdownTime = _countdownTime - 1;
      pulsed?.time = _countdownTime.toString();
      RunTime runTime = RunTime(_countdownTime.toDouble(), 1002);
      eventBus.fire(runTime);
      if (_countdownTime < 1) {
        _timer?.cancel();
        pulsed?.init(true);
        switchSelected = false;
        pulsed?.start(false, false, false);
        Future.delayed(const Duration(milliseconds: 500), () {
          eventBus.fire(SetValueState(TreatmentType.pulsed));
        });
        this.startSelected = false;
        MccCureState = this.startSelected;
        setState(() {
          RunTime runTime = RunTime(20, 1002);
          eventBus.fire(runTime);
          showToastMsg(msg: Globalization.endOfTreatment.tr);
        });
        return;
      }
      pulsed?.start(startSelected, switchSelected, false);
    }

    _timer = Timer.periodic(oneSec, callback);
  }

  @override
  bool startSelected = false;
  bool switchSelected = false;

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
              type: TreatmentType.pulsed,
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
                            enabled: startSelected,
                            type: TreatmentType.pulsed,
                            title: Globalization.intensity.tr,
                            assets: 'assets/images/2.0x/icon_qiangdu.png',
                            initialValue: double.tryParse(pulsed?.power ?? '0'),
                            maxValue: 5,
                            minValue: 0,
                            valueListener: (value) {
                              pulsed?.power = value.toString();
                              pulsed?.start(true, switchSelected, false);
                            },
                          )),
                      ContainerBg(
                          width: 416.w,
                          height: 150.h,
                          margin: EdgeInsets.only(top: 25.h),
                          child: SetValue(
                            enabled: !startSelected,
                            type: TreatmentType.pulsed,
                            title: Globalization.frequency.tr,
                            assets: 'assets/images/2.0x/icon_pinlv.png',
                            initialValue:
                                double.tryParse(pulsed?.frequency ?? '20'),
                            appreciation: 10,
                            maxValue: 80,
                            minValue: 20,
                            unit: "${Globalization.times.tr}/min",
                            valueListener: (value) {
                              pulsed?.frequency = value.toString();
                            },
                          )),
                      ContainerBg(
                          width: 416.w,
                          height: 150.h,
                          margin: EdgeInsets.only(top: 25.h),
                          child: SetValue(
                            enabled: !startSelected,
                            type: TreatmentType.pulsed,
                            title: Globalization.time.tr,
                            assets: 'assets/images/2.0x/icon_shijian.png',
                            isClock: true,
                            isAnimate: startSelected,
                            initialValue: double.tryParse(pulsed?.time ?? '12'),
                            maxValue: 99,
                            indexType: 1002,
                            minValue: 1,
                            unit: 'min',
                            valueListener: (value) {
                              pulsed?.time = value.toString();
                              // pulsed?.start(!startSelected, switchSelected);
                            },
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
                                margin: EdgeInsets.only(top: 60.h),
                                child: TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/2.0x/icon_zhendong.png',
                                          width: 20,
                                          fit: BoxFit.fitWidth,
                                        ),
                                        Text(
                                          Globalization.vibration.tr,
                                          style: TextStyle(
                                              color: const Color(0xFF999999),
                                              fontSize: 24.sp),
                                        ),
                                      ],
                                    )),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 15.h),
                                  width: 120.w,
                                  height: 70.h,
                                  child: Transform.scale(
                                    scale: 2,
                                    child: CupertinoSwitch(
                                        value: switchSelected,
                                        activeColor: const Color(0xFF00A8E7),
                                        trackColor: const Color(0xFFF9F9F9),
                                        onChanged: (value) {
                                          if (startSelected) {
                                            switchSelected = !switchSelected;
                                            setState(() {});
                                            pulsed?.start(startSelected,
                                                switchSelected, false);
                                          }
                                        }),
                                  )),
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
                                          margin: EdgeInsets.only(top: 50.5.h),
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
                                        startSelected = !startSelected;
                                        print(
                                            "------switchSelected--------$startSelected");

                                        if (!startSelected) {
                                          pulsed?.init(true);
                                          switchSelected = false;
                                          Future.delayed(
                                              const Duration(milliseconds: 500),
                                              () {
                                            eventBus.fire(SetValueState(
                                                TreatmentType.pulsed));
                                          });
                                        }

                                        pulsed?.start(
                                            startSelected,
                                            switchSelected,
                                            startSelected, back: () {
                                          MccCureState = startSelected;
                                          setState(() {
                                            //点击开始治疗
                                            double? tmp = double.tryParse(
                                                pulsed?.time ?? '1');
                                            _countdownTime = ((tmp?.toInt())!);
                                            startCountdownTimer(startSelected);
                                          });
                                        }, finish: () {
                                          if (startSelected) {
                                            startSelected = false;
                                          } else {
                                            startCountdownTimer(startSelected);
                                          }
                                          MccCureState = false;
                                          setState(() {});
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
