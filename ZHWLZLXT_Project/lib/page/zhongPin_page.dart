import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/popup_menu_btn.dart';
import '../widget/set_value_horizontal.dart';

class ZhongPinPage extends StatefulWidget {
  const ZhongPinPage({Key? key}) : super(key: key);

  @override
  State<ZhongPinPage> createState() => _ZhongPinPageState();
}

class _ZhongPinPageState extends State<ZhongPinPage> {


  bool yiStartSelected = true;
  bool erStartSelected = true;
  @override
  Widget build(BuildContext context) {
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: const Color(0xFFF0FAFE),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                // color: Colors.white,
                // decoration: const BoxDecoration(
                //   image: DecorationImage(
                //       image: AssetImage('assets/images/2.0x/img_tongdaoyi.png'),
                //     fit: BoxFit.contain,
                //   ),
                // ),
                  margin: EdgeInsets.only(top: 11.h),
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
                              )
                          ),
                          width: 340.w,
                          height: 120.h,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
                                child: TextButton(
                                    onPressed: (){
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset('assets/images/2.0x/icon_chufang.png',fit: BoxFit.cover,width: 19.w,height: 18.h,),
                                        SizedBox(width: 4.w,),
                                        Text('处方',style: TextStyle(fontSize: 18.sp,color: const Color(0xFF999999)),),
                                      ],
                                    )
                                ),
                              ),
                              PopupMenuBtn(
                                index: 7,
                              ),

                            ],
                          )
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 120.h,
                          enabled: true,
                          title: '时间',
                          assets: 'assets/images/2.0x/icon_shijian.png',
                          initialValue: 12,
                          unit: 'min',
                          valueListener: (value) {},
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 120.h,
                          enabled: true,
                          title: '强度',
                          assets: 'assets/images/2.0x/icon_qiangdu.png',
                          initialValue: 12,
                          valueListener: (value) {},
                        ),
                      ),

                      Container(
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              )
                          ),
                          child: TextButton(
                              onPressed: (){
                                yiStartSelected = !yiStartSelected;
                                setState(() {

                                });

                              },
                              child: Image.asset(yiStartSelected ? 'assets/images/2.0x/btn_kaishi_nor.png' : 'assets/images/2.0x/btn_tingzhi_nor.png',fit: BoxFit.cover,width: 120.w,height: 45.h,)
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),
            Container(
                width: 1,
                height: 487.h,
                margin: EdgeInsets.only(top: 11.h),
                color: const Color(0xFFD6D6D6),
                child: Text('',style: TextStyle(fontSize: 18.sp,color: Colors.black),)
            ),
            Expanded(
              flex: 1,
              child: Container(
                // color: Colors.white,
                // decoration: const BoxDecoration(
                //   image: DecorationImage(
                //       image: AssetImage('assets/images/2.0x/img_tongdaoyi.png'),
                //     fit: BoxFit.contain,
                //   ),
                // ),
                  margin: EdgeInsets.only(top: 11.h),
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
                              )
                          ),
                          width: 340.w,
                          height: 120.h,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
                                child: TextButton(
                                    onPressed: (){
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset('assets/images/2.0x/icon_chufang.png',fit: BoxFit.cover,width: 19.w,height: 18.h,),
                                        SizedBox(width: 4.w,),
                                        Text('处方',style: TextStyle(fontSize: 18.sp,color: const Color(0xFF999999)),),
                                      ],
                                    )
                                ),
                              ),
                              PopupMenuBtn(
                                index: 8,
                              ),

                            ],
                          )
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 120.h,
                          enabled: true,
                          title: '时间',
                          assets: 'assets/images/2.0x/icon_shijian.png',
                          initialValue: 12,
                          unit: 'min',
                          valueListener: (value) {},
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 120.h,
                          enabled: true,
                          title: '强度',
                          assets: 'assets/images/2.0x/icon_qiangdu.png',
                          initialValue: 12,
                          valueListener: (value) {},
                        ),
                      ),
                      Container(
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              )
                          ),
                          child: TextButton(
                              onPressed: (){
                                erStartSelected = !erStartSelected;
                                setState(() {

                                });
                              },
                              child: Image.asset(erStartSelected ? 'assets/images/2.0x/btn_kaishi_nor.png' : 'assets/images/2.0x/btn_tingzhi_nor.png',fit: BoxFit.cover,width: 120.w,height: 45.h,)
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
