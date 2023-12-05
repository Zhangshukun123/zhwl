import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../base/globalization.dart';
import '../widget/set_value_horizontal.dart';

class ChuChangPage extends StatefulWidget {
  const ChuChangPage({Key? key}) : super(key: key);

  @override
  State<ChuChangPage> createState() => _ChuChangPageState();
}

class _ChuChangPageState extends State<ChuChangPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text(
          Globalization.setting.tr,
          style: TextStyle(fontSize: 18.sp, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 700.w,
                height: 90.h,
                margin: EdgeInsets.only(left: 115.w,right: 115.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: const Color(0xFFDBDBDB),
                  ),
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.w)),
                ),
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 33.w),
                        child: Text('设置',style: TextStyle(color:const Color(0xFF999999),fontSize: 18.sp),)
                    ),
                    Expanded(child: SizedBox(width: 10.w,)),
                    Container(
                      width: 110.w,
                      height: 43.h,
                      margin: EdgeInsets.only(right: 33.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A8E7),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.w),
                        )
                      ),
                      child: TextButton(
                          onPressed: (){

                          },
                          child:
                          Text(
                            '扫频',
                            style: TextStyle(color: Colors.white,fontSize: 18.sp),
                          )
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  width: 700.w,
                  height: 90.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFFDBDBDB),
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.w)),
                  ),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 33.w),
                          child: Text('输出功率',style: TextStyle(color:const Color(0xFF999999),fontSize: 18.sp),)
                      ),
                      Expanded(child: SizedBox(width: 10.w,)),
                      Container(
                        margin: EdgeInsets.only(right: 33.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // if (widget.enabled) {
                                //   value = (value - appreciation);
                                //   if (value <= (widget.minValue ?? 0)) {
                                //     value = (widget.minValue ?? 0);
                                //   }
                                //   widget.valueListener!(value);
                                //   setState(() {});
                                // }
                              },
                              onTapDown: (e) {
                                // timer = Timer.periodic(const Duration(milliseconds: 300), (e) {
                                //   if (widget.enabled) {
                                //     value = (value - appreciation);
                                //     if (value <= (widget.minValue ?? 0)) {
                                //       value = (widget.minValue ?? 0);
                                //     }
                                //     widget.valueListener!(value);
                                //     setState(() {});
                                //   }
                                // });
                              },
                              onTapUp: (e) {
                                // if (timer != null) {
                                //   timer.cancel();
                                // }
                              },
                              onTapCancel: () {
                                // if (timer != null) {
                                //   timer.cancel();
                                // }
                              },
                              child: Visibility(
                                visible:  true,
                                child: Image.asset(
                                    'assets/images/btn_jian_nor.png',
                                  // widget.enabled && !(value == (widget.minValue ?? 0))
                                  //     ? 'assets/images/btn_jian_nor.png'
                                  //     : 'assets/images/2.0x/btn_jian_disabled.png',
                                  fit: BoxFit.fitWidth,
                                  width: 34.w,
                                  height: 34.h,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Container(
                              width: 120.w,
                              height: 60.h,
                              decoration: const BoxDecoration(
                                  color: Color(0xFFF0FAFE),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '1'
                                    // widget.isInt ?? true
                                    //     ? value.toInt().toString()
                                    //     : value.toStringAsFixed(widget.IntFixed ?? 1),
                              ,
                                    style: TextStyle(
                                        color: const Color(0xFF333333), fontSize: 20.sp),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 6.0.h, left: 2.w),
                                    child: Text(
                                      'w',
                                      style: TextStyle(
                                          color: const Color(0xFF999999), fontSize: 12.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                // if (widget.enabled) {
                                //   value = value + appreciation;
                                //   if (value > (widget.maxValue ?? 999999)) {
                                //     value = (widget.maxValue ?? 999999);
                                //   }
                                //   widget.valueListener!(value);
                                //   setState(() {});
                                // }
                              },
                              onTapDown: (e) {
                                // timer = Timer.periodic(const Duration(milliseconds: 300), (e) {
                                //   setState(() {
                                //     // todo  长按点击事件
                                //     if (widget.enabled) {
                                //       value = value + appreciation;
                                //       if (value > (widget.maxValue ?? 999999)) {
                                //         value = (widget.maxValue ?? 999999);
                                //       }
                                //       widget.valueListener!(value);
                                //       setState(() {});
                                //     }
                                //   });
                                // });
                              },
                              onTapUp: (e) {
                                // if (timer != null) {
                                //   timer.cancel();
                                // }
                              },
                              onTapCancel: () {
                                // if (timer != null) {
                                //   timer.cancel();
                                // }
                              },
                              child: Visibility(
                                visible:  true,
                                child: Image.asset(
                                    'assets/images/btn_jia_nor.png',
                                  // widget.enabled && !(value == widget.maxValue)
                                  //     ? 'assets/images/btn_jia_nor.png'
                                  //     : 'assets/images/2.0x/btn_jia_disabled.png',
                                  fit: BoxFit.fitWidth,
                                  width: 34.w,
                                  height: 34.h,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  )
              ),
              Container(
                  width: 700.w,
                  height: 90.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFFDBDBDB),
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.w)),
                  ),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 33.w),
                          child: Text('DAC',style: TextStyle(color:const Color(0xFF999999),fontSize: 18.sp),)
                      ),
                      Expanded(child: SizedBox(width: 10.w,)),
                      Container(
                        margin: EdgeInsets.only(right: 33.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // if (widget.enabled) {
                                //   value = (value - appreciation);
                                //   if (value <= (widget.minValue ?? 0)) {
                                //     value = (widget.minValue ?? 0);
                                //   }
                                //   widget.valueListener!(value);
                                //   setState(() {});
                                // }
                              },
                              onTapDown: (e) {
                                // timer = Timer.periodic(const Duration(milliseconds: 300), (e) {
                                //   if (widget.enabled) {
                                //     value = (value - appreciation);
                                //     if (value <= (widget.minValue ?? 0)) {
                                //       value = (widget.minValue ?? 0);
                                //     }
                                //     widget.valueListener!(value);
                                //     setState(() {});
                                //   }
                                // });
                              },
                              onTapUp: (e) {
                                // if (timer != null) {
                                //   timer.cancel();
                                // }
                              },
                              onTapCancel: () {
                                // if (timer != null) {
                                //   timer.cancel();
                                // }
                              },
                              child: Visibility(
                                visible:  true,
                                child: Image.asset(
                                  'assets/images/btn_jian_nor.png',
                                  // widget.enabled && !(value == (widget.minValue ?? 0))
                                  //     ? 'assets/images/btn_jian_nor.png'
                                  //     : 'assets/images/2.0x/btn_jian_disabled.png',
                                  fit: BoxFit.fitWidth,
                                  width: 34.w,
                                  height: 34.h,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Container(
                              width: 120.w,
                              height: 60.h,
                              decoration: const BoxDecoration(
                                  color: Color(0xFFF0FAFE),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '1'
                                    // widget.isInt ?? true
                                    //     ? value.toInt().toString()
                                    //     : value.toStringAsFixed(widget.IntFixed ?? 1),
                                    ,
                                    style: TextStyle(
                                        color: const Color(0xFF333333), fontSize: 20.sp),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 6.0.h, left: 2.w),
                                    child: Text(
                                      'w',
                                      style: TextStyle(
                                          color: const Color(0xFF999999), fontSize: 12.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                // if (widget.enabled) {
                                //   value = value + appreciation;
                                //   if (value > (widget.maxValue ?? 999999)) {
                                //     value = (widget.maxValue ?? 999999);
                                //   }
                                //   widget.valueListener!(value);
                                //   setState(() {});
                                // }
                              },
                              onTapDown: (e) {
                                // timer = Timer.periodic(const Duration(milliseconds: 300), (e) {
                                //   setState(() {
                                //     // todo  长按点击事件
                                //     if (widget.enabled) {
                                //       value = value + appreciation;
                                //       if (value > (widget.maxValue ?? 999999)) {
                                //         value = (widget.maxValue ?? 999999);
                                //       }
                                //       widget.valueListener!(value);
                                //       setState(() {});
                                //     }
                                //   });
                                // });
                              },
                              onTapUp: (e) {
                                // if (timer != null) {
                                //   timer.cancel();
                                // }
                              },
                              onTapCancel: () {
                                // if (timer != null) {
                                //   timer.cancel();
                                // }
                              },
                              child: Visibility(
                                visible:  true,
                                child: Image.asset(
                                  'assets/images/btn_jia_nor.png',
                                  // widget.enabled && !(value == widget.maxValue)
                                  //     ? 'assets/images/btn_jia_nor.png'
                                  //     : 'assets/images/2.0x/btn_jia_disabled.png',
                                  fit: BoxFit.fitWidth,
                                  width: 34.w,
                                  height: 34.h,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: 43.h,
                      width: 110.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00C290),
                        borderRadius: BorderRadius.all(Radius.circular(7.w)),
                      ),
                      child: TextButton(
                        onPressed: () {

                        },
                        child: Text(
                          '开启超声',
                          style: TextStyle(
                              color: const Color(0xFFFFFFFF),
                              fontSize: 18.sp),
                        ),
                      )),
                  Container(
                      height: 43.h,
                      width: 110.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A8E7),
                        borderRadius: BorderRadius.all(Radius.circular(7.w)),
                      ),
                      child: TextButton(
                          onPressed: () {

                          },
                          child: Text(
                            '保存',
                            style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontSize: 18.sp),
                          ))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
