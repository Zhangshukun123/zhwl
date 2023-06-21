import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhwlzlxt_project/page/jingLuan_page.dart';
import 'package:zhwlzlxt_project/page/jingPi_page.dart';
import 'package:zhwlzlxt_project/page/shenJing_page.dart';
import 'package:zhwlzlxt_project/page/zhongPin_page.dart';

class ElectrotherapyPage extends StatefulWidget {
  const ElectrotherapyPage({Key? key}) : super(key: key);

  @override
  State<ElectrotherapyPage> createState() => _ElectrotherapyPageState();
}

class _ElectrotherapyPageState extends State<ElectrotherapyPage> with SingleTickerProviderStateMixin {
  List tabs =['痉挛肌治疗','经皮神经电刺激','神经肌肉电刺激','中频/干扰电治疗'];
  //定义四个页面
  List<Widget> pageViewList = [
    JingLuanPage(),
    JingPiPage(),
    ShenJingPage(),
    ZhongPinPage()
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {

    });
  }

  @override
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
            Expanded(
              child: Container(
                // color: Colors.red,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Center(
                            child: Container(
                              height: 60.h,
                              // color:Colors.black,
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
                        ),
                        Container(
                          width: 78.w,
                          // margin: EdgeInsets.only(top: 15.5.h),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/2.0x/img_xiangqing.png'),
                                fit: BoxFit.fill, // 完全填充
                              )
                          ),
                          child: TextButton(
                              onPressed: (){

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
                      ],
                    ),
                    Expanded(child:  TabBarView(
                        controller: _tabController,
                        children: pageViewList
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
