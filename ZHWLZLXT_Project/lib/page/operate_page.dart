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
    return Container(
      margin: EdgeInsets.only(top: 10.h, left: 26.w, right: 26.w, bottom: 20.h),
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Text(
            textString(widget.index),
            style: const TextStyle(fontSize: 34, color: Color(0xFF999999)),
          )
        ],
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
      return Globalization.detailsSeven.tr;
    }
    return 'AAAAAA';
  }
}
