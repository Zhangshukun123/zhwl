import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/entity/port_data.dart';

import '../Controller/serial_port.dart';
import '../Controller/treatment_controller.dart';

class MidFrequencyField {
  static String MidFrequencyKey = "MidFrequencyKey"; // 存储 -key
  static String userId = "userId";
  static String patternA = "patternA";//模式 A
  static String timeA = "timeA";// 时间 A
  static String powerA = "powerA";// 强度 A
  static String patternB = "patternB";//模式 B
  static String timeB = "timeB";// 时间 B
  static String powerB = "powerB";// 强度 B
}

class MidFrequency {
  int? userId;
  String? patternA;
  String? timeA;
  String? powerA;
  String? patternB;
  String? timeB;
  String? powerB;


  MidFrequency({
    this.userId,
    this.patternA,
    this.timeA,
    this.powerA,
    this.patternB,
    this.timeB,
    this.powerB,
  });

  void init() {
    patternA = "1";
    timeA = "1";
    powerA = "1";
    patternB = "1";
    timeB = "1";
    powerB = "1";
  }




  factory MidFrequency.fromJson(String str) => MidFrequency.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MidFrequency.fromMap(Map<String, dynamic> json) => MidFrequency(
    userId: json[MidFrequencyField.userId],
    patternA: json[MidFrequencyField.patternA],
    timeA: json[MidFrequencyField.timeA],
    powerA: json[MidFrequencyField.powerA],
    patternB: json[MidFrequencyField.patternB],
    timeB: json[MidFrequencyField.timeB],
    powerB: json[MidFrequencyField.powerB],
  );

  Map<String, dynamic> toMap() => {
    MidFrequencyField.userId: userId,
    MidFrequencyField.patternA: patternA,
    MidFrequencyField.timeA: timeA,
    MidFrequencyField.powerA: powerA,
    MidFrequencyField.patternB: patternB,
    MidFrequencyField.timeB: timeB,
    MidFrequencyField.powerB: powerB,
  };

  bool start1(bool isStart) {
    final TreatmentController controller = Get.find();
    if (controller.user.value.userId == 0) {
      Fluttertoast.showToast(msg: '请选择用户',fontSize: 22,backgroundColor: Colors.blue);
      return false;
    }

    // AB BA 01 03(04) 03(04) 01 01 12 36 60 XX XX XX CRCH CRCL
    String data = BYTE00_RW.B01;
    data = "$data ${BYTE01_MD.B08}"; // byt01 功能模块    01

    //如果开始按钮1
    data = "$data ${BYTE02_CN.B81}";//BYte02 通道 02


    if (isStart) {
      // byte03 通道启停 03
      data = "$data ${BYTE03_STOP.B01}";
    } else {
      data = "$data ${BYTE03_STOP.B02}";
    }

    //处方暂未更改
    if (TextUtil.isEmpty(patternA)) {
      patternA = '1';
    }
    data = "$data $patternA";

    if (TextUtil.isEmpty(timeA)) {
      timeA = '1';
    }
    // data = "$data $timeA"; //byte05 工作时间 05
    data = "$data ${(double.tryParse(timeA!))?.toInt()}";

    if (TextUtil.isEmpty(powerA)) {
      powerA = '1';
    }
    // data = "$data $powerA"; // byte06 强度 06
    data = "$data ${(double.tryParse(powerA!))?.toInt()}";

    data = "$data 00";  // byte07  07
    data = "$data 00";  // byte08  08
    data = "$data 00"; // 09
    data = "$data 00"; // 10

    SerialPort().send(data);
    return isStart;
  }


  bool start2(bool isStart) {
    final TreatmentController controller = Get.find();
    if (controller.user.value.userId == 0) {
      Fluttertoast.showToast(msg: '请选择用户',fontSize: 22,backgroundColor: Colors.blue);
      return false;
    }

    // AB BA 01 03(04) 03(04) 01 01 12 36 60 XX XX XX CRCH CRCL
    String data = BYTE00_RW.B01;
    data = "$data ${BYTE01_MD.B08}"; // byt01 功能模块    01

    //如果开始按钮1
    data = "$data ${BYTE02_CN.B82}";//BYte02 通道 02


    if (isStart) {
      // byte03 通道启停 03
      data = "$data ${BYTE03_STOP.B01}";
    } else {
      data = "$data ${BYTE03_STOP.B02}";
    }

    //处方暂未更改
    if (TextUtil.isEmpty(patternB)) {
      patternB = '1';
    }
    data = "$data $patternB";

    if (TextUtil.isEmpty(timeB)) {
      timeB = '1';
    }
    // data = "$data $timeB"; //byte05 工作时间 05
    data = "$data ${(double.tryParse(timeB!))?.toInt()}";

    if (TextUtil.isEmpty(powerB)) {
      powerB = '1';
    }
    // data = "$data $powerB"; // byte06 强度 06
    data = "$data ${(double.tryParse(powerB!))?.toInt()}";

    data = "$data 00";  // byte07  07
    data = "$data 00";  // byte08  08
    data = "$data 00"; // 09
    data = "$data 00"; // 10

    SerialPort().send(data);
    return isStart;
  }



}