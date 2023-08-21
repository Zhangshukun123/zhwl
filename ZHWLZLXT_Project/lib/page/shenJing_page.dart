import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zhwlzlxt_project/entity/shenJing_entity.dart';

import '../utils/event_bus.dart';
import '../utils/sp_utils.dart';
import '../utils/treatment_type.dart';
import '../widget/popup_menu_btn.dart';
import '../widget/set_value_horizontal.dart';
import 'control_page.dart';

class ShenJingPage extends StatefulWidget {
  const ShenJingPage({Key? key}) : super(key: key);

  @override
  State<ShenJingPage> createState() => _ShenJingPageState();
}

class _ShenJingPageState extends State<ShenJingPage> with AutomaticKeepAliveClientMixin {
  bool yiStartSelected = true;
  bool erStartSelected = true;

  Neuromuscular? neuromuscular;

  StreamController<String> cTimeA = StreamController<String>();
  StreamController<String> cPowerA = StreamController<String>();
  StreamController<String> cFrequencyA = StreamController<String>();
  StreamController<String> cTimeB = StreamController<String>();
  StreamController<String> cPowerB = StreamController<String>();
  StreamController<String> cFrequencyB = StreamController<String>();
  @override
  void initState() {
    super.initState();

    neuromuscular = Neuromuscular();

    // 一定时间内 返回一个数据
    cTimeA.stream.debounceTime(const Duration(seconds: 1)).listen((timeA) {
      neuromuscular?.timeA = timeA;
      save();
    });
    cPowerA.stream.debounceTime(const Duration(seconds: 1)).listen((powerA) {
      neuromuscular?.powerA = powerA;
      save();
    });
    cFrequencyA.stream.debounceTime(const Duration(seconds: 1)).listen((frequencyA) {
      neuromuscular?.frequencyA = frequencyA;
      save();
    });

    cTimeB.stream.debounceTime(const Duration(seconds: 1)).listen((timeB) {
      neuromuscular?.timeB = timeB;
      save();
    });
    cPowerB.stream.debounceTime(const Duration(seconds: 1)).listen((powerB) {
      neuromuscular?.powerB = powerB;
      save();
    });
    cFrequencyB.stream.debounceTime(const Duration(seconds: 1)).listen((frequencyB) {
      neuromuscular?.frequencyB = frequencyB;
      save();
    });


    eventBus.on<UserEvent>().listen((event) {
      if (event.type == TreatmentType.neuromuscular) {
        neuromuscular?.userId = event.user?.userId;
        save();
      }
    });
  }

  void save() {
    SpUtils.set(NeuromuscularField.NeuromuscularKey, neuromuscular?.toJson());
  }
  @override
  void dispose() {
    super.dispose();
    cTimeA.close();
    cPowerA.close();
    cFrequencyA.close();
    cTimeB.close();
    cPowerB.close();
    cFrequencyB.close();
  }

  @override
  Widget build(BuildContext context) {

    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: Color(0xFFF0FAFE),
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
                          height: 90.h,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
                                child: TextButton(
                                    onPressed: (){
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset('assets/images/2.0x/icon_moshi.png',fit: BoxFit.fitWidth,width: 16.w,height: 16.h,),
                                        SizedBox(width: 4.w,),
                                        Text('模式',style: TextStyle(fontSize: 16.sp,color: const Color(0xFF999999)),),
                                      ],
                                    )
                                ),
                              ),
                              PopupMenuBtn(
                                index: 5,
                                patternStr: "完全失神经",
                                popupListener: (value) {
                                  neuromuscular?.patternA = value;
                                  save();
                                },
                              ),

                            ],
                          )
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 90.h,
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
                          height: 90.h,
                          enabled: true,
                          isInt: true,
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
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 90.h,
                          enabled: true,
                          isInt: false,
                          title: '频率',
                          unit: 'Hz',
                          assets: 'assets/images/2.0x/icon_pinlv.png',
                          initialValue: 0.5,
                          minValue: 0.5,
                          maxValue: 5,
                          appreciation: 0.5,
                          valueListener: (value) {
                            print("------频率 A-----$value");
                            cFrequencyA.add(value.toString());
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
                                yiStartSelected = !yiStartSelected;
                                setState(() {

                                });

                              },
                              child: Image.asset(yiStartSelected ? 'assets/images/2.0x/btn_kaishi_nor.png' : 'assets/images/2.0x/btn_tingzhi_nor.png',fit: BoxFit.cover,width: 120.w,height: 45.h,)
                          ),
                        ),
                      ),
                    ],
                  )
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
                          height: 90.h,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20.w),
                                child: TextButton(
                                    onPressed: (){
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset('assets/images/2.0x/icon_moshi.png',fit: BoxFit.fitWidth,width: 16.w,height: 16.h,),
                                        SizedBox(width: 4.w,),
                                        Text('模式',style: TextStyle(fontSize: 16.sp,color: const Color(0xFF999999)),),
                                      ],
                                    )
                                ),
                              ),
                              PopupMenuBtn(
                                index: 5,
                                patternStr: "完全失神经",
                                popupListener: (value) {
                                  neuromuscular?.patternB = value;
                                  save();
                                },
                              ),
                            ],
                          )
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 90.h,
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
                          height: 90.h,
                          enabled: true,
                          isInt: true,
                          title: '强度',
                          assets: 'assets/images/2.0x/icon_qiangdu.png',
                          initialValue: 1,
                          minValue: 1,
                          maxValue: 99,
                          valueListener: (value) {
                            print("------强度 B-----$value");
                            cPowerB.add(value.toString());
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 11.h),
                        child: SetValueHorizontal(
                          height: 90.h,
                          enabled: true,
                          isInt: true,
                          title: '频率',
                          unit: 'Hz',
                          assets: 'assets/images/2.0x/icon_pinlv.png',
                          initialValue: 0.5,
                          minValue: 0.5,
                          maxValue: 5,
                          appreciation: 0.5,
                          valueListener: (value) {
                            print("------频率B-----$value");
                            cFrequencyB.add(value.toString());
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
                                erStartSelected = !erStartSelected;
                                setState(() {

                                });
                              },
                              child: Image.asset(erStartSelected ? 'assets/images/2.0x/btn_kaishi_nor.png' : 'assets/images/2.0x/btn_tingzhi_nor.png',fit: BoxFit.cover,width: 120.w,height: 45.h,)
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
