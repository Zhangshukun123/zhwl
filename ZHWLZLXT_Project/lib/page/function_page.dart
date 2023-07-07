import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhwlzlxt_project/page/electrotherapy_page.dart';
import 'package:zhwlzlxt_project/page/pulsed_page.dart';
import 'package:zhwlzlxt_project/page/ultrasonic_page.dart';

import 'infrared_page.dart';

class FunctionPage extends StatefulWidget {
  const FunctionPage({Key? key}) : super(key: key);

  @override
  State<FunctionPage> createState() => _FunctionPageState();
}

class _FunctionPageState extends State<FunctionPage> {

  int curPosition = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    List<Widget> pageView = [
      const UltrasonicPage(),
      const PulsedPage(),
      const InfraredPage(),
      const ElectrotherapyPage(),
    ];

    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            width: 180.w,
            color: const Color(0xFF00A8E7),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(
                      top: 12.5.h,
                    ),
                    child: Image.asset(
                      'assets/images/2.0x/function_logo.png',
                      fit: BoxFit.fitWidth,
                      width: 88.5.w,
                      height: 29.5.h,
                    )),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      pageButton('超声疗法', 0),
                      pageButton('脉冲磁疗法', 1),
                      pageButton('红外偏振光治疗', 2),
                      pageButton('电疗', 3),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 180.w,
            height: MediaQuery.of(context).size.height,
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              //上下滚动
              onPageChanged: (int index) {
                curPosition = index;
                setState(() {});
              },
              children: pageView,
            ),
          ),
        ],
      ),
    );
  }

  Widget pageButton(String txt, int index) {
    return Container(
      width: 150.w,
      height: 60.h,
      decoration: BoxDecoration(
          color: curPosition == index
              ? const Color(0XFFFFFFFF)
              : const Color(0xFF19B1E9),
          borderRadius: BorderRadius.all(
            Radius.circular(30.w),
          )),
      child: TextButton(
          onPressed: () {
            _pageController.jumpToPage(index);
          },
          child: Text(
            txt,
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: curPosition == index
                    ? const Color(0xFF00A8E7)
                    : const Color(0xFFFFFFFF)),
          )),
    );
  }
}
