import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhwlzlxt_project/page/attention_page.dart';
import 'package:zhwlzlxt_project/page/operate_page.dart';
import 'package:zhwlzlxt_project/page/control_page.dart';
import 'package:zhwlzlxt_project/page/set_page.dart';
import 'package:zhwlzlxt_project/page/user_head_view.dart';
import 'package:zhwlzlxt_project/widget/details_dialog.dart';
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
  //定义四个页面

  bool startSelected = true;
  late TabController _tabController;

  DetailsDialog? dialog;

  @override
  void initState() {
    super.initState();
    dialog = DetailsDialog();
    _tabController =
        TabController(length: dialog?.tabs.length ?? 0, vsync: this);
    _tabController.addListener(() {});

    dialog?.setTabController(_tabController);
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
            const UserHeadView(),
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
