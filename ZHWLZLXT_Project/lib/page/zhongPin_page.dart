import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zhwlzlxt_project/base/globalization.dart';
import 'package:zhwlzlxt_project/entity/zhongPin_entity.dart';

import '../entity/set_value_state.dart';
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

class _ZhongPinPageState extends State<ZhongPinPage>
    with AutomaticKeepAliveClientMixin {
  bool yiStartSelected = true;
  bool erStartSelected = true;

  MidFrequency? midFrequency;

  @override
  void initState() {
    super.initState();
    midFrequency = MidFrequency();
    midFrequency?.init();

    eventBus.on<UserEvent>().listen((event) {
      if (event.type == TreatmentType.frequency) {
        midFrequency?.userId = event.user?.userId;
        save(event.user?.userId ?? -1);
      }
    });
  }

  void save(int userId) {
    SpUtils.set(MidFrequencyField.MidFrequencyKey, userId);
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
                                          Globalization.recipe.tr,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0xFF999999)),
                                        ),
                                      ],
                                    )),
                              ),
                              PopupMenuBtn(
                                index: 7,
                                patternStr: midFrequency?.patternA ?? "1",
                                popupListener: (value) {
                                  midFrequency?.patternA = value;
                                },
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 120.h,
                          enabled: true,
                          type: TreatmentType.frequency,
                          title: Globalization.time.tr,
                          assets: 'assets/images/2.0x/icon_shijian.png',
                          initialValue:
                              double.tryParse(midFrequency?.timeA ?? '1'),
                          minValue: 1,
                          maxValue: 30,
                          unit: 'min',
                          valueListener: (value) {
                            midFrequency?.timeA = value.toString();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 120.h,
                          enabled: yiStartSelected ? false : true,
                          type: TreatmentType.frequency,
                          title: Globalization.intensity.tr,
                          assets: 'assets/images/2.0x/icon_qiangdu.png',
                          initialValue:
                              double.tryParse(midFrequency?.powerA ?? '0'),
                          maxValue: 99,
                          minValue: 1,
                          valueListener: (value) {
                            midFrequency?.powerA = value.toString();
                          },
                          onClick: (){
                            midFrequency?.start1(true);
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
                                    midFrequency?.start1(!yiStartSelected) ??
                                        false;
                                if (yiStartSelected) {
                                  midFrequency?.init();
                                  Future.delayed(const Duration(milliseconds: 500), () {
                                    eventBus.fire(SetValueState(TreatmentType.frequency));
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
                                          Globalization.recipe.tr,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0xFF999999)),
                                        ),
                                      ],
                                    )),
                              ),
                              PopupMenuBtn(
                                index: 7,
                                patternStr: midFrequency?.patternB ?? "1",
                                popupListener: (value) {
                                  midFrequency?.patternB = value;
                                },
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 120.h,
                          enabled: true,
                          type: TreatmentType.frequency,
                          title: Globalization.time.tr,
                          assets: 'assets/images/2.0x/icon_shijian.png',
                          initialValue:
                              double.tryParse(midFrequency?.timeB ?? '1'),
                          maxValue: 30,
                          minValue: 1,
                          unit: 'min',
                          valueListener: (value) {
                            midFrequency?.timeB = value.toString();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 120.h,
                          enabled: erStartSelected ? false : true,
                          type: TreatmentType.frequency,
                          title: Globalization.intensity.tr,
                          assets: 'assets/images/2.0x/icon_qiangdu.png',
                          initialValue:
                              double.tryParse(midFrequency?.powerB ?? '0'),
                          maxValue: 99,
                          minValue: 1,
                          valueListener: (value) {
                            midFrequency?.powerB = value.toString();
                          },
                          onClick: () {
                            midFrequency?.start2(true);
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
                                    midFrequency?.start2(!erStartSelected) ??
                                        false;
                                if (erStartSelected) {
                                  midFrequency?.init();
                                  Future.delayed(const Duration(milliseconds: 500), () {
                                    eventBus.fire(SetValueState(TreatmentType.frequency));
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
