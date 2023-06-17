import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UltrasonicPage extends StatefulWidget {
  const UltrasonicPage({Key? key}) : super(key: key);

  @override
  State<UltrasonicPage> createState() => _UltrasonicPageState();
}

class _UltrasonicPageState extends State<UltrasonicPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: Color(0xFFF0FAFE),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 25.5.h,left: 39.5.w,right: 40.w),
              child: Row(
                children: [
                  Text('张三四   132****1234   ',style: TextStyle(color: const Color(0xFF999999),fontSize: 18.sp),),
                  const Expanded(child: SizedBox()),
                  Row(
                    children: [
                      Container(
                        width: 130.w,
                        height: 40.h,
                        decoration: const BoxDecoration(
                            color: Color(0xFF00C290),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            )
                        ),
                        child: TextButton(
                          onPressed: (){
                            debugPrint('点击用户管理');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/2.0x/icon_yonghu.png',fit: BoxFit.cover,width: 18.w,height: 18.h,),
                              SizedBox(width: 2.5.w,),
                              Text('用户管理',style: TextStyle(color: const Color(0xFFFFFFFF),fontSize: 18.sp),),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 29.5.w,),
                      Container(
                        width: 100.w,
                        height: 40.h,
                        decoration: const BoxDecoration(
                          color: Color(0xFF00C290),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )
                        ),
                        child: TextButton(
                            onPressed: (){
                              debugPrint('点击设置');

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/2.0x/icon_shezhi.png',fit: BoxFit.cover,width: 18.w,height: 18.h,),
                                SizedBox(width: 2.5.w,),
                                Text('设置',style: TextStyle(color: const Color(0xFFFFFFFF),fontSize: 18.sp),),
                              ],
                            ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text('这是一条测试数据',style: TextStyle(color: Colors.red),),
            Text('这是一条测试数据',style: TextStyle(color: Colors.red),),
          ],
        ),
      ),
    );
  }
}
