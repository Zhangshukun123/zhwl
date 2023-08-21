import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zhwlzlxt_project/entity/zhongPin_entity.dart';

import '../utils/event_bus.dart';
import '../utils/sp_utils.dart';
import '../utils/treatment_type.dart';
import '../widget/popup_menu_btn.dart';
import '../widget/set_value_horizontal.dart';
import 'control_page.dart';

class ZhongPinPage extends StatefulWidget {
  const ZhongPinPage({Key? key}) : super(key: key);

  @override
  State<ZhongPinPage> createState() => _ZhongPinPageState();
}

class _ZhongPinPageState extends State<ZhongPinPage> with AutomaticKeepAliveClientMixin {
  bool yiStartSelected = true;
  bool erStartSelected = true;

  MidFrequency? midFrequency;

  StreamController<String> cTimeA = StreamController<String>();
  StreamController<String> cPowerA = StreamController<String>();
  StreamController<String> cTimeB = StreamController<String>();
  StreamController<String> cPowerB = StreamController<String>();
  @override
  void initState() {
    super.initState();

    midFrequency = MidFrequency();

    // 一定时间内 返回一个数据
    cTimeA.stream.debounceTime(const Duration(seconds: 1)).listen((timeA) {
      midFrequency?.timeA = timeA;
      save();
    });
    cPowerA.stream.debounceTime(const Duration(seconds: 1)).listen((powerA) {
      midFrequency?.powerA = powerA;
      save();
    });


    cTimeB.stream.debounceTime(const Duration(seconds: 1)).listen((timeB) {
      midFrequency?.timeB = timeB;
      save();
    });
    cPowerB.stream.debounceTime(const Duration(seconds: 1)).listen((powerB) {
      midFrequency?.powerB = powerB;
      save();
    });



    eventBus.on<UserEvent>().listen((event) {
      if (event.type == TreatmentType.frequency) {
        midFrequency?.userId = event.user?.userId;
        save();
      }
    });
  }

  void save() {
    SpUtils.set(MidFrequencyField.MidFrequencyKey, midFrequency?.toJson());
  }
  @override
  void dispose() {
    super.dispose();
    cTimeA.close();
    cPowerA.close();
    cTimeB.close();
    cPowerB.close();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: const Color(0xFFF0FAFE),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  // color: Colors.white,
                  // decoration: const BoxDecoration(
                  //   image: DecorationImage(
                  //       image: AssetImage('assets/images/2.0x/img_tongdaoyi.png'),
                  //     fit: BoxFit.contain,
                  //   ),
                  // ),
                  margin: EdgeInsets.only(top: 11.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                              )),
                          width: 340.w,
                          height: 120.h,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
                                child: TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/2.0x/icon_chufang.png',
                                          fit: BoxFit.fitWidth,
                                          width: 15.w,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Text(
                                          '处方',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0xFF999999)),
                                        ),
                                      ],
                                    )),
                              ),
                              PopupMenuBtn(
                                index: 7,
                                patternStr: "1",
                                popupListener: (value) {
                                  midFrequency?.patternA = value;
                                  save();
                                },
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 120.h,
                          enabled: true,
                          title: '时间',
                          assets: 'assets/images/2.0x/icon_shijian.png',
                          initialValue: 1,
                          minValue: 1,
                          maxValue: 30,
                          unit: 'min',
                          valueListener: (value) {
                            print("------时间A-----$value");
                            cTimeA.add(value.toString());
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 120.h,
                          enabled: true,
                          title: '强度',
                          assets: 'assets/images/2.0x/icon_qiangdu.png',
                          initialValue: 1,
                          maxValue: 99,
                          minValue: 1,
                          valueListener: (value) {
                            print("------强度 A-----$value");
                            cPowerA.add(value.toString());
                          },
                        ),
                      ),
                      Container(
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                          child: TextButton(
                              onPressed: () {
                                yiStartSelected = !yiStartSelected;
                                setState(() {});
                              },
                              child: Image.asset(
                                yiStartSelected
                                    ? 'assets/images/2.0x/btn_kaishi_nor.png'
                                    : 'assets/images/2.0x/btn_tingzhi_nor.png',
                                fit: BoxFit.cover,
                                width: 120.w,
                                height: 45.h,
                              )),
                        ),
                      ),
                    ],
                  )),
            ),
            Container(
                width: 1,
                height: 487.h,
                margin: EdgeInsets.only(top: 11.h),
                color: const Color(0xFFD6D6D6),
                child: Text(
                  '',
                  style: TextStyle(fontSize: 18.sp, color: Colors.black),
                )),
            Expanded(
              flex: 1,
              child: Container(
                  // color: Colors.white,
                  // decoration: const BoxDecoration(
                  //   image: DecorationImage(
                  //       image: AssetImage('assets/images/2.0x/img_tongdaoyi.png'),
                  //     fit: BoxFit.contain,
                  //   ),
                  // ),
                  margin: EdgeInsets.only(top: 11.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                              )),
                          width: 340.w,
                          height: 120.h,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
                                child: TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/2.0x/icon_chufang.png',
                                          fit: BoxFit.fitWidth,
                                          width: 15.w,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Text(
                                          '处方',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0xFF999999)),
                                        ),
                                      ],
                                    )),
                              ),
                              PopupMenuBtn(
                                index: 7,
                                patternStr: "1",
                                popupListener: (value) {
                                  midFrequency?.patternB = value;
                                  save();
                                },
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 120.h,
                          enabled: true,
                          title: '时间',
                          assets: 'assets/images/2.0x/icon_shijian.png',
                          initialValue: 1,
                          maxValue: 30,
                          minValue: 1,
                          unit: 'min',
                          valueListener: (value) {
                            print("------时间B-----$value");
                            cTimeB.add(value.toString());
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 120.h,
                          enabled: true,
                          title: '强度',
                          assets: 'assets/images/2.0x/icon_qiangdu.png',
                          initialValue: 1,
                          maxValue: 99,
                          minValue: 1,
                          valueListener: (value) {
                            print("------强度 B-----$value");
                            cPowerB.add(value.toString());
                          },
                        ),
                      ),
                      Container(
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                          child: TextButton(
                              onPressed: () {
                                erStartSelected = !erStartSelected;
                                setState(() {});
                              },
                              child: Image.asset(
                                erStartSelected
                                    ? 'assets/images/2.0x/btn_kaishi_nor.png'
                                    : 'assets/images/2.0x/btn_tingzhi_nor.png',
                                fit: BoxFit.cover,
                                width: 120.w,
                                height: 45.h,
                              )),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
