import 'dart:convert';

import 'package:common_utils/common_utils.dart';
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
      Fluttertoast.showToast(msg: '请选择用户');
      return false;
    }
    // AB BA 01 03(04) 03(04) 01 01 12 36 60 XX XX XX CRCH CRCL
    String data = BYTE00_RW.B01; // 00
    data = "$data ${BYTE01_MD.B02}"; // byt01 功能模块    01
    data = "$data 00";
    if (isStart) {
      // 03
      data = "$data ${BYTE03_STOP.B01}";
    } else {
      data = "$data ${BYTE03_STOP.B02}";
    }

    if (TextUtil.isEmpty(frequency)) {
      frequency = '20';
    }
    // data = "$data $frequency";
    data = "$data ${(double.tryParse(frequency!))?.toInt()}";

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

    data = "$data ${isOpen ? '01' : '00'}";
    data = "$data 00"; // 08
    data = "$data 00"; // 09
    data = "$data 00"; // 10
    SerialPort().send(data);
    return isStart;
  }
}
