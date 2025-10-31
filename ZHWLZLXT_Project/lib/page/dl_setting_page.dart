import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Controller/serial_port.dart';
import '../base/globalization.dart';
import '../widget/set_value_horizontal.dart';

class DLSettingPage extends StatefulWidget {
  const DLSettingPage({super.key});

  @override
  State<DLSettingPage> createState() => _DLSettingPageState();
}

class _DLSettingPageState extends State<DLSettingPage> {
  var isOpen = false;

  var patter = Globalization.continuous.tr;

  var strength = 0;
  var strengthDAC = 0;
  var strengthDAC1 = 0;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: InkWell(
          onTap: () {
            Get.back();
          },
          child: Text(
            "返回",
            style: TextStyle(fontSize: 18.sp, color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  height: 90.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFFDBDBDB),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.w)),
                  ),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 33.w),
                          child: Text(
                            '低频校准',
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontSize: 18.sp),
                          )),
                      Expanded(
                          child: SizedBox(
                        width: 10.w,
                      )),
                      SetValueHorizontal(
                        enabled: true,
                        assets: 'assets/images/2.0x/icon_gonglv.png',
                        initialValue: strengthDAC.toDouble(),
                        width: 250.w,
                        appreciation: 1,
                        maxValue: 1000,
                        indexType: 100101,
                        isInt: true,
                        valueListener: (value) {
                          strengthDAC = value.toInt();
                          var dac =
                              "01 00 c2 ${intToHexWithSpace(strengthDAC)} 00 00 00 00 00 00";
                          SerialPort().send(dac, false);
                        },
                      ),
                    ],
                  )),
              Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  height: 90.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFFDBDBDB),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.w)),
                  ),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 33.w),
                          child: Text(
                            '中频干扰电校准',
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontSize: 18.sp),
                          )),
                      Expanded(
                          child: SizedBox(
                        width: 10.w,
                      )),
                      SetValueHorizontal(
                        enabled: true,
                        assets: 'assets/images/2.0x/icon_gonglv.png',
                        initialValue: strengthDAC1.toDouble(),
                        width: 250.w,
                        appreciation: 1,
                        indexType: 100101,
                        maxValue: 500,
                        isInt: true,
                        valueListener: (value) {
                          strengthDAC1 = value.toInt();
                          var dac =
                              "01 00 d2 ${intToHexWithSpace(strengthDAC1)} 00 00 00 00 00 00";
                          SerialPort().send(dac, false);
                        },
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  String intToHexWithSpace(int n, {int minBytes = 2}) {
    String hex = n.toRadixString(16).toUpperCase().padLeft(minBytes * 2, '0');
    return hex.replaceAllMapped(RegExp(r'.{2}'), (m) => '${m.group(0)} ').trim();
  }

}
