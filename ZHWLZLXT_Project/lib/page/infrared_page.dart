import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zhwlzlxt_project/Controller/infrared_controller.dart';
import 'package:zhwlzlxt_project/base/globalization.dart';
import 'package:zhwlzlxt_project/page/attention_page.dart';
import 'package:zhwlzlxt_project/utils/event_bus.dart';
import 'package:zhwlzlxt_project/utils/treatment_type.dart';
import 'package:zhwlzlxt_project/widget/container_bg.dart';
import 'package:zhwlzlxt_project/page/user_head_view.dart';

import '../Controller/ultrasonic_controller.dart';
import '../utils/sp_utils.dart';
import '../utils/treatment_type.dart';
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

  //定义四个页面
  late TabController _tabController;

  DetailsDialog? dialog;


  InfraredController infraredController = Get.find();

  // InfraredEntity? infraredEntity;

  StreamController<String> cTime = StreamController<String>();
  StreamController<String> cPower = StreamController<String>();

  var isDGW = false;

  @override
  void initState() {
    super.initState();
    dialog = DetailsDialog(
        index: 3); //1:超声疗法；2：脉冲磁疗法；3：红外偏光；4：痉挛肌；5：经皮神经电刺激；6：神经肌肉点刺激；7：中频/干扰电治疗；

    //数据的更改与保存，是否是新建或者从已知json中读取
    if (!TextUtil.isEmpty(SpUtils.getString(InfraredField.InfraredKey))) {
      // infraredEntity = InfraredEntity();

      infraredController.infraredEntity.value = InfraredEntity.fromJson(
          SpUtils.getString(InfraredField.InfraredKey)!);
      isDGW = (infraredController.infraredEntity.value.pattern != "连续模式1");
      setState(() {});
    }
    // else {
    //   infraredController.infraredEntity.value = InfraredEntity.fromJson(
    //       SpUtils.getString(InfraredField.InfraredKey)!);
    //   isDGW = (infraredEntity?.pattern != "连续模式1");
    //   setState(() {});
    // }

    // infraredEntity = InfraredEntity();

    _tabController =
        TabController(length: dialog?.tabs.length ?? 0, vsync: this);
    _tabController.addListener(() {});

    dialog?.setTabController(_tabController);

    // 一定时间内 返回一个数据
    cTime.stream.debounceTime(const Duration(seconds: 1)).listen((time) {
      infraredController.infraredEntity.value.time = time;
      save();
    });
    cPower.stream.debounceTime(const Duration(seconds: 1)).listen((power) {

      infraredController.infraredEntity.value.power = power;
      save();

    });

    eventBus.on<UserEvent>().listen((event) {
      if (event.type == TreatmentType.infrared) {
        infraredController.infraredEntity.value.userId = event.user?.userId;
        save();
      }
    });
  }

  void save() {
    SpUtils.set(InfraredField.InfraredKey, infraredController.infraredEntity.value.toJson());
  }

  bool startSelected = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: const Color(0xFFF0FAFE),
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
                          enabled: true,
                          title: Globalization.time.tr,
                          assets: 'assets/images/2.0x/icon_shijian.png',
                          initialValue:
                              double.tryParse(infraredController.infraredEntity.value.time ?? '12'),
                          maxValue: 99,
                          minValue: 0,
                          unit: 'min',
                          valueListener: (value) {
                            print("------时间-----$value");
                            cTime.add(value.toString());
                          },
                        ),
                      ),
                      ContainerBg(
                          margin: EdgeInsets.only(top: 25.h),
                          width: 416.w,
                          height: 150.h,
                          child: SetValue(
                            enabled: !isDGW,
                            isEventBus: true,
                            title: Globalization.intensity.tr,
                            assets: 'assets/images/2.0x/icon_qiangdu.png',
                            initialValue:
                                !startSelected ? double.tryParse(infraredController.infraredEntity.value.power ?? '1') : double.tryParse('0'),
                            maxValue: 8,
                            minValue: 1,
                            valueListener: (value) {
                              print("------强度-----$value");
                              cPower.add(value.toString());

                            },
                          )),
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
                              )),
                          margin: EdgeInsets.only(top: 25.h),
                          width: 416.w,
                          height: 150.h,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 29.h),
                                width: (Get.locale?.countryCode == "CN") ? 70.w : 100.w,
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
                                              fontSize: 16.sp,
                                              color: const Color(0xFF999999)),
                                        ),
                                      ],
                                    )),
                              ),
                              PopupMenuBtn(
                                index: 2,
                                patternStr: infraredController.infraredEntity.value.pattern ?? "连续模式1",
                                popupListener: (value) {
                                  debugPrint('++++++++$value');
                                  isDGW = (value != "连续模式1");

                                  if (isDGW) {
                                    eventBus.fire(Infrared());
                                  }
                                  infraredController.infraredEntity.value.pattern = value;
                                  save();
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
                              )),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 30.h),
                                height: 100.h,
                                child: TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/2.0x/icon_jiting.png',
                                          fit: BoxFit.fitHeight,
                                          height: 100.h,
                                        ),
                                      ],
                                    )),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10.h),
                                child: TextButton(
                                    onPressed: () {
                                      switchSelected = !switchSelected;
                                      setState(() {});
                                    },
                                    child: Text(
                                      Globalization.currEmStSt.tr,
                                      style: TextStyle(
                                          color: Color(0xFFFD5F1F),
                                          fontSize: 18.sp),
                                    )),
                              ),
                            ],
                          )),
                      Container(
                          width: 260.w,
                          height: 235.h,
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
                              )),
                          margin: EdgeInsets.only(top: 30.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: (Get.locale?.countryCode == "CN") ? 78.w : 100.w,
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
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 42.5.h),
                                  width: 180.w,
                                  height: 70.h,
                                  child: TextButton(
                                    onPressed: () {
                                      // thirdStartSelected = !thirdStartSelected;
                                      startSelected = infraredController.infraredEntity.value.start(
                                          !startSelected, switchSelected) ??
                                          false;

                                      infraredController.infraredEntity.value.isStart = startSelected;

                                      eventBus.fire(infraredController.infraredEntity.value);

                                      setState(() {});
                                    },
                                    child: Image.asset(
                                      startSelected
                                          ? 'assets/images/2.0x/btn_kaishi_nor.png'
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
