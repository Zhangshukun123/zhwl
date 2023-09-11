import 'dart:convert';
import 'dart:ffi';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/Controller/serial_port.dart';
import 'package:zhwlzlxt_project/entity/port_data.dart';
import 'package:zhwlzlxt_project/entity/set_value_state.dart';

import '../Controller/treatment_controller.dart';
import '../utils/event_bus.dart';

class UltrasonicField {
  static String UltrasonicKey = "UltrasonicKey"; // 存储 -key
  static String pattern = "pattern";
  static String userId = "userId";
  static String time = "time";
  static String power = "power";
  static String soundIntensity = "soundIntensity";
  static String frequency = "frequency";
}

class Ultrasonic {
  int? userId = -1;
  String? pattern = '连续模式1';
  String? time = '1';
  String? power = '0.0';
  String? soundIntensity = '0.0';
  String? frequency = '1';

  Ultrasonic({
    this.userId,
    this.pattern,
    this.time,
    this.power,
    this.soundIntensity,
    this.frequency,
  });

  init() {
    pattern = "连续模式1";
    time = '1';
    power = '0.0';
    soundIntensity = '0.0';
    frequency = '1';
  }

  factory Ultrasonic.fromJson(String str) =>
      Ultrasonic.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ultrasonic.fromMap(Map<String, dynamic> json) => Ultrasonic(
        userId: json[UltrasonicField.userId],
        pattern: json[UltrasonicField.pattern],
        time: json[UltrasonicField.time],
        power: json[UltrasonicField.power],
        soundIntensity: json[UltrasonicField.soundIntensity],
        frequency: json[UltrasonicField.frequency],
      );

  Map<String, dynamic> toMap() => {
        UltrasonicField.userId: userId,
        UltrasonicField.pattern: pattern,
        UltrasonicField.time: time,
        UltrasonicField.power: power,
        UltrasonicField.soundIntensity: soundIntensity,
        UltrasonicField.frequency: frequency,
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

    if (TextUtil.isEmpty(frequency)) {
      frequency = '1';
    }

    if (frequency == '1') {
      data = "$data ${BYTE01_MD.B03}"; // byt01 功能模块    01
      data = "$data ${BYTE02_CN.B01}"; // bty 02 通道 02
    }
    if (frequency == '3') {
      // 01
      data = "$data ${BYTE01_MD.B04}";
      data = "$data ${BYTE02_CN.B03}";
    }
    if (isStart) {
      // 03
      data = "$data ${BYTE03_STOP.B01}";
    } else {
      data = "$data ${BYTE03_STOP.B02}";
    }

    if (TextUtil.isEmpty(pattern)) {
      pattern = BYTE04_PT.B_T_01;
    }

    if (pattern == BYTE04_PT.B_T_01) {
      // 04
      data = "$data ${BYTE04_PT.B01}";
    }
    if (pattern == BYTE04_PT.B_T_02) {
      data = "$data ${BYTE04_PT.B02}";
    }
    if (pattern == BYTE04_PT.B_T_03) {
      data = "$data ${BYTE04_PT.B03}";
    }
    if (pattern == BYTE04_PT.B_T_04) {
      data = "$data ${BYTE04_PT.B04}";
    }

    if (TextUtil.isEmpty(time)) {
      time = '1';
    }
    //李建成09.06提出修改，时间输出应该由10进制改成16进制

    debugPrint('++++time+++++$time');
    var value = double.tryParse(time!);
    debugPrint('++++value+++++$value');
    //转成16进制数据
    var tmpS = value?.toInt().toRadixString(16);
    debugPrint('++++tmpS+++++$tmpS');

    if (tmpS!.length > 1) {
      data = "$data $tmpS"; // 05
    } else {
      data = "$data 0$tmpS"; // 05
    }

    //data = "$data $time";
    // data = "$data ${(double.tryParse(time!))?.toInt()}"; // 05

    if (TextUtil.isEmpty(power)) {
      power = '0.0';
    }
    data = "$data ${((double.tryParse(power!))! * 10).toInt()}"; // 06

    if (TextUtil.isEmpty(soundIntensity)) {
      soundIntensity = '0.0';
    }

    data = "$data ${((double.tryParse(soundIntensity!))! * 100).toInt()}"; // 07

    data = "$data 00"; // 08
    data = "$data 00"; // 09
    data = "$data 00"; // 10
    SerialPort().send(data);
    return isStart;
  }
}
