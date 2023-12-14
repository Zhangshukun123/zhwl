import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../base/globalization.dart';

class OperatePage extends StatefulWidget {
  int? index;

  OperatePage({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  State<OperatePage> createState() => _OperatePageState();
}

class _OperatePageState extends State<OperatePage> {
  @override
  Widget build(BuildContext context) {
    // ScreenUtil().orientation;
    // ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin:
              EdgeInsets.only(top: 10.h, left: 26.w, right: 26.w, bottom: 20.h),
          child: SingleChildScrollView(
            child: Text(
              textString(widget.index),
              style: const TextStyle(fontSize: 34, color: Color(0xFF999999)),
            ),
          ),
        ),
      ),
    );
  }

  String textString(int? index) {
    if (index == 1) {
      return Globalization.detailsOne.tr;
    }
    if (index == 2) {
      return Globalization.detailsTwo.tr;
    }
    if (index == 3) {
      return Globalization.detailsThree.tr;
    }
    if (index == 4) {
      return Globalization.detailsFour.tr;
    }
    if (index == 5) {
      return Globalization.detailsFive.tr;
    }
    if (index == 6) {
      return Globalization.detailsSix.tr;
    }
    if (index == 7) {
      return '中频/干扰电模块包括中频、干扰电两种治疗模式。\n'
          '处方1～50是中频治疗处方，在中频治疗模式下有通道一、通道二两个治疗通道，互不干扰；\n'
          '处方51～60是干扰电治疗处方，在干扰电治疗模式下两个通道同时工作。\n'
          '中频操作说明：\n'
          '1.将电极片与中频输出接口妥善连接。\n'
          '2.处方选择范围1～50。\n'
          '3.治疗时间已在处方内，不需要设置。\n'
          '4.点击开始按钮，可以调节强度（0～99可调，步进为1），请慢速调节强度，在调节的过程中，不断询问患者的感受。\n'
          '5.当设定治疗时间结束或手动停止输出，输出停止。\n'
          '6.“+、-”键的图标为灰色表示不可选。\n'
          '提示：中频治疗有两个不同的治疗通道，通道一、通道二可以单独进行治疗，也可以司时进行治疗。上述操作步骤以通道一为例。\n'
          '干扰电操作说明：\n'
          '1.干扰电输出，需要使用四个干扰电极片。\n'
          '2.处方选择范围51～60。\n'
          '3.治疗时间已在处方内，不需要设置。\n'
          '4.点击开始按钮，可以调节强度（0～99可调，步进为1），请慢速调节输出强度，如果是负压吸附治疗调节吸附压力，在调节的过程中不断询问患者的感受。\n'
          '5.当设定治疗时间结束或手动停止输出，输出停止。\n'
          '6.“+、-”键的图标为灰色表示不可选。';
    }
    return 'AAAAAA';
  }
}
