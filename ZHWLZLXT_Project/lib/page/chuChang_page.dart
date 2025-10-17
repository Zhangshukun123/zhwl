import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/utils/event_bus.dart';
import 'package:zhwlzlxt_project/utils/sp_utils.dart';
import 'package:zhwlzlxt_project/utils/utils_tool.dart';

import '../Controller/serial_port.dart';
import '../base/globalization.dart';
import '../entity/set_value_entity.dart';
import '../utils/utils.dart';
import '../widget/set_value_horizontal.dart';

class ChuChangPage extends StatefulWidget {
  const ChuChangPage({Key? key}) : super(key: key);

  @override
  State<ChuChangPage> createState() => _ChuChangPageState();
}

class _ChuChangPageState extends State<ChuChangPage> {
  var power = 0.0;
  var utMxt = "1";
  var powerDAC = 0.0;
  var isOpen = false;
  var vBig = 0.0;
  List<int> bytes = [];

  @override
  void initState() {
    super.initState();

    eventBus.on<String>().listen((event) {
      if (!mounted) {
        return;
      }
      utMxt = event;
      setState(() {});
    });
    powerDAC = SpUtils.getDouble(
        "${utMxt}M${double.parse(power.toStringAsFixed(2)).toString()}",
        defaultValue: 0.0)!;
    eventBus.on<MethodCall>().listen((methodCall) {
      switch (methodCall.method) {
        case '0xB6':
          String value = methodCall.arguments;
          Uint8List list = toUnitList(value);
          vBig = readScaledUint16(list,4);
          isOpen = false;
          eventBus.fire(const MethodCall("close"));
          setState(() {});
          break;
      }
    });
  }

  double readScaledUint16(Uint8List bytes, int offsetBytes,
      {int scale = 10000, bool bigEndian = true}) {
    final bd = ByteData.sublistView(bytes, offsetBytes, offsetBytes + 2);
    final u16 = bigEndian ? bd.getUint16(0, Endian.big) : bd.getUint16(0, Endian.little);
    return u16 / scale;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text(
          Globalization.setting.tr,
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
                margin: EdgeInsets.only(left: 115.w, right: 115.w),
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
                          "频率${utMxt}M",
                          style: TextStyle(
                              color: const Color(0xFF999999), fontSize: 18.sp),
                        )),
                    Expanded(
                        child: SizedBox(
                      width: 10.w,
                    )),
                    Text("${vBig}Mhz",style: const TextStyle(fontSize: 30),),
                    const SizedBox(width: 80),
                    Container(
                      width: 110.w,
                      height: 43.h,
                      margin: EdgeInsets.only(right: 33.w),
                      decoration: BoxDecoration(
                          color: const Color(0xFF00A8E7),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.w),
                          )),
                      child: TextButton(
                          onPressed: () {
                            eventBus.fire(const MethodCall("saponin"));
                            isOpen =true;
                            setState(() {
                            });
                          },
                          child: Text(
                            '扫频',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.sp),
                          )),
                    )
                  ],
                ),
              ),
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
                            '输出功率',
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontSize: 18.sp),
                          )),
                      Expanded(
                          child: SizedBox(
                        width: 10.w,
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 15.w,
                          ),
                          SetValueHorizontal(
                            enabled: true,
                            assets: 'assets/images/2.0x/icon_gonglv.png',
                            initialValue: 0,
                            width: 250.w,
                            appreciation: 0.6,
                            unit: 'W',
                            maxValue: utMxt == "1" ? 7.2 : 3,
                            isInt: false,
                            valueListener: (value) {
                              power = value;
                              var set = SetValueEntity();
                              set.value = SpUtils.getDouble(
                                  "${utMxt}M${double.parse(power.toStringAsFixed(2)).toString()}");
                              set.type = 15;
                              eventBus.fire(set);
                              setState(() {});
                              // cPower.add(value.toString());
                            },
                          ),
                        ],
                      ),
                    ],
                  )),
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
                            'DAC',
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
                        initialValue: SpUtils.getDouble(
                            "${utMxt}M${double.parse(power.toStringAsFixed(2)).toString()}"),
                        width: 250.w,
                        appreciation: 0.1,
                        indexType: 15,
                        unit: 'W',
                        isInt: false,
                        valueListener: (value) {
                          powerDAC = value;
                          var powerTmps =
                              (powerDAC * 10).toInt().toRadixString(16);
                          var data = "";
                          if (powerTmps.length > 1) {
                            data = powerTmps;
                          } else {
                            data = "0$powerTmps";
                          }
                          String dac="";
                          if(utMxt=="1"){
                             dac = "01 03 10 01 01 14 $data 00 00 00 00";
                          }else{
                             dac = "01 04 10 01 01 14 $data 00 00 00 00";
                          }
                          SerialPort().send(dac, false);
                          // eventBus.fire(const MethodCall("saveP"));
                          isOpen = true;
                          setState(() {});
                          // SpUtils.setDouble(power.toString(), value);
                          // cPower.add(value.toString());
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
                            eventBus.fire(const MethodCall("close"));
                          } else {
                            eventBus.fire(const MethodCall("open"));
                          }
                          isOpen = !isOpen;
                          setState(() {});
                        },
                        child: Text(
                          isOpen ? "关闭超声" : "开启超声",
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
                            String formattedNum = powerDAC.toStringAsFixed(2);
                            String powerKey =
                                double.parse(power.toStringAsFixed(2))
                                    .toString();

                            SpUtils.setDouble("${utMxt}M$powerKey",
                                double.parse(formattedNum));

                            showToastMsg(msg: "保存成功");
                            setState(() {});
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
