import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zhwlzlxt_project/widget/container_bg.dart';

import '../entity/jingPi_entity.dart';
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

  StreamController<String> cTimeA = StreamController<String>();
  StreamController<String> cPowerA = StreamController<String>();
  StreamController<String> cFrequencyA = StreamController<String>();
  StreamController<String> cPulseA = StreamController<String>();
  StreamController<String> cTimeB = StreamController<String>();
  StreamController<String> cPowerB = StreamController<String>();
  StreamController<String> cFrequencyB = StreamController<String>();
  StreamController<String> cPulseB = StreamController<String>();

  @override
  void initState() {
    super.initState();

    //数据的更改与保存，是否是新建或者从已知json中读取
    if (TextUtil.isEmpty(SpUtils.getString(PercutaneousField.PercutaneousKey))) {
      percutaneous = Percutaneous();
    } else {
      percutaneous =
          Percutaneous.fromJson(SpUtils.getString(PercutaneousField.PercutaneousKey)!);
    }

    // percutaneous = Percutaneous();

    // 一定时间内 返回一个数据
    cTimeA.stream.debounceTime(const Duration(seconds: 1)).listen((timeA) {
      percutaneous?.timeA = timeA;
      save();
    });
    cPowerA.stream.debounceTime(const Duration(seconds: 1)).listen((powerA) {
      percutaneous?.powerA = powerA;
      save();
    });
    cFrequencyA.stream.debounceTime(const Duration(seconds: 1)).listen((frequencyA) {
      percutaneous?.frequencyA = frequencyA;
      save();
    });
    cPulseA.stream.debounceTime(const Duration(seconds: 1)).listen((pulseA) {
      percutaneous?.pulseA = pulseA;
      save();
    });
    cTimeB.stream.debounceTime(const Duration(seconds: 1)).listen((timeB) {
      percutaneous?.timeB = timeB;
      save();
    });
    cPowerB.stream.debounceTime(const Duration(seconds: 1)).listen((powerB) {
      percutaneous?.powerB = powerB;
      save();
    });
    cFrequencyB.stream.debounceTime(const Duration(seconds: 1)).listen((frequencyB) {
      percutaneous?.frequencyB = frequencyB;
      save();
    });
    cPulseB.stream.debounceTime(const Duration(seconds: 1)).listen((pulseB) {
      percutaneous?.pulseB = pulseB;
      save();
    });

    eventBus.on<UserEvent>().listen((event) {
      if (event.type == TreatmentType.percutaneous) {
        percutaneous?.userId = event.user?.userId;
        save();
      }
    });
  }

  void save() {
    SpUtils.set(PercutaneousField.PercutaneousKey, percutaneous?.toJson());
  }
  @override
  void dispose() {
    super.dispose();
    cTimeA.close();
    cPowerA.close();
    cFrequencyA.close();
    cPulseA.close();
    cTimeB.close();
    cPowerB.close();
    cFrequencyB.close();
    cPulseB.close();
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
                                      onPressed: (){
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset('assets/images/2.0x/icon_moshi.png',fit: BoxFit.fitWidth,width: 15.w),
                                          SizedBox(width: 4.w,),
                                          Text('模式',style: TextStyle(fontSize: 16.sp,color: const Color(0xFF999999)),),
                                        ],
                                      )
                                  ),
                                ),
                                PopupMenuBtn(
                                  index: 3,
                                  patternStr: percutaneous?.patternA ?? "连续输出",
                                  popupListener: (value) {

                                    percutaneous?.patternA = value;
                                    save();
                                  },
                                ),
                              ],
                            )
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 11.h),
                          child: SetValueHorizontal(
                            height: 70.h,
                            enabled: true,
                            title: '时间',
                            assets: 'assets/images/2.0x/icon_shijian.png',
                            initialValue: double.tryParse(percutaneous?.timeA ?? '1'),
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
                            height: 70.h,
                            enabled: true,
                            title: '强度',
                            assets: 'assets/images/2.0x/icon_qiangdu.png',
                            initialValue: double.tryParse(percutaneous?.powerA ?? '1'),
                            maxValue: 99,
                            minValue: 1,
                            valueListener: (value) {
                              print("------强度 A-----$value");
                               cPowerA.add(value.toString());
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 11.h),
                          child: SetValueHorizontal(
                            height: 70.h,
                            enabled: true,
                            title: '频率',
                            assets: 'assets/images/2.0x/icon_pinlv.png',
                            initialValue: double.tryParse(percutaneous?.frequencyA ?? '2'),
                            minValue: 2,
                            maxValue: 160,
                            unit: 'Hz',
                            valueListener: (value) {
                              print("------频率 A-----$value");
                              cFrequencyA.add(value.toString());
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 11.h),
                          child: SetValueHorizontal(
                            height: 70.h,
                            enabled: true,
                            title: '脉宽',
                            assets: 'assets/images/2.0x/icon_maikuan.png',
                            initialValue: double.tryParse(percutaneous?.pulseA ?? '60'),
                            minValue: 60,
                            maxValue: 520,
                            appreciation: 10,
                            unit: 'μs',
                            valueListener: (value) {
                              print("------脉宽 A-----$value");
                              cPulseA.add(value.toString());
                            },
                          ),
                        ),
                        Container(
                          child: Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )
                            ),
                            child: TextButton(
                                onPressed: (){
                                  yiStartSelected = percutaneous
                                      ?.start1(!yiStartSelected) ??
                                      false;
                                  setState(() {});

                                },
                                child:
                                Image.asset(yiStartSelected ? 'assets/images/2.0x/btn_kaishi_nor.png' : 'assets/images/2.0x/btn_tingzhi_nor.png',fit: BoxFit.cover,width: 120.w,height: 45.h,)
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),
            ),
            Container(
              width: 1,
              height: 487.h,
              margin: EdgeInsets.only(top: 11.h),
              color: const Color(0xFFD6D6D6),
                child: Text('',style: TextStyle(fontSize: 18.sp,color: Colors.black),)
            ),
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
                              )
                          ),
                          width: 340.w,
                          height: 70.h,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
                                child: TextButton(
                                    onPressed: (){
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset('assets/images/2.0x/icon_moshi.png',fit: BoxFit.fitWidth,width: 15.w,),
                                        SizedBox(width: 4.w,),
                                        Text('模式',style: TextStyle(fontSize: 16.sp,color: const Color(0xFF999999)),),
                                      ],
                                    )
                                ),
                              ),
                              PopupMenuBtn(
                                index: 3,
                                patternStr: percutaneous?.patternB ?? "连续输出",
                                popupListener: (value) {
                                  percutaneous?.patternB = value;
                                  save();
                                },
                              ),

                            ],
                          )
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 70.h,
                          enabled: true,
                          title: '时间',
                          assets: 'assets/images/2.0x/icon_shijian.png',
                          initialValue: double.tryParse(percutaneous?.timeB ?? '1'),
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
                          height: 70.h,
                          enabled: true,
                          title: '强度',
                          assets: 'assets/images/2.0x/icon_qiangdu.png',
                          initialValue: double.tryParse(percutaneous?.powerB ?? '1'),
                          maxValue: 99,
                          minValue: 1,
                          valueListener: (value) {
                            print("------强度 B-----$value");
                             cPowerB.add(value.toString());
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 70.h,
                          enabled: true,
                          title: '频率',
                          assets: 'assets/images/2.0x/icon_pinlv.png',
                          initialValue: double.tryParse(percutaneous?.frequencyB ?? '2'),
                          minValue: 2,
                          maxValue: 160,
                          unit: 'Hz',
                          valueListener: (value) {
                            print("------频率B-----$value");
                            cFrequencyB.add(value.toString());
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 70.h,
                          enabled: true,
                          title: '脉宽',
                          assets: 'assets/images/2.0x/icon_maikuan.png',
                          initialValue: double.tryParse(percutaneous?.pulseB ?? '60'),
                          minValue: 60,
                          maxValue: 520,
                          appreciation: 10,
                          unit: 'μs',
                          valueListener: (value) {
                            print("------脉宽 B-----$value");
                            cPulseB.add(value.toString());
                          },
                        ),
                      ),
                      Container(
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              )
                          ),
                          child: TextButton(
                              onPressed: (){
                                erStartSelected = percutaneous
                                    ?.start2(!erStartSelected) ??
                                    false;
                                setState(() {});

                              },
                              child: Image.asset(erStartSelected ? 'assets/images/2.0x/btn_kaishi_nor.png' : 'assets/images/2.0x/btn_tingzhi_nor.png',fit: BoxFit.cover,width: 120.w,height: 43.h,)
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
