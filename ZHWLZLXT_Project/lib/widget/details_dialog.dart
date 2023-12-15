import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../base/globalization.dart';
import '../page/attention_page.dart';
import '../page/operate_page.dart';

class DetailsDialog {
  List<Widget>? pageViewList;
  int? index;

  DetailsDialog({
    this.index,
  });

  List tabs = [
    '操作说明',
    '注意事项',
  ];
  late final TabController tabController;

  void setTabController(TabController tabController) {
    this.tabController = tabController;
  }

  void setTabs(List tabs) {
    this.tabs = tabs;
  }

  // void setPgeViewList(List<Widget> pageViewList){
  //   this.pageViewList = pageViewList;
  // }

  void showCustomDialog(BuildContext context) {
    tabs = [
      Globalization.OI.tr,
      Globalization.NeedAttention.tr,
    ];
    pageViewList = [
      OperatePage(
        index: index,
      ),
      AttentionPage(
        index: index,
      ),
    ];

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
            )),
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
                            child: Text(
                              Globalization.details.tr,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.sp),
                            )),
                        const Expanded(child: SizedBox()),
                        Container(
                          margin: EdgeInsets.only(right: 20.w),
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Image.asset(
                                'assets/images/2.0x/btn_guanbi.png',
                                fit: BoxFit.cover,
                                width: 22.w,
                                height: 22.h,
                              )),
                        )
                      ],
                    )),
                SizedBox(
                    width: 700.w,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 120,
                          child: Center(
                            child: TabBar(
                              indicatorColor: const Color(0xFF00A8E7),
                              //// 底部指示器颜色
                              indicatorSize: TabBarIndicatorSize.tab,
                              //指示器宽度
                              isScrollable: true,
                              // 标签 Tab 是否可滑动
                              labelColor: const Color(0xFF00A8E7),
                              //标签 Tab 内容颜色
                              labelStyle: const TextStyle(fontSize: 30),
                              //// 标签 Tab 内容样式
                              indicatorWeight: 4.0,
                              //指示器宽度
                              unselectedLabelStyle:
                                  const TextStyle(fontSize: 28),
                              //未选中标签样式
                              unselectedLabelColor: const Color(0xFF666666),
                              //未选中标签 Tab 颜色
                              tabs: tabs.map((e) => Tab(text: e)).toList(),
                              controller: tabController,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 700.w,
                          height: 240.h,
                          child: TabBarView(
                              controller: tabController,
                              children: pageViewList!),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
