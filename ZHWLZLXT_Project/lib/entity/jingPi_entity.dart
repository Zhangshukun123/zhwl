import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/entity/port_data.dart';

import '../Controller/serial_port.dart';
import '../Controller/treatment_controller.dart';

class PercutaneousField {
  static String PercutaneousKey = "PercutaneousKey"; // 存储 -key
  static String userId = "userId";
  static String patternA = "patternA";//模式 A
  static String timeA = "timeA";// 时间 A
  static String powerA = "powerA";// 强度 A
  static String frequencyA = "frequencyA";// 频率 A
  static String pulseA = "pulseA";// 脉宽 A
  static String patternB = "patternB";//模式 B
  static String timeB = "timeB";// 时间 B
  static String powerB = "powerB";// 强度 B
  static String frequencyB = "frequencyB";// 频率 B
  static String pulseB = "pulseB";// 脉宽 B
}

class Percutaneous {
  int? userId;
  String? patternA;
  String? timeA;
  String? powerA;
  String? frequencyA;
  String? pulseA;
  String? patternB;
  String? timeB;
  String? powerB;
  String? frequencyB;
  String? pulseB;


  Percutaneous({
    this.userId,
    this.patternA,
    this.timeA,
    this.powerA,
    this.frequencyA,
    this.pulseA,
    this.patternB,
    this.timeB,
    this.powerB,
    this.frequencyB,
    this.pulseB,
  });

  factory Percutaneous.fromJson(String str) => Percutaneous.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Percutaneous.fromMap(Map<String, dynamic> json) => Percutaneous(
    userId: json[PercutaneousField.userId],
    patternA: json[PercutaneousField.patternA],
    timeA: json[PercutaneousField.timeA],
    powerA: json[PercutaneousField.powerA],
    frequencyA: json[PercutaneousField.frequencyA],
    pulseA: json[PercutaneousField.pulseA],
    patternB: json[PercutaneousField.patternB],
    timeB: json[PercutaneousField.timeB],
    powerB: json[PercutaneousField.powerB],
    frequencyB: json[PercutaneousField.frequencyB],
    pulseB: json[PercutaneousField.pulseB],
  );

  Map<String, dynamic> toMap() => {
    PercutaneousField.userId: userId,
    PercutaneousField.patternA: patternA,
    PercutaneousField.timeA: timeA,
    PercutaneousField.powerA: powerA,
    PercutaneousField.frequencyA: frequencyA,
    PercutaneousField.pulseA: pulseA,
    PercutaneousField.patternB: patternB,
    PercutaneousField.timeB: timeB,
    PercutaneousField.powerB: powerB,
    PercutaneousField.frequencyB: frequencyB,
    PercutaneousField.pulseB: pulseB,
  };

  bool start1(bool isStart) {
    final TreatmentController controller = Get.find();
    if (controller.user.value.userId == 0) {
      Fluttertoast.showToast(msg: '请选择用户',fontSize: 22,backgroundColor: Colors.blue);
      return false;
    }

    // AB BA 01 03(04) 03(04) 01 01 12 36 60 XX XX XX CRCH CRCL
    String data = BYTE00_RW.B01;
    data = "$data ${BYTE01_MD.B06}"; // byt01 功能模块    01

    //如果开始按钮1
    data = "$data ${BYTE02_CN.B61}";//BYte02 通道 02


    if (isStart) {
      // byte03 通道启停 03
      data = "$data ${BYTE03_STOP.B01}";
    } else {
      data = "$data ${BYTE03_STOP.B02}";
    }

    if (TextUtil.isEmpty(patternA)) {
      patternA = BYTE04_PT.S_J_01;
    }
    if (patternA == BYTE04_PT.S_J_01) {
      // 04
      data = "$data ${BYTE04_PT.B01}";
    }
    if (patternA == BYTE04_PT.S_J_02) {
      data = "$data ${BYTE04_PT.B02}";
    }
    if (patternA == BYTE04_PT.S_J_03) {
      data = "$data ${BYTE04_PT.B03}";
    }

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

    if (TextUtil.isEmpty(frequencyA)) {
      frequencyA = '2';
    }
    // data = "$data $frequencyA"; // byte07 频率 07
    data = "$data ${(double.tryParse(frequencyA!))?.toInt()}";

    if (TextUtil.isEmpty(pulseA)) {
      pulseA = '0';
    }
    // data = "$data $pulseA"; // byte08 脉宽 08
    data = "$data ${(double.tryParse(pulseA!))!~/10}";

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
    data = "$data ${BYTE01_MD.B06}"; // byt01 功能模块    01

    //如果开始按钮1
    data = "$data ${BYTE02_CN.B62}";//BYte02 通道 02


    if (isStart) {
      // byte03 通道启停 03
      data = "$data ${BYTE03_STOP.B01}";
    } else {
      data = "$data ${BYTE03_STOP.B02}";
    }

    //如果启动的通道2开始按钮
      if (TextUtil.isEmpty(patternB)) {
        patternB = BYTE04_PT.S_J_01;
      }
      if (patternB == BYTE04_PT.S_J_01) {
        // 04
        data = "$data ${BYTE04_PT.B01}";
      }
      if (patternB == BYTE04_PT.S_J_02) {
        data = "$data ${BYTE04_PT.B02}";
      }
      if (patternB == BYTE04_PT.S_J_03) {
        data = "$data ${BYTE04_PT.B03}";
      }

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

      if (TextUtil.isEmpty(frequencyB)) {
        frequencyB = '2';
      }
      // data = "$data $frequencyB"; // byte07 频率 07
    data = "$data ${(double.tryParse(frequencyB!))?.toInt()}";

      if (TextUtil.isEmpty(pulseB)) {
        pulseB = '0';
      }
      // data = "$data $pulseB"; // byte08 脉宽 08
    data = "$data ${(double.tryParse(pulseB!))!~/10}";


    data = "$data 00"; // 09
    data = "$data 00"; // 10

    SerialPort().send(data);
    return isStart;
  }





}