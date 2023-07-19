import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhwlzlxt_project/page/operate_page.dart';
import 'package:zhwlzlxt_project/widget/container_bg.dart';
import 'package:zhwlzlxt_project/widget/set_value.dart';

import 'attention_page.dart';

class PulsedPage extends StatefulWidget {
  const PulsedPage({Key? key}) : super(key: key);

  @override
  State<PulsedPage> createState() => _PulsedPageState();
}

class _PulsedPageState extends State<PulsedPage> with SingleTickerProviderStateMixin{



  List tabs =['操作说明','注意事项',];
  //定义四个页面
  List<Widget> pageViewList = [
    OperatePage(),
    AttentionPage(),
  ];
  late TabController _tabController;

  void showCustomDialog() {
    showDialog(
      barrierDismissible: true, //表示点击灰色背景的时候是否消失弹出框
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 700.w,
            height: 400.h,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                )
            ),
            child: Column(
              children: [
                Container(
                    width: 700.w,
                    height: 50.h,
                    color: const Color(0xFF00A8E7),
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 330.w),
                            child: Text("详情", style: TextStyle(color: Colors.white,fontSize: 18.sp),)
                        ),
                        const Expanded(child: SizedBox()),
                        Container(
                          margin: EdgeInsets.only(right: 20.w),
                          child: TextButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              child: Image.asset('assets/images/2.0x/btn_guanbi.png',fit: BoxFit.cover,width: 22.w,height: 22.h,)
                          ),
                        )
                      ],
                    )
                ),
                Container(
                    width: 700.w,
                    height: 350.h,
                    child: Column(
                      children: [
                        Container(
                          width: 700.w,
                          height: 80.h,
                          child: Center(
                            child: TabBar(
                              indicatorColor: const Color(0xFF00A8E7),//// 底部指示器颜色
                              indicatorSize: TabBarIndicatorSize.tab,//指示器宽度
                              isScrollable: true,// 标签 Tab 是否可滑动
                              labelColor: const Color(0xFF00A8E7),//标签 Tab 内容颜色
                              labelStyle: TextStyle(fontSize: 20.sp),//// 标签 Tab 内容样式
                              indicatorWeight: 4.0,//指示器宽度
                              unselectedLabelStyle: TextStyle(fontSize: 17.sp),//未选中标签样式
                              unselectedLabelColor: const Color(0xFF666666),//未选中标签 Tab 颜色
                              tabs: tabs.map((e) => Tab(text: e)).toList(),
                              controller: _tabController,
                            ),
                          ),
                        ),
                        Container(
                          width: 700.w,
                          height: 270.h,
                          child: TabBarView(
                              controller: _tabController,
                              children: pageViewList
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
    });
  }

  @override

  bool startSelected = true;
  bool switchSelected = true;

  Widget build(BuildContext context) {
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: const Color(0xFFF0FAFE),
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
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 35.w,right: 35.w,top: 17.5.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ContainerBg(
                          width: 416.w,
                          height: 150.h,
                          child:

                          SetValue(
                            enabled: true,
                            title: '强度',
                            assets: 'assets/images/2.0x/icon_qiangdu.png',
                            initialValue: 12,
                            valueListener: (value) {},
                          )
                      ),
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
                        margin: EdgeInsets.only(top: 25.h),

                          width: 416.w,
                          height: 150.h,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 29.h),
                                width:70.w,
                                child: TextButton(
                                    onPressed: (){
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/images/2.0x/icon_pinlv.png',fit: BoxFit.cover,width: 19.w,height: 18.h,),
                                        SizedBox(width: 1.w,),
                                        Text('频率',style: TextStyle(fontSize: 18.sp,color: const Color(0xFF999999)),),
                                      ],
                                    )
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: (){},
                                      child:
                                      Image.asset('assets/images/2.0x/btn_jian_nor.png',fit: BoxFit.cover,width: 38.w,height: 34.h,)
                                  ),
                                  Container(
                                    width: 120.w,
                                    height: 55.h,
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
                                        Text('次/min',style: TextStyle(color: const Color(0xFF999999),fontSize: 12.sp),),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: (){},
                                      child:
                                      Image.asset('assets/images/2.0x/btn_jia_nor.png',fit: BoxFit.cover,width: 38.w,height: 34.h,)
                                  ),
                                ],
                              ),
                            ],
                          )
                      ),
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
                          margin: EdgeInsets.only(top: 25.h),

                          width: 416.w,
                          height: 150.h,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 29.h),
                                width:70.w,
                                child: TextButton(
                                    onPressed: (){
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/images/2.0x/icon_shijian.png',fit: BoxFit.cover,width: 19.w,height: 18.h,),
                                        SizedBox(width: 1.w,),
                                        Text('时间',style: TextStyle(fontSize: 18.sp,color: const Color(0xFF999999)),),
                                      ],
                                    )
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: (){},
                                      child:
                                      Image.asset('assets/images/2.0x/btn_jian_nor.png',fit: BoxFit.cover,width: 38.w,height: 34.h,)
                                  ),
                                  Container(
                                    width: 120.w,
                                    height: 55.h,
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
                              ),
                            ],
                          )
                      ),
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
                              )
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 60.h),
                                child: TextButton(
                                    onPressed: (){},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/images/2.0x/icon_zhendong.png',fit: BoxFit.cover,),
                                        Text('振动',style: TextStyle(color: Color(0xFF999999),fontSize: 18.sp),),
                                      ],
                                    )
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 25.h),
                                child: TextButton(
                                    onPressed: (){
                                      switchSelected = !switchSelected;
                                      setState(() {

                                      });
                                    },
                                    child: Image.asset(switchSelected ? 'assets/images/2.0x/img_kai.png' : 'assets/images/2.0x/img_guan.png',fit: BoxFit.cover,)
                                ),
                              ),
                            ],
                          )
                      ),
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
                              )
                          ),
                        margin: EdgeInsets.only(top: 30.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 78.w,
                                margin: EdgeInsets.only(top: 15.5.h),
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/2.0x/img_xiangqing.png'),
                                      fit: BoxFit.fill, // 完全填充
                                    )
                                ),
                                child: TextButton(
                                    onPressed: (){
                                      showCustomDialog();
                                    },
                                    child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Image.asset('assets/images/2.0x/icon_xiangqing.png',fit: BoxFit.fill,width: 18.w,height: 18.h,),
                                        Text('详情',style: TextStyle(color: const Color(0xFF009CB4),fontSize: 18.sp),),

                                      ],
                                    )),
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 34.5.h),
                                  width: 120.w,
                                  height: 55.h,
                                  child: TextButton(
                                    onPressed: (){
                                      startSelected = !startSelected;
                                      setState(() {

                                      });
                                    },
                                    child:
                                    Image.asset(startSelected ? 'assets/images/2.0x/btn_kaishi_nor.png' : 'assets/images/2.0x/btn_tingzhi_nor.png',fit: BoxFit.fill,),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
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
