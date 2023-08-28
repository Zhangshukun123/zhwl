import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zhwlzlxt_project/entity/port_data.dart';

import '../Controller/serial_port.dart';

class InfraredField {
  static String InfraredKey = "InfraredKey"; // 存储 -key
  static String userId = "userId";
  static String time = "time";//时间
  static String power = "power";//强度
  static String pattern = "pattern";//模式
}

class InfraredEntity {
  int? userId;
  String? time;
  String? power;
  String? pattern;


  InfraredEntity({
    this.userId,
    this.time,
    this.power,
    this.pattern,
  });

  factory InfraredEntity.fromJson(String str) => InfraredEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InfraredEntity.fromMap(Map<String, dynamic> json) => InfraredEntity(
    userId: json[InfraredField.userId],
    time: json[InfraredField.time],
    power: json[InfraredField.power],
    pattern: json[InfraredField.pattern],
  );

  Map<String, dynamic> toMap() => {
    InfraredField.userId: userId,
    InfraredField.time: time,
    InfraredField.power: power,
    InfraredField.pattern: pattern,
  };

  bool start(bool isStart, bool isOpen) {
    if (userId == null || userId == -1) {
      Fluttertoast.showToast(msg: '请选择用户');
      return false;
    }

    // AB BA 01 03(04) 03(04) 01 01 12 36 60 XX XX XX CRCH CRCL
    String data = BYTE00_RW.B01; // 00
    data = "$data ${BYTE01_MD.B01}"; // byt01 功能模块    01
    data = "$data XX";//BYte02 通道 02

    if (isStart) {
      // byte03 通道启停 03
      data = "$data ${BYTE03_STOP.B01}";
    } else {
      data = "$data ${BYTE03_STOP.B02}";
    }

    //byte04 光疗 04
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

    //byte05 光疗工作时间
    if (TextUtil.isEmpty(time)) {
      time = '1';
    }
    // data = "$data $time"; // 05
    data = "$data ${(double.tryParse(time!))?.toInt()}";

    if (TextUtil.isEmpty(power)) {
      power = '0';
    }
    // data = "$data $power"; // 06
    data = "$data ${(double.tryParse(power!))?.toInt()}";

    data = "$data XX"; //07

    data = "$data XX"; // 08
    data = "$data XX"; // 09
    data = "$data XX"; // 10
    SerialPort().send(data);
    return isStart;
  }





}