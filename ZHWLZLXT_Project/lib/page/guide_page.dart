import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'login_page.dart';


class GuidePage extends StatefulWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Future.delayed(const Duration(seconds: 2), () {
              Get.to(const LoginPage());
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/2.0x/welcome_bg.png'),
          fit: BoxFit.fill, // 完全填充
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 41.w, top: 30.h),
              child: Image.asset(
                'assets/images/logo.png',
                height: 50.h,
                fit: BoxFit.fitHeight,
              ),
            ),
            Center(
              child: Container(
                transform: Matrix4.translationValues(0, -40.h, 0),
                child: Column(
                  children: [
                    Text(
                      "欢迎使用",
                      style: TextStyle(color: Colors.white, fontSize: 40.sp),
                    ),
                    Text(
                      "综合物理治疗系统",
                      style: TextStyle(color: Colors.white, fontSize: 40.sp),
                    ),
                  ],
                ),
              ),
            ),
            Center(
                child: Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: Text(
                "正在加载中...",
                style: TextStyle(color: Colors.white, fontSize: 25.sp),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
