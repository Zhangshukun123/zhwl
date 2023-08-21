import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zhwlzlxt_project/Controller/ultrasonic_controller.dart';
import 'package:zhwlzlxt_project/page/user_head_view.dart';
import 'package:zhwlzlxt_project/utils/event_bus.dart';
import 'package:zhwlzlxt_project/utils/sp_utils.dart';
import 'package:zhwlzlxt_project/utils/treatment_type.dart';
import 'package:zhwlzlxt_project/widget/details_dialog.dart';
import 'package:zhwlzlxt_project/widget/set_value.dart';

import '../entity/ultrasonic_entity.dart';
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

  bool startSelected = true;
  late TabController _tabController;

  DetailsDialog? dialog;

  var frequency = 1;

  Ultrasonic? ultrasonic;

  StreamController<String> cTime = StreamController<String>();
  StreamController<String> cPower = StreamController<String>();
  StreamController<String> cSoundIntensity = StreamController<String>();

  @override
  void initState() {
    super.initState();
    dialog = DetailsDialog(
        index: 1); //1:超声疗法；2：脉冲磁疗法；3：红外偏光；4：痉挛肌；5：经皮神经电刺激；6：神经肌肉点刺激；7：中频/干扰电治疗；
    if (TextUtil.isEmpty(SpUtils.getString(UltrasonicField.UltrasonicKey))) {
      ultrasonic = Ultrasonic();
    } else {
      ultrasonic =
          Ultrasonic.fromJson(SpUtils.getString(UltrasonicField.UltrasonicKey)!);
    }
    _tabController =
        TabController(length: dialog?.tabs.length ?? 0, vsync: this);
    _tabController.addListener(() {});

    dialog?.setTabController(_tabController);

    // 一定时间内 返回一个数据
    cTime.stream.debounceTime(const Duration(seconds: 1)).listen((time) {
      ultrasonic?.time = time;
      save();
    });
    cPower.stream.debounceTime(const Duration(seconds: 1)).listen((power) {
      ultrasonic?.power = power;
      save();
    });
    cSoundIntensity.stream
        .debounceTime(const Duration(seconds: 1))
        .listen((soundIntensity) {
      ultrasonic?.soundIntensity = soundIntensity;
      save();
    });

    eventBus.on<UserEvent>().listen((event) {
      if (event.type == TreatmentType.ultrasonic) {
        ultrasonic?.userId = event.user?.userId;
        save();
      }
    });
  }

  void save() {
    SpUtils.set(UltrasonicField.UltrasonicKey, ultrasonic?.toJson());
  }

  @override
  void dispose() {
    super.dispose();
    cTime.close();
    cPower.close();
    cSoundIntensity.close();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));

    final UltrasonicController controller = Get.put(UltrasonicController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF0FAFE),
      body: SafeArea(
        child: Column(
          children: [
            UserHeadView(
              type: TreatmentType.ultrasonic,
            ),
            Container(
              padding: EdgeInsets.only(left: 35.w, right: 35.w, top: 17.5.h),
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
                                margin: EdgeInsets.only(top: 23.h),
                                width: 72.w,
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
                                          '模式',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0xFF999999)),
                                        ),
                                      ],
                                    )),
                              ),
                              PopupMenuBtn(
                                index: 0,
                                patternStr: ultrasonic?.pattern ?? "连续模式1",
                                popupListener: (value) {
                                  ultrasonic?.pattern = value;
                                  save();
                                },
                              ),
                            ],
                          )),
                          ContainerBg(
                              margin: EdgeInsets.only(left: 30.w),
                              child: SetValue(
                                enabled: true,
                                title: '时间',
                                assets: 'assets/images/2.0x/icon_shijian.png',
                                initialValue:
                                    double.tryParse(ultrasonic?.time ?? '1'),
                                minValue: 1,
                                maxValue: 30,
                                unit: 'min',
                                valueListener: (value) {
                                  cTime.add(value.toString());
                                },
                              )),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 25.h),
                      height: 150.h,
                      child: Row(
                        children: [
                          ContainerBg(
                              child: SetValue(
                            enabled: true,
                            title: '功率',
                            isEventBus: true,
                            assets: 'assets/images/2.0x/icon_gonglv.png',
                            initialValue:
                                double.tryParse(ultrasonic?.power ?? '0'),
                            appreciation: 0.6,
                            unit: 'w',
                            // ignore: unrelated_type_equality_checks
                            maxValue: controller.ultrasonic.frequency.value == 1
                                ? 7.2
                                : 3,
                            //输出功率：1Mhz - 0～7.2W可调，级差0.6W;  3Mhz - 0～3W可调，级差0.6W;
                            isInt: false,
                            valueListener: (value) {
                              print("------功率-----$value");
                              cPower.add(value.toString());
                            },
                          )),
                          ContainerBg(
                              margin: EdgeInsets.only(left: 30.w),
                              child: SetValue(
                                enabled: true,
                                isInt: false,
                                isEventBus: true,
                                title: '声强',
                                assets:
                                    'assets/images/2.0x/icon_shengqiang.png',
                                initialValue: double.tryParse(
                                    ultrasonic?.soundIntensity ?? '0.0'),
                                appreciation: 0.3,
                                maxValue:
                                    controller.ultrasonic.frequency.value == 1
                                        ? 1.8
                                        : 1.5,
                                //有效声强：1Mhz -    0W/cm2～1.8W/cm2可调，级差0.15W/cm2; 3Mhz -     0W/cm2～1.5W/cm2可调，级差0.3W/cm2;
                                unit: 'w/cm2',
                                valueListener: (value) {
                                  print("------声强-----$value");
                                  cSoundIntensity.add(value.toString());
                                },
                              )),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 25.h),
                      height: 150.h,
                      child: Row(
                        children: [
                          ContainerBg(
                              child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 29.h),
                                width: 70.w,
                                child: TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/2.0x/icon_pinlv.png',
                                          fit: BoxFit.fitWidth,
                                          width: 16.w,
                                          height: 16.h,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          '频率',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0xFF999999)),
                                        ),
                                      ],
                                    )),
                              ),
                              PopupMenuBtn(
                                index: 1,
                                unit: 'MHz',
                                offset: Offset(0, -80.h),
                                patternStr: ultrasonic?.frequency ?? '1',
                                popupListener: (value) {
                                  // debugPrint(value);
                                  ultrasonic?.frequency = value;
                                  save();
                                  // setState(() {});
                                },
                              )
                            ],
                          )),
                          ContainerBg(
                              margin: EdgeInsets.only(left: 30.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 78.w,
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
                                              '详情',
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xFF009CB4),
                                                  fontSize: 18.sp),
                                            ),
                                          ],
                                        )),
                                  ),
                                  Center(
                                    child: SizedBox(
                                      width: 150.w,
                                      height: 75.h,
                                      child: TextButton(
                                        onPressed: () {
                                          startSelected = !startSelected;
                                          setState(() {});
                                        },
                                        child: Image.asset(
                                          startSelected
                                              ? 'assets/images/btn_kaishi_nor.png'
                                              : 'assets/images/2.0x/btn_tingzhi_nor.png',
                                          width: 100.w,
                                          fit: BoxFit.fitWidth,
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
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
