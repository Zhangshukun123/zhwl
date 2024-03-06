import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../base/globalization.dart';
import '../entity/ultrasonic_sound.dart';
import '../utils/event_bus.dart';
import '../utils/sp_utils.dart';
import '../utils/utils_tool.dart';
import '../widget/popup_menu_btn.dart';
import '../widget/set_value_horizontal.dart';

class PgSettingPage extends StatefulWidget {
  const PgSettingPage({super.key});

  @override
  State<PgSettingPage> createState() => _PgSettingPageState();
}

class _PgSettingPageState extends State<PgSettingPage> {
  var isOpen = false;

  var patter = Globalization.continuous.tr;

  var strength = 0;
  var strengthDAC = 0;

  @override
  void initState() {
    super.initState();
    strengthDAC = SpUtils.getInt('InfraredPage', defaultValue: 0)!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text(
          "返回",
          style: TextStyle(fontSize: 18.sp, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: 700.w,
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
                            '偏光亮度',
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
                        indexType: 100101,
                        isInt: true,
                        valueListener: (value) {
                          strengthDAC = value.toInt();
                        },
                      ),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: 43.h,
                      width: 110.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00C290),
                        borderRadius: BorderRadius.all(Radius.circular(7.w)),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (isOpen) {
                            eventBus.fire(const MethodCall("openPg"));
                          } else {
                            eventBus.fire(const MethodCall("closePg"));
                          }
                          isOpen = !isOpen;
                          setState(() {});
                        },
                        child: Text(
                          isOpen ? "关闭偏光" : "开启偏光",
                          style: TextStyle(
                              color: const Color(0xFFFFFFFF), fontSize: 18.sp),
                        ),
                      )),
                  Container(
                      height: 43.h,
                      width: 110.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A8E7),
                        borderRadius: BorderRadius.all(Radius.circular(7.w)),
                      ),
                      child: TextButton(
                          onPressed: () {
                            if (!isOpen) {
                              showToastMsg(msg: "偏光未开启!");
                              return;
                            }
                            SpUtils.setInt('InfraredPage', strengthDAC);
                            showToastMsg(msg: "保存成功");
                            eventBus.fire(const MethodCall("sendPg"));
                          },
                          child: Text(
                            '保存',
                            style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontSize: 18.sp),
                          ))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
