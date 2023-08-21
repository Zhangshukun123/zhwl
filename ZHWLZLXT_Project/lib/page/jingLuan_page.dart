import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zhwlzlxt_project/entity/jingLuan_entity.dart';

import '../utils/event_bus.dart';
import '../utils/sp_utils.dart';
import '../utils/treatment_type.dart';
import '../widget/set_value_horizontal.dart';
import 'control_page.dart';

class JingLuanPage extends StatefulWidget {
  const JingLuanPage({Key? key}) : super(key: key);

  @override
  State<JingLuanPage> createState() => _JingLuanPageState();
}

class _JingLuanPageState extends State<JingLuanPage> with AutomaticKeepAliveClientMixin{
  bool jingStartSelected = true;

  Spastic? spastic;

  StreamController<String> cTime = StreamController<String>();
  StreamController<String> cCircle = StreamController<String>();
  StreamController<String> cWidthA = StreamController<String>();
  StreamController<String> cWidthB = StreamController<String>();
  StreamController<String> cDelayTime = StreamController<String>();
  StreamController<String> cPowerA = StreamController<String>();
  StreamController<String> cPowerB = StreamController<String>();

  @override
  void initState() {
    super.initState();

    spastic = Spastic();


    // 一定时间内 返回一个数据
    cTime.stream.debounceTime(const Duration(seconds: 1)).listen((time) {
      spastic?.time = time;
      save();
    });
    cCircle.stream.debounceTime(const Duration(seconds: 1)).listen((circle) {
      spastic?.circle = circle;
      save();
    });
    cWidthA.stream.debounceTime(const Duration(seconds: 1)).listen((widthA) {
      spastic?.widthA = widthA;
      save();
    });
    cWidthB.stream.debounceTime(const Duration(seconds: 1)).listen((widthB) {
      spastic?.widthB = widthB;
      save();
    });
    cDelayTime.stream.debounceTime(const Duration(seconds: 1)).listen((delayTime) {
      spastic?.delayTime = delayTime;
      save();
    });
    cPowerA.stream.debounceTime(const Duration(seconds: 1)).listen((powerA) {
      spastic?.powerA = powerA;
      save();
    });
    cPowerB.stream.debounceTime(const Duration(seconds: 1)).listen((powerB) {
      spastic?.powerB = powerB;
      save();
    });

    eventBus.on<UserEvent>().listen((event) {
      if (event.type == TreatmentType.spasm) {
        spastic?.userId = event.user?.userId;
        save();
      }
    });
  }

  void save() {
    SpUtils.set(SpasticField.SpasticKey, spastic?.toJson());
  }

  @override
  void dispose() {
    super.dispose();
    cTime.close();
    cWidthA.close();
    cWidthB.close();
    cDelayTime.close();
    cCircle.close();
    cPowerB.close();
    cPowerA.close();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: const Color(0xFFF0FAFE),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 35.w, right: 35.w),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SetValueHorizontal(
                    enabled: true,
                    title: '时间',
                    assets: 'assets/images/2.0x/icon_shijian.png',
                    initialValue: 1,
                    maxValue: 30,
                    minValue: 1,
                    unit: 'min',
                    valueListener: (value) {
                      print("------时间-----$value");
                      cTime.add(value.toString());
                    },
                  ),
                  SetValueHorizontal(
                    enabled: true,
                    isInt: false,
                    title: '脉宽 (A)',
                    assets: 'assets/images/2.0x/icon_maikuan.png',
                    initialValue: 0.1,
                    appreciation: 0.1,
                    minValue: 0.1,
                    maxValue: 0.5,
                    unit: 'ms',
                    valueListener: (value) {
                      print("------脉宽 A-----$value");
                      cWidthA.add(value.toString());
                    },
                  ),
                  SetValueHorizontal(
                    enabled: true,
                    isInt: false,
                    title: '脉宽 (B)',
                    assets: 'assets/images/2.0x/icon_maikuan.png',
                    initialValue: 0.1,
                    appreciation: 0.1,
                    minValue: 0.1,
                    maxValue: 0.5,
                    unit: 'ms',
                    valueListener: (value) {
                      print("------脉宽 B-----$value");
                      cWidthB.add(value.toString());
                    },
                  ),
                  SetValueHorizontal(
                    enabled: true,
                    isInt: false,
                    title: '延时时间',
                    assets: 'assets/images/2.0x/icon_yanshi.png',
                    initialValue: 0.1,
                    appreciation: 0.1,
                    maxValue: 1.5,
                    minValue: 0.1,
                    unit: 's',
                    valueListener: (value) {
                      print("------延时时间-----$value");
                      cDelayTime.add(value.toString());
                    },
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 30.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SetValueHorizontal(
                      enabled: true,
                      isInt: false,
                      title: '脉冲周期',
                      assets: 'assets/images/2.0x/icon_maichong.png',
                      initialValue: 1,
                      appreciation: 0.1,
                      minValue: 1,
                      maxValue: 2,
                      unit: 's',
                      valueListener: (value) {
                        print("------周期-----$value");
                        cCircle.add(value.toString());
                      },
                    ),
                    SetValueHorizontal(
                      enabled: true,
                      isInt: true,
                      title: '强度 (A)',
                      assets: 'assets/images/2.0x/icon_qiangdu.png',
                      initialValue: 1,
                      maxValue: 99,
                      minValue: 0,
                      valueListener: (value) {
                        print("------强度 A-----$value");
                        cPowerA.add(value.toString());
                      },
                    ),
                    SetValueHorizontal(
                      enabled: true,
                      isInt: true,
                      title: '强度 (B)',
                      assets: 'assets/images/2.0x/icon_qiangdu.png',
                      initialValue: 1,
                      maxValue: 99,
                      minValue: 0,
                      valueListener: (value) {
                        print("------强度 B-----$value");
                        cPowerB.add(value.toString());
                      },
                    ),
                    Container(
                        width: 340.w,
                        height: 100.h,
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
                        child: Container(
                          child: TextButton(
                            onPressed: () {
                              jingStartSelected = !jingStartSelected;
                              setState(() {});
                            },
                            child: Image.asset(
                              jingStartSelected
                                  ? 'assets/images/2.0x/btn_kaishi_nor.png'
                                  : 'assets/images/2.0x/btn_tingzhi_nor.png',
                              fit: BoxFit.fill,
                              width: 120.w,
                              height: 55.h,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
