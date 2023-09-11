import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/entity/port_data.dart';

import '../Controller/serial_port.dart';
import '../Controller/treatment_controller.dart';

class PulsedField {
  static String PulsedKey = "PulsedKey"; // 存储 -key
  static String userId = "userId";
  static String power = "power"; //强度
  static String frequency = "frequency"; //频率
  static String time = "time"; //时间
}

class Pulsed {
  int? userId;
  String? time;
  String? power;
  String? frequency;

  Pulsed({
    this.userId,
    this.time,
    this.power,
    this.frequency,
  });

  factory Pulsed.fromJson(String str) => Pulsed.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pulsed.fromMap(Map<String, dynamic> json) => Pulsed(
        userId: json[PulsedField.userId],
        time: json[PulsedField.time],
        power: json[PulsedField.power],
        frequency: json[PulsedField.frequency],
      );

  Map<String, dynamic> toMap() => {
        PulsedField.userId: userId,
        PulsedField.time: time,
        PulsedField.power: power,
        PulsedField.frequency: frequency,
      };

  bool start(bool isStart, bool isOpen) {

    final TreatmentController controller = Get.find();
    print('--------------${controller.user.value.userId}');
    if (controller.user.value.userId == 0) {
      Fluttertoast.showToast(msg: '请选择用户',fontSize: 22,backgroundColor: Colors.blue);
      return false;
    }
    // AB BA 01 03(04) 03(04) 01 01 12 36 60 XX XX XX CRCH CRCL
    String data = BYTE00_RW.B01; // 00
    data = "$data ${BYTE01_MD.B02}"; // byt01 功能模块    01
    data = "$data 00"; //02


    //此处解决磁疗的开始和停止按钮命令反的问题 09。06李建成提出
    if (isStart) {
      // 03
      data = "$data ${BYTE03_STOP.B02}";
    } else {
      data = "$data ${BYTE03_STOP.B01}";
    }
    //04
    if (TextUtil.isEmpty(frequency)) {
      frequency = '20';
    }
    //频率发送的数据  需要将10进制的数据转换成16进制数据
    var value = double.tryParse(frequency!);
    //转成16进制数据
    var tmpS = value?.toInt().toRadixString(16);
    if (tmpS!.length > 1){
      data = "$data $tmpS"; // 04
    }
    else{
      data = "$data 0$tmpS"; // 04
    }

    // // data = "$data $frequency";
    // data = "$data ${(double.tryParse(frequency!))?.toInt()}";

    if (TextUtil.isEmpty(time)) {
      time = '1';
    }
    // data = "$data $time"; // 05
    // data = "$data ${(double.tryParse(time!))?.toInt()}";
    //转成double类型数据
    var timeValue = double.tryParse(time!);
    //转成16进制数据
    var timeTmps = timeValue?.toInt().toRadixString(16);
    //以16进制数据发送
    if (timeTmps!.length > 1) {
      data = "$data $timeTmps";
    }
    else{
      data = "$data 0$timeTmps";
    }

    if (TextUtil.isEmpty(power)) {
      power = '0';
    }
    // data = "$data $power"; // 06
    // data = "$data ${(double.tryParse(power!))?.toInt()}";
    //转成double类型数据
    var powerValue = double.tryParse(power!);
    //转成16进制数据
    var powerTmps = powerValue?.toInt().toRadixString(16);
    //以16进制数据发送
    if (powerTmps!.length > 1) {
      data = "$data $powerTmps";
    }
    else{
      data = "$data 0$powerTmps";
    }

    data = "$data ${isOpen ? '01' : '00'}";
    data = "$data 00"; // 08
    data = "$data 00"; // 09
    data = "$data 00"; // 10
    SerialPort().send(data);
    return isStart;
  }
}
