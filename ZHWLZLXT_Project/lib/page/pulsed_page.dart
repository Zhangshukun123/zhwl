import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhwlzlxt_project/page/operate_page.dart';
import 'package:zhwlzlxt_project/page/user_head_view.dart';
import 'package:zhwlzlxt_project/widget/container_bg.dart';
import 'package:zhwlzlxt_project/widget/set_value.dart';

import '../widget/details_dialog.dart';
import 'attention_page.dart';

class PulsedPage extends StatefulWidget {
  const PulsedPage({Key? key}) : super(key: key);

  @override
  State<PulsedPage> createState() => _PulsedPageState();
}

class _PulsedPageState extends State<PulsedPage>
    with SingleTickerProviderStateMixin {

  //定义四个页面
  late TabController _tabController;

  DetailsDialog? dialog;

  @override
  void initState() {
    super.initState();
    dialog = DetailsDialog();
    _tabController =
        TabController(length: dialog?.tabs.length ?? 0, vsync: this);
    _tabController.addListener(() {});

    dialog?.setTabController(_tabController);
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
            const UserHeadView(),
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
                      ContainerBg(
                          width: 416.w,
                          height: 150.h,
                          margin: EdgeInsets.only(top: 25.h),
                          child:
                          SetValue(
                            enabled: true,
                            title: '频率',
                            assets: 'assets/images/2.0x/icon_pinlv.png',
                            initialValue: 12,
                            unit: '次/min',
                            valueListener: (value) {},
                          )
                      ),
                      ContainerBg(
                          width: 416.w,
                          height: 150.h,
                          margin: EdgeInsets.only(top: 25.h),
                          child:
                          SetValue(
                            enabled: true,
                            title: '时间',
                            assets: 'assets/images/2.0x/icon_shijian.png',
                            initialValue: 12,
                            unit: 'min',
                            valueListener: (value) {},
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
                                width: 120.w,
                                height: 70.h,
                                child: TextButton(
                                    onPressed: (){
                                      switchSelected = !switchSelected;
                                      setState(() {

                                      });
                                    },
                                    child: Image.asset(switchSelected ? 'assets/images/2.0x/img_kai.png' : 'assets/images/2.0x/img_guan.png',fit: BoxFit.fill,width: 120.w,height: 70.h,)
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
                                    onPressed: () {
                                      dialog?.showCustomDialog(context);
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
                                  width: 180.w,
                                  height: 70.h,
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
