import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/base/globalization.dart';
import 'package:zhwlzlxt_project/page/jingLuan_page.dart';
import 'package:zhwlzlxt_project/page/jingPi_page.dart';
import 'package:zhwlzlxt_project/page/shenJing_page.dart';
import 'package:zhwlzlxt_project/page/user_head_view.dart';
import 'package:zhwlzlxt_project/page/zhongPin_page.dart';
import 'package:zhwlzlxt_project/utils/event_bus.dart';
import 'package:zhwlzlxt_project/utils/treatment_type.dart';

import '../Controller/treatment_controller.dart';
import '../widget/custom_tabIndicator.dart';
import '../widget/details_dialog.dart';

import 'package:zhwlzlxt_project/widget/tabstwo.dart' as Cum;

class ElectrotherapyPage extends StatefulWidget {
  const ElectrotherapyPage({Key? key}) : super(key: key);

  @override
  State<ElectrotherapyPage> createState() => _ElectrotherapyPageState();
}

class _ElectrotherapyPageState extends State<ElectrotherapyPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List tabs = [
    Globalization.spasm.tr, Globalization.tens.tr, Globalization.muscle.tr, Globalization.medium.tr
  ];

  //定义四个页面
  List<Widget> pageViewList = [
    const JingLuanPage(),
    const JingPiPage(),
    const ShenJingPage(),
    const ZhongPinPage()
  ];
  late TabController _tabController;
  late TabController _diaController;

  DetailsDialog? dialog;
  TreatmentType type = TreatmentType.spasm;

  UserHeadView? view;


  final TreatmentController controller = Get.find();

  @override
  void initState() {
    super.initState();
    type = TreatmentType.spasm;
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      dialog = DetailsDialog(index: _tabController.index + 4);

      if (_tabController.index == 0) {
        type = TreatmentType.spasm;
      }
      if (_tabController.index == 1) {
        type = TreatmentType.percutaneous;
      }
      if (_tabController.index == 2) {
        type = TreatmentType.neuromuscular;
      }
      if (_tabController.index == 3) {
        type = TreatmentType.frequency;
      }
      // controller.treatmentType.value = type;
      // controller.setUserForType(type);
      _diaController = TabController(length: dialog?.tabs.length ?? 0, vsync: this);
      dialog?.setTabController(_diaController);
      eventBus.fire(type);
    });
    tabController = _tabController;

    controller.treatmentType.value = type;
    controller.setUserForType(type);
    // dialog = DetailsDialog(index: _tabController.index);
    dialog = DetailsDialog(index: 4);
    _diaController =
        TabController(length: dialog?.tabs.length ?? 0, vsync: this);
    dialog?.setTabController(_diaController);
  }

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
              type: type,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Center(
                          child: SizedBox(
                            height: 60.h,
                            // color:Colors.black,
                            child: Cum.TabBar(
                              indicatorColor: const Color(0xFF00A8E7),
                              //指示器宽度
                              isScrollable: true,
                              // 标签 Tab 是否可滑动
                              labelColor: const Color(0xFF00A8E7),
                              //标签 Tab 内容颜色
                              labelStyle: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w600),
                              //// 标签 Tab 内容样式
                              indicatorSize: Cum.TabBarIndicatorSize.label,
                              indicator: const CustomTabIndicator(
                                  width: 60,
                                  borderSide: BorderSide(
                                      width: 5.0, color: Color(0xFF00A8E7))),
                              unselectedLabelStyle: TextStyle(fontSize: 15.sp),
                              //未选中标签样式
                              unselectedLabelColor: const Color(0xFF666666),
                              //未选中标签 Tab 颜色
                              tabs: tabs.map((e) => Tab(text: e)).toList(),
                              controller: _tabController,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: (Get.locale?.countryCode == "CN") ? 78.w : 100.w,
                        // margin: EdgeInsets.only(top: 15.5.h),
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
                    ],
                  ),
                  Expanded(
                      child: TabBarView(
                          controller: _tabController, children: pageViewList))
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
