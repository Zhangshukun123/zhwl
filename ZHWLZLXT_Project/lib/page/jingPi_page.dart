import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JingPiPage extends StatefulWidget {
  const JingPiPage({Key? key}) : super(key: key);

  @override
  State<JingPiPage> createState() => _JingPiPageState();
}

class _JingPiPageState extends State<JingPiPage> {
  @override
  Widget build(BuildContext context) {
    PopupMenuButton _popupMenuButton(BuildContext context){
      return PopupMenuButton(
        itemBuilder: (BuildContext context){
          return [
            const PopupMenuItem(child: Text("断续 1"),value: '连续 0',),
            const PopupMenuItem(child: Text("断续 2"),value: '连续 1',),
            const PopupMenuItem(child: Text("断续 3"),value: '连续 2',),
          ];
        },
        child:
        Row(
          children: [
            Expanded(child: Center(child: Text('断续 1',style: TextStyle(color: const Color(0xFF333333),fontSize: 18.sp),))),
            Image.asset('assets/images/2.0x/icon_xiala.png',width: 18,),
          ],
        ),
        onSelected: (ovc) async {
          print(ovc);
          setState(() {
            //刷新
          });
          //选择模式指令
          if (ovc == "连续 0") {//圣光被动跟随训练

          }
          else if (ovc == "连续 1") {//主动呼吸训练

          }
          else if (ovc == "连续 2") {//助力训练模式

          }

        },
        onCanceled: (){
          print('cancel');
        },

      );
    }
    bool yiStartSelected = true;
    bool erStartSelected = true;
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: Color(0xFFF0FAFE),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 487.h,
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
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          )
                        ),
                        width: 340.w,
                        height: 70.h,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20.w),
                              child: TextButton(
                                  onPressed: (){
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset('assets/images/2.0x/icon_moshi.png',fit: BoxFit.cover,width: 19.w,height: 18.h,),
                                      SizedBox(width: 4.w,),
                                      Text('模式',style: TextStyle(fontSize: 18.sp,color: const Color(0xFF999999)),),
                                    ],
                                  )
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Color(0xFFF0FAFE),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )
                              ),
                              width: 230.w,
                              height: 55.h,
                              child: _popupMenuButton(context),
                            ),
                          ],
                        )
                      ),
                      Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              )
                          ),
                        width: 340.w,
                        height: 70.h,
                          margin: EdgeInsets.only(top: 11.h),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
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
                                margin: EdgeInsets.only(left: 5.w,right: 5.w),
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
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              )
                          ),
                        width: 340.w,
                        height: 70.h,
                          margin: EdgeInsets.only(top: 11.h),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
                                width: 75.w,
                                child: TextButton(
                                    onPressed: (){

                                    },
                                    child: Row(
                                        children: [
                                          Image.asset('assets/images/2.0x/icon_qiangdu.png',fit: BoxFit.cover,width: 20.w,height: 18.h,),
                                          SizedBox(width: 2.5.w,),
                                          Text('强度',style: TextStyle(color: const Color(0xFF999999),fontSize: 18.sp),),
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
                                margin: EdgeInsets.only(left: 5.w,right: 5.w),
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
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              )
                          ),
                        width: 340.w,
                        height: 70.h,
                          margin: EdgeInsets.only(top: 11.h),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
                                width: 75.w,
                                child: TextButton(
                                    onPressed: (){

                                    },
                                    child: Row(
                                        children: [
                                          Image.asset('assets/images/2.0x/icon_pinlv.png',fit: BoxFit.cover,width: 20.w,height: 18.h,),
                                          SizedBox(width: 2.5.w,),
                                          Text('频率',style: TextStyle(color: const Color(0xFF999999),fontSize: 18.sp),),
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
                                margin: EdgeInsets.only(left: 5.w,right: 5.w),
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
                                    Text('Hz',style: TextStyle(color: const Color(0xFF999999),fontSize: 12.sp),),
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
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              )
                          ),
                        width: 340.w,
                        height: 70.h,
                          margin: EdgeInsets.only(top: 11.h),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
                                width: 75.w,
                                child: TextButton(
                                    onPressed: (){

                                    },
                                    child: Row(
                                        children: [
                                          Image.asset('assets/images/2.0x/icon_maikuan.png',fit: BoxFit.cover,width: 20.w,height: 18.h,),
                                          SizedBox(width: 2.5.w,),
                                          Text('脉宽',style: TextStyle(color: const Color(0xFF999999),fontSize: 18.sp),),
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
                                margin: EdgeInsets.only(left: 5.w,right: 5.w),
                                decoration: const BoxDecoration(
                                    color: Color(0xFFF0FAFE),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('60',style: TextStyle(color: const Color(0xFF333333),fontSize: 22.sp),),
                                    Text('μs',style: TextStyle(color: const Color(0xFF999999),fontSize: 12.sp),),
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
                  height: 487.h,
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
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              )
                          ),
                          width: 340.w,
                          height: 70.h,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
                                child: TextButton(
                                    onPressed: (){
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset('assets/images/2.0x/icon_moshi.png',fit: BoxFit.cover,width: 19.w,height: 18.h,),
                                        SizedBox(width: 4.w,),
                                        Text('模式',style: TextStyle(fontSize: 18.sp,color: const Color(0xFF999999)),),
                                      ],
                                    )
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xFFF0FAFE),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    )
                                ),
                                width: 230.w,
                                height: 55.h,
                                child: _popupMenuButton(context),
                              ),
                            ],
                          )
                      ),
                      Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              )
                          ),
                          width: 340.w,
                          height: 70.h,
                          margin: EdgeInsets.only(top: 11.h),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
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
                                margin: EdgeInsets.only(left: 5.w,right: 5.w),
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
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              )
                          ),
                          width: 340.w,
                          height: 70.h,
                          margin: EdgeInsets.only(top: 11.h),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
                                width: 75.w,
                                child: TextButton(
                                    onPressed: (){

                                    },
                                    child: Row(
                                        children: [
                                          Image.asset('assets/images/2.0x/icon_qiangdu.png',fit: BoxFit.cover,width: 20.w,height: 18.h,),
                                          SizedBox(width: 2.5.w,),
                                          Text('强度',style: TextStyle(color: const Color(0xFF999999),fontSize: 18.sp),),
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
                                margin: EdgeInsets.only(left: 5.w,right: 5.w),
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
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              )
                          ),
                          width: 340.w,
                          height: 70.h,
                          margin: EdgeInsets.only(top: 11.h),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
                                width: 75.w,
                                child: TextButton(
                                    onPressed: (){

                                    },
                                    child: Row(
                                        children: [
                                          Image.asset('assets/images/2.0x/icon_pinlv.png',fit: BoxFit.cover,width: 20.w,height: 18.h,),
                                          SizedBox(width: 2.5.w,),
                                          Text('频率',style: TextStyle(color: const Color(0xFF999999),fontSize: 18.sp),),
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
                                margin: EdgeInsets.only(left: 5.w,right: 5.w),
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
                                    Text('Hz',style: TextStyle(color: const Color(0xFF999999),fontSize: 12.sp),),
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
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              )
                          ),
                          width: 340.w,
                          height: 70.h,
                          margin: EdgeInsets.only(top: 11.h),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
                                width: 75.w,
                                child: TextButton(
                                    onPressed: (){

                                    },
                                    child: Row(
                                        children: [
                                          Image.asset('assets/images/2.0x/icon_maikuan.png',fit: BoxFit.cover,width: 20.w,height: 18.h,),
                                          SizedBox(width: 2.5.w,),
                                          Text('脉宽',style: TextStyle(color: const Color(0xFF999999),fontSize: 18.sp),),
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
                                margin: EdgeInsets.only(left: 5.w,right: 5.w),
                                decoration: const BoxDecoration(
                                    color: Color(0xFFF0FAFE),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('60',style: TextStyle(color: const Color(0xFF333333),fontSize: 22.sp),),
                                    Text('μs',style: TextStyle(color: const Color(0xFF999999),fontSize: 12.sp),),
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
