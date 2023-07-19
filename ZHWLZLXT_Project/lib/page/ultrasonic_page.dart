import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhwlzlxt_project/page/attention_page.dart';
import 'package:zhwlzlxt_project/page/operate_page.dart';
import 'package:zhwlzlxt_project/page/control_page.dart';
import 'package:zhwlzlxt_project/page/set_page.dart';
import 'package:zhwlzlxt_project/widget/set_value.dart';

import '../widget/container_bg.dart';
import '../widget/popup_menu_btn.dart';

class UltrasonicPage extends StatefulWidget {
  const UltrasonicPage({Key? key}) : super(key: key);

  @override
  State<UltrasonicPage> createState() => _UltrasonicPageState();
}

class _UltrasonicPageState extends State<UltrasonicPage>
    with SingleTickerProviderStateMixin {
  List tabs = [
    '操作说明',
    '注意事项',
  ];

  //定义四个页面
  List<Widget> pageViewList = [
    OperatePage(),
    AttentionPage(),
  ];
  late TabController _tabController;

  void showCustomDialog() {
    showDialog(
      barrierDismissible: true, //表示点击灰色背景的时候是否消失弹出框
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 700.w,
            height: 400.h,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
              Radius.circular(15),
            )),
            child: Column(
              children: [
                Container(
                    width: 700.w,
                    height: 50.h,
                    color: const Color(0xFF00A8E7),
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 330.w),
                            child: Text(
                              "详情",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.sp),
                            )),
                        const Expanded(child: SizedBox()),
                        Container(
                          margin: EdgeInsets.only(right: 20.w),
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Image.asset(
                                'assets/images/2.0x/btn_guanbi.png',
                                fit: BoxFit.cover,
                                width: 22.w,
                                height: 22.h,
                              )),
                        )
                      ],
                    )),
                SizedBox(
                    width: 700.w,
                    height: 350.h,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 700.w,
                          height: 80.h,
                          child: Center(
                            child: TabBar(
                              indicatorColor: const Color(0xFF00A8E7),
                              //// 底部指示器颜色
                              indicatorSize: TabBarIndicatorSize.tab,
                              //指示器宽度
                              isScrollable: true,
                              // 标签 Tab 是否可滑动
                              labelColor: const Color(0xFF00A8E7),
                              //标签 Tab 内容颜色
                              labelStyle: TextStyle(fontSize: 20.sp),
                              //// 标签 Tab 内容样式
                              indicatorWeight: 4.0,
                              //指示器宽度
                              unselectedLabelStyle: TextStyle(fontSize: 17.sp),
                              //未选中标签样式
                              unselectedLabelColor: const Color(0xFF666666),
                              //未选中标签 Tab 颜色
                              tabs: tabs.map((e) => Tab(text: e)).toList(),
                              controller: _tabController,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 700.w,
                          height: 270.h,
                          child: TabBarView(
                              controller: _tabController,
                              children: pageViewList),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  bool startSelected = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: const Color(0xFFF0FAFE),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 25.5.h, left: 39.5.w, right: 40.w),
              child: Row(
                children: [
                  Text(
                    '张三四   132****1234   ',
                    style: TextStyle(
                        color: const Color(0xFF999999), fontSize: 18.sp),
                  ),
                  const Expanded(child: SizedBox()),
                  Row(
                    children: [
                      Container(
                        width: 130.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            color: const Color(0xFF00C290),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.w),
                            )),
                        child: TextButton(
                          onPressed: () {
                            debugPrint('点击用户管理');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const ControlPage()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/2.0x/icon_yonghu.png',
                                fit: BoxFit.fitWidth,
                                width: 18.w,
                                height: 18.h,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                '用户管理',
                                style: TextStyle(
                                    color: const Color(0xFFFFFFFF),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 29.5.w,
                      ),
                      Container(
                        width: 100.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            color: const Color(0xFF00C290),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.w),
                            )),
                        child: TextButton(
                          onPressed: () {
                            debugPrint('点击设置');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const SetPage()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/2.0x/icon_shezhi.png',
                                fit: BoxFit.fitWidth,
                                width: 18.w,
                                height: 18.h,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                '设置',
                                style: TextStyle(
                                    color: const Color(0xFFFFFFFF),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
                              ),
                            ],
                          )),
                          ContainerBg(
                              margin: EdgeInsets.only(left: 30.w),
                              child: SetValue(
                                enabled: false,
                                title: '时间',
                                assets: 'assets/images/2.0x/icon_shijian.png',
                                initialValue: 12,
                                unit: 'min',
                                valueListener: (value) {},
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
                            assets: 'assets/images/2.0x/icon_gonglv.png',
                            initialValue: 1,
                            unit: 'w',
                            valueListener: (value) {},
                          )),
                          ContainerBg(
                              margin: EdgeInsets.only(left: 30.w),
                              child: SetValue(
                                enabled: true,
                                isInt: false,
                                title: '声强',
                                assets:
                                    'assets/images/2.0x/icon_shengqiang.png',
                                initialValue: 0.3,
                                appreciation: 0.2,
                                unit: 'w/cm2',
                                valueListener: (value) {
                                  print("object$value");
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
                              )
                              // Container(
                              //   decoration: const BoxDecoration(
                              //       color: Color(0xFFF0FAFE),
                              //       borderRadius: BorderRadius.all(
                              //         Radius.circular(10),
                              //       )),
                              //   width: 230.w,
                              //   height: 55.h,
                              //   child: _popupMenuButton2(context),
                              // ),
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
                                          showCustomDialog();
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
                                    child: Container(
                                      width: 120.w,
                                      height: 55.h,
                                      child: TextButton(
                                        onPressed: () {
                                          startSelected = !startSelected;
                                          setState(() {});
                                        },
                                        child: Image.asset(
                                          startSelected
                                              ? 'assets/images/2.0x/btn_kaishi_nor.png'
                                              : 'assets/images/2.0x/btn_tingzhi_nor.png',
                                          fit: BoxFit.fill,
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
}
