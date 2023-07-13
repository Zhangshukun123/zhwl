import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JingLuanPage extends StatefulWidget {
  const JingLuanPage({Key? key}) : super(key: key);

  @override
  State<JingLuanPage> createState() => _JingLuanPageState();
}

class _JingLuanPageState extends State<JingLuanPage> {

  bool jingStartSelected = true;
  @override
  Widget build(BuildContext context) {

    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: Color(0xFFF0FAFE),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 35.w,right: 35.w),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 340.w,
                    height: 100.h,
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

                      child: Row(
                        children: [
                          Container(
                            width: 75.w,
                            child: TextButton(
                                onPressed: (){

                                },
                                child: Row(
                                  children: [
                                    Image.asset('assets/images/2.0x/icon_shijian.png',fit: BoxFit.cover,width: 20.w,height: 18.h,),
                                    SizedBox(width: 2.5.w,),
                                    Text('时间',style: TextStyle(color: const Color(0xFF999999),fontSize: 18.sp),),
                                  ]
                                )
                            ),
                          ),
                          TextButton(
                              onPressed: (){},
                              child:
                              Image.asset('assets/images/2.0x/btn_jian_nor.png',fit: BoxFit.cover,width: 38.w,height: 34.h,)
                          ),
                          Container(
                            width: 120.w,
                            height: 55.h,
                            margin: EdgeInsets.only(left: 15.w,right: 15.w),
                            decoration: const BoxDecoration(
                                color: Color(0xFFF0FAFE),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('12',style: TextStyle(color: const Color(0xFF333333),fontSize: 22.sp),),
                                Text('min',style: TextStyle(color: const Color(0xFF999999),fontSize: 12.sp),),
                              ],
                            ),
                          ),
                          TextButton(
                              onPressed: (){},
                              child:
                              Image.asset('assets/images/2.0x/btn_jia_nor.png',fit: BoxFit.cover,width: 38.w,height: 34.h,)
                          ),
                        ],
                      )
                  ),
                  Container(
                    width: 340.w,
                    height: 100.h,
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
                      child: Row(
                        children: [
                          Container(
                            width: 75.w,
                            child: TextButton(
                                onPressed: (){

                                },
                                child: Row(
                                    children: [
                                      Image.asset('assets/images/2.0x/icon_maikuan.png',fit: BoxFit.cover,width: 20.w,height: 18.h,),
                                      SizedBox(width: 2.5.w,),
                                      Expanded(child: Text('脉宽 (A)',style: TextStyle(color: const Color(0xFF999999),fontSize: 18.sp),)),
                                    ]
                                )
                            ),
                          ),
                          TextButton(
                              onPressed: (){},
                              child:
                              Image.asset('assets/images/2.0x/btn_jian_nor.png',fit: BoxFit.cover,width: 38.w,height: 34.h,)
                          ),
                          Container(
                            width: 120.w,
                            height: 55.h,
                            margin: EdgeInsets.only(left: 15.w,right: 15.w),
                            decoration: const BoxDecoration(
                                color: Color(0xFFF0FAFE),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('0.1',style: TextStyle(color: const Color(0xFF333333),fontSize: 22.sp),),
                                Text('ms',style: TextStyle(color: const Color(0xFF999999),fontSize: 12.sp),),
                              ],
                            ),
                          ),
                          TextButton(
                              onPressed: (){},
                              child:
                              Image.asset('assets/images/2.0x/btn_jia_nor.png',fit: BoxFit.cover,width: 38.w,height: 34.h,)
                          ),
                        ],
                      )
                  ),
                  Container(
                      width: 340.w,
                      height: 100.h,
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
                      child: Row(
                        children: [
                          Container(
                            width: 75.w,
                            child: TextButton(
                                onPressed: (){

                                },
                                child: Row(
                                    children: [
                                      Image.asset('assets/images/2.0x/icon_maikuan.png',fit: BoxFit.cover,width: 20.w,height: 18.h,),
                                      SizedBox(width: 2.5.w,),
                                      Expanded(child: Text('脉宽 (B)',style: TextStyle(color: const Color(0xFF999999),fontSize: 18.sp),)),
                                    ]
                                )
                            ),
                          ),
                          TextButton(
                              onPressed: (){},
                              child:
                              Image.asset('assets/images/2.0x/btn_jian_nor.png',fit: BoxFit.cover,width: 38.w,height: 34.h,)
                          ),
                          Container(
                            width: 120.w,
                            height: 55.h,
                            margin: EdgeInsets.only(left: 15.w,right: 15.w),
                            decoration: const BoxDecoration(
                                color: Color(0xFFF0FAFE),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('0.1',style: TextStyle(color: const Color(0xFF333333),fontSize: 22.sp),),
                                Text('ms',style: TextStyle(color: const Color(0xFF999999),fontSize: 12.sp),),
                              ],
                            ),
                          ),
                          TextButton(
                              onPressed: (){},
                              child:
                              Image.asset('assets/images/2.0x/btn_jia_nor.png',fit: BoxFit.cover,width: 38.w,height: 34.h,)
                          ),
                        ],
                      )
                  ),
                  Container(
                      width: 340.w,
                      height: 100.h,
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
                      child: Row(
                        children: [
                          Container(
                            width: 75.w,
                            child: TextButton(
                                onPressed: (){

                                },
                                child: Row(
                                    children: [
                                      Image.asset('assets/images/2.0x/icon_yanshi.png',fit: BoxFit.cover,width: 20.w,height: 18.h,),
                                      SizedBox(width: 2.5.w,),
                                      Expanded(child: Text('延时时间',style: TextStyle(color: const Color(0xFF999999),fontSize: 18.sp),)),
                                    ]
                                )
                            ),
                          ),
                          TextButton(
                              onPressed: (){},
                              child:
                              Image.asset('assets/images/2.0x/btn_jian_nor.png',fit: BoxFit.cover,width: 38.w,height: 34.h,)
                          ),
                          Container(
                            width: 120.w,
                            height: 55.h,
                            margin: EdgeInsets.only(left: 15.w,right: 15.w),
                            decoration: const BoxDecoration(
                                color: Color(0xFFF0FAFE),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('0.1',style: TextStyle(color: const Color(0xFF333333),fontSize: 22.sp),),
                                Text('s',style: TextStyle(color: const Color(0xFF999999),fontSize: 12.sp),),
                              ],
                            ),
                          ),
                          TextButton(
                              onPressed: (){},
                              child:
                              Image.asset('assets/images/2.0x/btn_jia_nor.png',fit: BoxFit.cover,width: 38.w,height: 34.h,)
                          ),
                        ],
                      )
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 30.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: 340.w,
                        height: 100.h,
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
                        child: Row(
                          children: [
                            Container(
                              width: 75.w,
                              child: TextButton(
                                  onPressed: (){

                                  },
                                  child: Row(
                                      children: [
                                        Image.asset('assets/images/2.0x/icon_maichong.png',fit: BoxFit.cover,width: 20.w,height: 18.h,),
                                        SizedBox(width: 2.5.w,),
                                        Expanded(child: Text('脉冲周期',style: TextStyle(color: const Color(0xFF999999),fontSize: 18.sp),)),
                                      ]
                                  )
                              ),
                            ),
                            TextButton(
                                onPressed: (){},
                                child:
                                Image.asset('assets/images/2.0x/btn_jian_nor.png',fit: BoxFit.cover,width: 38.w,height: 34.h,)
                            ),
                            Container(
                              width: 120.w,
                              height: 55.h,
                              margin: EdgeInsets.only(left: 15.w,right: 15.w),
                              decoration: const BoxDecoration(
                                  color: Color(0xFFF0FAFE),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('1.0',style: TextStyle(color: const Color(0xFF333333),fontSize: 22.sp),),
                                  Text('s',style: TextStyle(color: const Color(0xFF999999),fontSize: 12.sp),),
                                ],
                              ),
                            ),
                            TextButton(
                                onPressed: (){},
                                child:
                                Image.asset('assets/images/2.0x/btn_jia_nor.png',fit: BoxFit.cover,width: 38.w,height: 34.h,)
                            ),
                          ],
                        )
                    ),
                    Container(
                        width: 340.w,
                        height: 100.h,
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
                        child: Row(
                          children: [
                            Container(
                              width: 75.w,
                              child: TextButton(
                                  onPressed: (){

                                  },
                                  child: Row(
                                      children: [
                                        Image.asset('assets/images/2.0x/icon_qiangdu.png',fit: BoxFit.cover,width: 20.w,height: 18.h,),
                                        SizedBox(width: 2.5.w,),
                                        Expanded(child: Text('强度 (A)',style: TextStyle(color: const Color(0xFF999999),fontSize: 18.sp),)),
                                      ]
                                  )
                              ),
                            ),
                            TextButton(
                                onPressed: (){},
                                child:
                                Image.asset('assets/images/2.0x/btn_jian_nor.png',fit: BoxFit.cover,width: 38.w,height: 34.h,)
                            ),
                            Container(
                              width: 120.w,
                              height: 55.h,
                              margin: EdgeInsets.only(left: 15.w,right: 15.w),
                              decoration: const BoxDecoration(
                                  color: Color(0xFFF0FAFE),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('1',style: TextStyle(color: const Color(0xFF333333),fontSize: 22.sp),),
                                ],
                              ),
                            ),
                            TextButton(
                                onPressed: (){},
                                child:
                                Image.asset('assets/images/2.0x/btn_jia_nor.png',fit: BoxFit.cover,width: 38.w,height: 34.h,)
                            ),
                          ],
                        )
                    ),
                    Container(
                        width: 340.w,
                        height: 100.h,
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
                        child: Row(
                          children: [
                            Container(
                              width: 75.w,
                              child: TextButton(
                                  onPressed: (){

                                  },
                                  child: Row(
                                      children: [
                                        Image.asset('assets/images/2.0x/icon_qiangdu.png',fit: BoxFit.cover,width: 20.w,height: 18.h,),
                                        SizedBox(width: 2.5.w,),
                                        Expanded(child: Text('强度 (B)',style: TextStyle(color: const Color(0xFF999999),fontSize: 18.sp),)),
                                      ]
                                  )
                              ),
                            ),
                            TextButton(
                                onPressed: (){},
                                child:
                                Image.asset('assets/images/2.0x/btn_jian_nor.png',fit: BoxFit.cover,width: 38.w,height: 34.h,)
                            ),
                            Container(
                              width: 120.w,
                              height: 55.h,
                              margin: EdgeInsets.only(left: 15.w,right: 15.w),
                              decoration: const BoxDecoration(
                                  color: Color(0xFFF0FAFE),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('0.1',style: TextStyle(color: const Color(0xFF333333),fontSize: 22.sp),),
                                  Text('s',style: TextStyle(color: const Color(0xFF999999),fontSize: 12.sp),),
                                ],
                              ),
                            ),
                            TextButton(
                                onPressed: (){},
                                child:
                                Image.asset('assets/images/2.0x/btn_jia_nor.png',fit: BoxFit.cover,width: 38.w,height: 34.h,)
                            ),
                          ],
                        )
                    ),
                    Container(
                        width: 340.w,
                        height: 100.h,
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
                        child: Container(
                          child: TextButton(
                            onPressed: (){
                              jingStartSelected = !jingStartSelected;
                              setState(() {

                              });
                            },
                            child:
                            Image.asset(jingStartSelected ? 'assets/images/2.0x/btn_kaishi_nor.png' : 'assets/images/2.0x/btn_tingzhi_nor.png',fit: BoxFit.fill,width: 120.w,height: 55.h,),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
