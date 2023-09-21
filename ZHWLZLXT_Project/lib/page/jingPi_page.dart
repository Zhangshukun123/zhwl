import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zhwlzlxt_project/base/globalization.dart';
import 'package:zhwlzlxt_project/widget/container_bg.dart';

import '../entity/jingPi_entity.dart';
import '../entity/set_value_state.dart';
import '../utils/event_bus.dart';
import '../utils/sp_utils.dart';
import '../utils/treatment_type.dart';
import '../widget/popup_menu_btn.dart';
import '../widget/set_value_horizontal.dart';
import 'control_page.dart';

class JingPiPage extends StatefulWidget {
  const JingPiPage({Key? key}) : super(key: key);

  @override
  State<JingPiPage> createState() => _JingPiPageState();
}

class _JingPiPageState extends State<JingPiPage>
    with AutomaticKeepAliveClientMixin {
  bool yiStartSelected = true;
  bool erStartSelected = true;

  Percutaneous? percutaneous;

  @override
  void initState() {
    super.initState();
    percutaneous = Percutaneous();
    percutaneous?.init();

    eventBus.on<UserEvent>().listen((event) {
      if (event.type == TreatmentType.percutaneous) {
        percutaneous?.userId = event.user?.userId;
        save(event.user?.userId ?? -1);
      }
    });
  }

  void save(int userId) {
    SpUtils.set(PercutaneousField.PercutaneousKey, userId);
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
                child: Container(
                    height: 487.h,
                    margin: EdgeInsets.only(top: 9.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ContainerBg(
                            width: 340.w,
                            height: 70.h,
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20.w),
                                  child: TextButton(
                                      onPressed: () {},
                                      child: Row(
                                        children: [
                                          Image.asset(
                                              'assets/images/2.0x/icon_moshi.png',
                                              fit: BoxFit.fitWidth,
                                              width: 15.w),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          Text(
                                            Globalization.mode.tr,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: const Color(0xFF999999)),
                                          ),
                                        ],
                                      )),
                                ),
                                PopupMenuBtn(
                                  index: 3,
                                  patternStr: percutaneous?.patternA ?? "连续输出",
                                  enabled: true,
                                  popupListener: (value) {
                                    percutaneous?.patternA = value;
                                  },
                                ),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(top: 11.h),
                          child: SetValueHorizontal(
                            height: 70.h,
                            type:  TreatmentType.percutaneous,
                            enabled: true,
                            title: Globalization.time.tr,
                            assets: 'assets/images/2.0x/icon_shijian.png',
                            initialValue:
                                double.tryParse(percutaneous?.timeA ?? '1'),
                            minValue: 1,
                            maxValue: 30,
                            unit: 'min',
                            valueListener: (value) {
                              percutaneous?.timeA = value.toString();
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 11.h),
                          child: SetValueHorizontal(
                            height: 70.h,
                            enabled: true,
                            type:  TreatmentType.percutaneous,
                            title: Globalization.intensity.tr,
                            assets: 'assets/images/2.0x/icon_qiangdu.png',
                            initialValue:
                                double.tryParse(percutaneous?.powerA ?? '1'),
                            maxValue: 99,
                            minValue: 0,
                            valueListener: (value) {
                              percutaneous?.powerA = value.toString();
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 11.h),
                          child: SetValueHorizontal(
                            height: 70.h,
                            enabled: true,
                            type:  TreatmentType.percutaneous,
                            title: Globalization.frequency.tr,
                            assets: 'assets/images/2.0x/icon_pinlv.png',
                            initialValue: double.tryParse(
                                percutaneous?.frequencyA ?? '2'),
                            minValue: 2,
                            maxValue: 160,
                            unit: 'Hz',
                            valueListener: (value) {
                              percutaneous?.frequencyA = value.toString();
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 11.h),
                          child: SetValueHorizontal(
                            height: 70.h,
                            enabled: true,
                            type:  TreatmentType.percutaneous,
                            title: Globalization.pulseWidth.tr,
                            assets: 'assets/images/2.0x/icon_maikuan.png',
                            initialValue:
                                double.tryParse(percutaneous?.pulseA ?? '60'),
                            minValue: 60,
                            maxValue: 520,
                            appreciation: 10,
                            unit: 'μs',
                            valueListener: (value) {
                              percutaneous?.pulseA = value.toString();
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
                                  yiStartSelected =
                                      percutaneous?.start1(!yiStartSelected) ??
                                          false;

                                  if (yiStartSelected) {
                                    percutaneous?.init();
                                    Future.delayed(const Duration(milliseconds: 500), () {
                                      eventBus.fire(SetValueState(TreatmentType.percutaneous));
                                    });
                                  }
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
                  height: 487.h,
                  // color: Colors.white,
                  // decoration: const BoxDecoration(
                  //   image: DecorationImage(
                  //       image: AssetImage('assets/images/2.0x/img_tongdaoyi.png'),
                  //     fit: BoxFit.contain,
                  //   ),
                  // ),
                  margin: EdgeInsets.only(top: 9.h),
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
                          height: 70.h,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
                                child: TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/2.0x/icon_moshi.png',
                                          fit: BoxFit.fitWidth,
                                          width: 15.w,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Text(
                                          Globalization.mode.tr,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0xFF999999)),
                                        ),
                                      ],
                                    )),
                              ),
                              PopupMenuBtn(
                                index: 3,
                                patternStr: percutaneous?.patternB ?? "连续输出",
                                enabled: true,
                                popupListener: (value) {
                                  percutaneous?.patternB = value;
                                },
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 70.h,
                          enabled: true,
                          type:  TreatmentType.percutaneous,
                          title: Globalization.time.tr,
                          assets: 'assets/images/2.0x/icon_shijian.png',
                          initialValue:
                              double.tryParse(percutaneous?.timeB ?? '1'),
                          maxValue: 30,
                          minValue: 1,
                          unit: 'min',
                          valueListener: (value) {
                            percutaneous?.timeB = value.toString();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 70.h,
                          enabled: true,
                          type:  TreatmentType.percutaneous,
                          title: Globalization.intensity.tr,
                          assets: 'assets/images/2.0x/icon_qiangdu.png',
                          initialValue:
                              double.tryParse(percutaneous?.powerB ?? '1'),
                          maxValue: 99,
                          minValue: 0,
                          valueListener: (value) {
                            percutaneous?.powerB = value.toString();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 70.h,
                          enabled: true,
                          type:  TreatmentType.percutaneous,
                          title: Globalization.frequency.tr,
                          assets: 'assets/images/2.0x/icon_pinlv.png',
                          initialValue:
                              double.tryParse(percutaneous?.frequencyB ?? '2'),
                          minValue: 2,
                          maxValue: 160,
                          unit: 'Hz',
                          valueListener: (value) {
                            percutaneous?.frequencyB = value.toString();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 70.h,
                          enabled: true,
                          type:  TreatmentType.percutaneous,
                          title: Globalization.pulseWidth.tr,
                          assets: 'assets/images/2.0x/icon_maikuan.png',
                          initialValue:
                              double.tryParse(percutaneous?.pulseB ?? '60'),
                          minValue: 60,
                          maxValue: 520,
                          appreciation: 10,
                          unit: 'μs',
                          valueListener: (value) {
                            percutaneous?.pulseB = value.toString();
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
                                erStartSelected =
                                    percutaneous?.start2(!erStartSelected) ??
                                        false;

                                if (erStartSelected) {
                                  percutaneous?.init();
                                  Future.delayed(const Duration(milliseconds: 500), () {
                                    eventBus.fire(SetValueState(TreatmentType.percutaneous));
                                  });
                                }

                                setState(() {});
                              },
                              child: Image.asset(
                                erStartSelected
                                    ? 'assets/images/2.0x/btn_kaishi_nor.png'
                                    : 'assets/images/2.0x/btn_tingzhi_nor.png',
                                fit: BoxFit.cover,
                                width: 120.w,
                                height: 43.h,
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
