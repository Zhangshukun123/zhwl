import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/entity/port_data.dart';

import '../Controller/serial_port.dart';
import '../Controller/treatment_controller.dart';

class SpasticField {
  static String SpasticKey = "SpasticKey"; // 存储 -key
  static String userId = "userId";
  static String time = "time"; //时间
  static String circle = "circle"; //周期
  static String widthA = "widthA"; //脉宽 A
  static String widthB = "widthB"; // 脉宽 B
  static String delayTime = "delayTime"; //延时时间
  static String powerA = "powerA"; //强度 A
  static String powerB = "powerB"; // 强度 B
}

class Spastic {
  int? userId;
  String? time;
  String? circle;
  String? widthA;
  String? widthB;
  String? delayTime;
  String? powerA;
  String? powerB;

  Spastic({
    this.userId,
    this.time,
    this.circle,
    this.widthA,
    this.widthB,
    this.delayTime,
    this.powerA,
    this.powerB,
  });

  void init() {
    time = "1";
    circle = "1";
    widthA = "0.1";
    widthB = "0.1";
    delayTime = "1";
    powerA = "1";
    powerB = "1";
  }

  factory Spastic.fromJson(String str) => Spastic.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Spastic.fromMap(Map<String, dynamic> json) => Spastic(
        userId: json[SpasticField.userId],
        time: json[SpasticField.time],
        circle: json[SpasticField.circle],
        widthA: json[SpasticField.widthA],
        widthB: json[SpasticField.widthB],
        delayTime: json[SpasticField.delayTime],
        powerA: json[SpasticField.powerA],
        powerB: json[SpasticField.powerB],
      );

  Map<String, dynamic> toMap() => {
        SpasticField.userId: userId,
        SpasticField.time: time,
        SpasticField.circle: circle,
        SpasticField.widthA: widthA,
        SpasticField.widthB: widthB,
        SpasticField.delayTime: delayTime,
        SpasticField.powerA: powerA,
        SpasticField.powerB: powerB,
      };

  bool start(bool isStart) {
    final TreatmentController controller = Get.find();
    if (controller.user.value.userId == 0) {
      Fluttertoast.showToast(
          msg: '请选择用户', fontSize: 22, backgroundColor: Colors.blue);
      return false;
    }

    // AB BA 01 03(04) 03(04) 01 01 12 36 60 XX XX XX CRCH CRCL
    String data = BYTE00_RW.B01;

    data = "$data ${BYTE01_MD.B05}"; // byt01 功能模块    01
    data = "$data 0x0A"; //BYte02 通道 02 //09。15修改  痉挛肌也有通道

    if (isStart) {
      // byte03 通道启停 03
      data = "$data ${BYTE03_STOP.B01}";
    } else {
      data = "$data ${BYTE03_STOP.B02}";
    }

    //04 脉冲周期 04
    if (TextUtil.isEmpty(circle)) {
      circle = '1';
    }
    // data = "$data $circle";
    // data = "$data ${((double.tryParse(circle!))! * 10).toInt()}";
    //数据进制转换
    var circleValue = double.tryParse(circle!)! * 10;
    var circleTmps = circleValue.toInt().toRadixString(16);
    if (circleTmps.length > 1) {
      data = "$data $circleTmps";
    }
    else{
      data = "$data 0$circleTmps";
    }

    if (TextUtil.isEmpty(delayTime)) {
      delayTime = '0.1';
    }
    // data = "$data $delayTime"; //byte05 延时时间 05
    // data =
    //     "$data ${((double.tryParse((double.tryParse(delayTime!)!.toStringAsFixed(2))))! * 10).toInt()}";
    //数据进制转换
    var delayValue = double.tryParse((double.tryParse(delayTime!)!.toStringAsFixed(2)))! * 10;
    var delayTmps = delayValue.toInt().toRadixString(16);
    if (delayTmps.length > 1) {
      data = "$data $delayTmps";
    }
    else{
      data = "$data 0$delayTmps";
    }




    if (TextUtil.isEmpty(widthA)) {
      widthA = '0.1';
    }
    // data = "$data $widthA"; // byte06 脉宽A 06
    // data = "$data ${((double.tryParse(widthA!))! * 10).toInt()}";
    //数据进制转换
    var widthAValue = double.tryParse(widthA!)! * 10;
    var widthATmps = widthAValue.toInt().toRadixString(16);
    if (widthATmps.length > 1) {
      data = "$data $widthATmps";
    }
    else{
      data = "$data 0$widthATmps";
    }



    if (TextUtil.isEmpty(widthB)) {
      widthB = '0.1';
    }
    // data = "$data $widthB"; // byte07 脉宽B 07
    // data = "$data ${((double.tryParse(widthB!))! * 10).toInt()}";
//数据进制转换
    var widthBValue = double.tryParse(widthB!)! * 10;
    var widthBTmps = widthBValue.toInt().toRadixString(16);
    if (widthBTmps.length > 1) {
      data = "$data $widthBTmps";
    }
    else{
      data = "$data 0$widthBTmps";
    }

    if (TextUtil.isEmpty(powerA)) {
      powerA = '0';
    }
    // data = "$data $powerA"; // byte08 强度A 08
    // data = "$data ${(double.tryParse(powerA!))?.toInt()}";
    var powerAValue = double.tryParse(powerA!)!;
    var powerATmps = powerAValue.toInt().toRadixString(16);
    if (powerATmps.length > 1) {
      data = "$data $powerATmps";
    }
    else{
      data = "$data 0$powerATmps";
    }


    if (TextUtil.isEmpty(powerB)) {
      powerB = '0';
    }
    // data = "$data $powerB"; // byte09 强度B 09
    // data = "$data ${(double.tryParse(powerB!))?.toInt()}";
    var powerBValue = double.tryParse(powerB!)!;
    var powerBTmps = powerBValue.toInt().toRadixString(16);
    if (powerBTmps.length > 1) {
      data = "$data $powerBTmps";
    }
    else{
      data = "$data 0$powerBTmps";
    }

    if (TextUtil.isEmpty(time)) {
      time = '0';
    }
    // data = "$data $time"; // byte10 工作时间 10
    // data = "$data ${(double.tryParse(time!))?.toInt()}";
    var timeValue = double.tryParse(time!)!;
    var timeTmps = timeValue.toInt().toRadixString(16);
    if (timeTmps.length > 1) {
      data = "$data $timeTmps";
    }
    else{
      data = "$data 0$timeTmps";
    }

    SerialPort().send(data);
    return isStart;
  }
}
