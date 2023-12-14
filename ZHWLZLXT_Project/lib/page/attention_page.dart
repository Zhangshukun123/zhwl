import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../base/globalization.dart';

class AttentionPage extends StatefulWidget {

  int? index;

  AttentionPage({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  State<AttentionPage> createState() => _AttentionPageState();
}

class _AttentionPageState extends State<AttentionPage> {
  @override
  Widget build(BuildContext context) {
    // ScreenUtil().orientation;
    // ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 10.h,left: 26.w,right: 26.w,bottom: 70.h),
          child:  SingleChildScrollView(
            child:
            Text(
              textString(widget.index),
              style: const TextStyle(fontSize: 32,color: Color(0xFF999999)),
            ),

          ),
        ),
      ),
    );
  }


  String textString(int? index){
    if(index == 1){
      return  Globalization.AttentionOne.tr;
    }
    if(index == 2){
      return  Globalization.AttentionTwo.tr;
    }
    if(index == 3){
      return  Globalization.AttentionThree.tr;
    }
    if(index == 4){
      return  Globalization.AttentionFour.tr;
    }
    if(index == 5){
      return  Globalization.AttentionFour.tr;
    }
    if(index == 6){
      return  Globalization.AttentionFour.tr;
    }
    if(index == 7){
      return  Globalization.AttentionFour.tr;
    }
    return 'AAAAAA';
  }

}
