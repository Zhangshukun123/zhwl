import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zhwlzlxt_project/Controller/serial_port.dart';
import 'package:zhwlzlxt_project/entity/port_data.dart';

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
    if (userId == null || userId == -1) {
      Fluttertoast.showToast(msg: '请选择用户');
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
    data = "$data $time"; // 05
    data = "$data ${double.tryParse(power!)}"; // 06
    data = "$data ${double.tryParse(soundIntensity!)}"; // 07
    data = "$data XX"; // 08
    data = "$data XX"; // 09
    data = "$data XX"; // 10
    SerialPort().send(data);
    return isStart;
  }
}
