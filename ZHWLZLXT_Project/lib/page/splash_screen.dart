import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double progress = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 50), (t) {
      setState(() => progress = (progress + 1).clamp(0, 100));
      if (progress >= 100) {
        t.cancel();
        Get.offNamed('/login');
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAFE),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/sp_start_bg.png', fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 160.w, vertical: 40.h),
            child: Column(
              children: [
                const Spacer(flex: 4),
                SizedBox(height: 100.h),
                const Spacer(flex: 3),
                // 欢迎语
                Text(
                  '欢迎使用综合物理治疗系统',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF454A63),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50.h),
                Row(
                  children: [
                    Text('加载中...', style: TextStyle(fontSize: 18.sp, color: const Color(0xFF808AA0))),
                    const Spacer(),
                    Text('${progress.toInt()}%', style: TextStyle(fontSize: 18.sp, color: const Color(0xFF808AA0))),
                  ],
                ),
                SizedBox(height: 8.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress / 100,
                    minHeight: 8.h,
                    backgroundColor: const Color(0xFFE6EBF2),
                    valueColor: AlwaysStoppedAnimation(const Color(0xFF3B4A7E)),
                  ),
                ),

                const Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
