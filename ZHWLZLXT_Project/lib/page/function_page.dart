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



  @override
  Widget build(BuildContext context) {

    bool firstSelected = true;
    bool secondSelected = false;
    bool thirdSelected = false;
    bool fourthSelected = false;

    List<Widget> pageView = [
      const UltrasonicPage(),
      const PulsedPage(),
      const InfraredPage(),
      const ElectrotherapyPage(),
    ];

    final PageController _pageController = PageController();

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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    margin: EdgeInsets.only(
                      top: 12.5.h,
                    ),
                    child: Image.asset(
                      'assets/images/2.0x/function_logo.png',
                      fit: BoxFit.cover,
                      width: 88.5.w,
                      height: 29.5.h,
                    )),
                Container(
                  width: 150.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      color: firstSelected ? const Color(0XFFFFFFFF) : const Color(0xFF19B1E9),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      )),
                  child: TextButton(
                      onPressed: () {
                        debugPrint('超声疗法');
                        setState(() {
                          firstSelected = !firstSelected;
                        });
                        _pageController.jumpToPage(0);
                      },
                      child: Text(
                        '超声疗法',
                        style: TextStyle(
                            fontSize: 18.sp,
                            color : firstSelected
                                ? const Color(0xFF00A8E7)
                                : const Color(0xFFFFFFFF)
                        ),
                      )
                  ),
                ),
                Container(
                  width: 150.w,
                  height: 60.h,
                  // margin: EdgeInsets.only(top: 0, left: 15.w, right: 15.w, bottom: 62.h),
                  decoration: BoxDecoration(
                      color: secondSelected
                          ? const Color(0XFFFFFFFF)
                          : const Color(0xFF19B1E9),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      )),
                  child: TextButton(
                      onPressed: () {
                        debugPrint('脉冲磁疗法');
                        // _pageController.jumpTo(1);
                        _pageController.jumpToPage(1);
                        secondSelected = !secondSelected;
                        setState(() {});
                      },
                      child: Text(
                        '脉冲磁疗法',
                        style: TextStyle(
                            fontSize: 18.sp,
                            color:
                            secondSelected
                            ? const Color(0xFF00A8E7)
                            : const Color(0xFFFFFFFF)),
                      )
                  ),
                ),
                Container(
                  width: 150.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      color:
                          thirdSelected
                          ?  const Color(0XFFFFFFFF)
                          :  const Color(0xFF19B1E9),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      )),
                  child: TextButton(
                      onPressed: () {
                        debugPrint('红外偏振光治疗');
                        _pageController.jumpToPage(2);
                        thirdSelected = !thirdSelected;
                        setState(() {});
                      },
                      child: Text(
                        '红外偏振光治疗',
                        style: TextStyle(
                            fontSize: 18.sp,
                            color : thirdSelected
                                  ? const Color(0xFF00A8E7)
                                  : const Color(0xFFFFFFFF)),
                      )
                  ),
                ),
                Container(
                  width: 150.w,
                  height: 60.h,
                  // margin:
                  //   EdgeInsets.only(top: 0, left: 15.w, right: 15.w, bottom: 87.h),
                  decoration: BoxDecoration(
                      color: fourthSelected
                          ? const Color(0XFFFFFFFF)
                          : const Color(0xFF19B1E9),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      )),
                  child: TextButton(
                      onPressed: () {
                        debugPrint('电疗');
                        _pageController.jumpToPage(3);
                        fourthSelected = !fourthSelected;
                        setState(() {

                        });
                      },
                      child: Text(
                        '电疗',
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: fourthSelected
                                ? const Color(0xFF00A8E7)
                                : const Color(0xFFFFFFFF)),
                      )),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 180.w,
            height: MediaQuery.of(context).size.height,
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              //上下滚动
              onPageChanged: (int index) {
                debugPrint('这是第${index}个页面');
              },
              children: pageView,
            ),
          ),

        ],
      ),
    );
  }
}
