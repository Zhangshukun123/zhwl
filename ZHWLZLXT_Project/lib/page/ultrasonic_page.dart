import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhwlzlxt_project/page/attention_page.dart';
import 'package:zhwlzlxt_project/page/operate_page.dart';
import 'package:zhwlzlxt_project/page/control_page.dart';
import 'package:zhwlzlxt_project/page/set_page.dart';

class UltrasonicPage extends StatefulWidget {
  const UltrasonicPage({Key? key}) : super(key: key);

  @override
  State<UltrasonicPage> createState() => _UltrasonicPageState();
}

class _UltrasonicPageState extends State<UltrasonicPage> with SingleTickerProviderStateMixin{

  //模式选择
  String patternStr = "连续 0";
  //频率选择
  String frequencyStr = "1";

  PopupMenuButton _popupMenuButton(BuildContext context){
    return PopupMenuButton(
      itemBuilder: (BuildContext context){
        return [
          const PopupMenuItem(child: Text("断续 0"),value: '连续 0',),
          const PopupMenuItem(child: Text("断续 1"),value: '连续 1',),
          const PopupMenuItem(child: Text("断续 2"),value: '连续 2',),
        ];
      },
      child:
      Row(
        children: [
          Expanded(child: Center(child: Text(patternStr,style: TextStyle(color: const Color(0xFF333333),fontSize: 18.sp),))),
          Image.asset('assets/images/2.0x/icon_xiala.png',width: 18,),
        ],
      ),
      onSelected: (ovc) async {
        print(ovc);
        patternStr = ovc;
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
  PopupMenuButton _popupMenuButton2(BuildContext context){
    return PopupMenuButton(
      itemBuilder: (BuildContext context){
        return [
          const PopupMenuItem(child: Text("1"),value: '1',),
          const PopupMenuItem(child: Text("2"),value: '2',),
          const PopupMenuItem(child: Text("3"),value: '3',),
        ];
      },
      child:
      Row(
        children: [
          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(frequencyStr,style: TextStyle(color: const Color(0xFF333333),fontSize: 18.sp),),
              Text('w',style: TextStyle(color: const Color(0xFF999999),fontSize: 12.sp),),
            ],
          )),
          Image.asset('assets/images/2.0x/icon_xiala.png',width: 18,),
        ],
      ),
      onSelected: (ovc) async {
        print(ovc);
        frequencyStr = ovc;
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

  bool startSelected = true;

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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => const ControlPage()));
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => const SetPage()));

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
            Container(
              padding: EdgeInsets.only(left: 35.w,right: 35.w,top: 17.5.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: 150.h,
                      child: Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              )
                            ),
                            width: 340.w,
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
                                            Image.asset('assets/images/2.0x/icon_moshi.png',fit: BoxFit.cover,width: 19.w,height: 18.h,),
                                            SizedBox(width: 1.w,),
                                            Text('模式',style: TextStyle(fontSize: 18.sp,color: const Color(0xFF999999)),),
                                          ],
                                        )),
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
                            margin: EdgeInsets.only(left: 30.w),
                              width: 340.w,
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
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25.h),
                      height: 150.h,
                      child: Row(
                        children: [
                          Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  )
                              ),
                              width: 340.w,
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
                                            Image.asset('assets/images/2.0x/icon_gonglv.png',fit: BoxFit.cover,width: 19.w,height: 18.h,),
                                            SizedBox(width: 1.w,),
                                            Text('功率',style: TextStyle(fontSize: 18.sp,color: const Color(0xFF999999)),),
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
                                          Image.asset('assets/images/2.0x/btn_jian_disabled.png',fit: BoxFit.cover,width: 38.w,height: 34.h,)
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
                                            Text('1',style: TextStyle(color: const Color(0xFF333333),fontSize: 22.sp),),
                                            Text('w',style: TextStyle(color: const Color(0xFF999999),fontSize: 12.sp),),
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: (){},
                                          child:
                                          Image.asset('assets/images/2.0x/btn_jia_disabled.png',fit: BoxFit.cover,width: 38.w,height: 34.h,)
                                      ),
                                    ],
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
                              margin: EdgeInsets.only(left: 30.w),
                              width: 340.w,
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
                                            Image.asset('assets/images/2.0x/icon_shengqiang.png',fit: BoxFit.cover,width: 19.w,height: 18.h,),
                                            SizedBox(width: 1.w,),
                                            Text('声强',style: TextStyle(fontSize: 18.sp,color: const Color(0xFF999999)),),
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
                                          Image.asset('assets/images/2.0x/btn_jian_disabled.png',fit: BoxFit.cover,width: 38.w,height: 34.h,)
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
                                            Text('0.3',style: TextStyle(color: const Color(0xFF333333),fontSize: 22.sp),),
                                            Text('w/cm2',style: TextStyle(color: const Color(0xFF999999),fontSize: 12.sp),),
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: (){},
                                          child:
                                          Image.asset('assets/images/2.0x/btn_jia_disabled.png',fit: BoxFit.cover,width: 38.w,height: 34.h,)
                                      ),
                                    ],
                                  ),
                                ],
                              )
                          ),
                        ],
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 25.h),
                      height: 150.h,
                      child: Row(
                        children: [
                          Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  )
                              ),
                              width: 340.w,
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
                                        )),
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
                                    child: _popupMenuButton2(context),
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
                              margin: EdgeInsets.only(left: 30.w),
                              width: 340.w,
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
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
