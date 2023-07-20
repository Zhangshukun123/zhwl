import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhwlzlxt_project/page/attention_page.dart';
import 'package:zhwlzlxt_project/page/user_head_view.dart';

import '../widget/details_dialog.dart';
import '../widget/popup_menu_btn.dart';
import 'operate_page.dart';

class InfraredPage extends StatefulWidget {
  const InfraredPage({Key? key}) : super(key: key);

  @override
  State<InfraredPage> createState() => _InfraredPageState();
}

class _InfraredPageState extends State<InfraredPage>
    with SingleTickerProviderStateMixin {

  bool thirdStartSelected = true;
  bool switchSelected = true;
  //定义四个页面
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
            Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 35.w, right: 35.w, top: 17.5.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                          width: 416.w,
                          height: 150.h,
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
                                          'assets/images/2.0x/icon_shijian.png',
                                          fit: BoxFit.cover,
                                          width: 19.w,
                                          height: 18.h,
                                        ),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        Text(
                                          '时间',
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              color: const Color(0xFF999999)),
                                        ),
                                      ],
                                    )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: () {},
                                      child: Image.asset(
                                        'assets/images/2.0x/btn_jian_nor.png',
                                        fit: BoxFit.cover,
                                        width: 38.w,
                                        height: 34.h,
                                      )),
                                  Container(
                                    width: 120.w,
                                    height: 55.h,
                                    decoration: const BoxDecoration(
                                        color: Color(0xFFF0FAFE),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '12',
                                          style: TextStyle(
                                              color: const Color(0xFF333333),
                                              fontSize: 22.sp),
                                        ),
                                        Text(
                                          'min',
                                          style: TextStyle(
                                              color: const Color(0xFF999999),
                                              fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Image.asset(
                                        'assets/images/2.0x/btn_jia_nor.png',
                                        fit: BoxFit.cover,
                                        width: 38.w,
                                        height: 34.h,
                                      )),
                                ],
                              ),
                            ],
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
                                width: 70.w,
                                child: TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/2.0x/icon_qiangdu.png',
                                          fit: BoxFit.cover,
                                          width: 19.w,
                                          height: 18.h,
                                        ),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        Text(
                                          '强度',
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              color: const Color(0xFF999999)),
                                        ),
                                      ],
                                    )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: () {},
                                      child: Image.asset(
                                        'assets/images/2.0x/btn_jian_nor.png',
                                        fit: BoxFit.cover,
                                        width: 38.w,
                                        height: 34.h,
                                      )),
                                  Container(
                                    width: 120.w,
                                    height: 55.h,
                                    decoration: const BoxDecoration(
                                        color: Color(0xFFF0FAFE),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '12',
                                          style: TextStyle(
                                              color: const Color(0xFF333333),
                                              fontSize: 22.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Image.asset(
                                        'assets/images/2.0x/btn_jia_nor.png',
                                        fit: BoxFit.cover,
                                        width: 38.w,
                                        height: 34.h,
                                      )),
                                ],
                              ),
                            ],
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
                                width: 70.w,
                                child: TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/2.0x/icon_moshi.png',
                                          fit: BoxFit.cover,
                                          width: 19.w,
                                          height: 18.h,
                                        ),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        Text(
                                          '模式',
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              color: const Color(0xFF999999)),
                                        ),
                                      ],
                                    )),
                              ),
                              PopupMenuBtn(
                                index: 2,
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
                                margin: EdgeInsets.only(top: 60.h),
                                child: TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/2.0x/icon_jiting.png',
                                          fit: BoxFit.cover,
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
                                      '当前急停状态',
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
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                                              color: const Color(0xFF009CB4),
                                              fontSize: 18.sp),
                                        ),
                                      ],
                                    )),
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 34.5.h),
                                  width: 120.w,
                                  height: 55.h,
                                  child: TextButton(
                                    onPressed: () {
                                      thirdStartSelected = !thirdStartSelected;
                                      setState(() {});
                                    },
                                    child: Image.asset(
                                      thirdStartSelected
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
