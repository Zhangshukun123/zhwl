import 'dart:convert';
import 'dart:core';

import 'package:common_utils/common_utils.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/entity/port_data.dart';
import 'package:zhwlzlxt_project/entity/record_entity.dart';
import 'package:zhwlzlxt_project/entity/user_entity.dart';

import '../Controller/serial_port.dart';
import '../Controller/treatment_controller.dart';
import '../base/globalization.dart';

import '../dataResource/record_sql_dao.dart';
import '../utils/sp_utils.dart';

class InfraredField {
  static String InfraredKey = "InfraredKey"; // 存储 -key
  static String userId = "userId";
  static String time = "time"; //时间
  static String power = "power"; //强度
  static String pattern = "pattern"; //模式
}

class InfraredEntity {
  int? userId;
  String? time;
  String? power;
  String? pattern;
  bool? isStart;

  InfraredEntity({
    this.userId,
    this.time,
    this.power,
    this.pattern,
    this.isStart,
  });

  String? settingTime;

  void init(bool isSave) {
    if (isSave) {
      save();
    }
    power = "1";
    pattern = Globalization.continuous.tr;
  }

  factory InfraredEntity.fromJson(String str) =>
      InfraredEntity.fromMap(json.decode(str));

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

  DateTime? startTime;
  DateTime? endTime;
  User? user;

  bool start(bool isStart, bool isOpenStart) {
    // final TreatmentController controller = Get.find();
    // print('--------------${controller.user.value.userId}');
    // if (controller.user.value.userId == 0 ||
    //     controller.user.value.userId == null) {
    //   Fluttertoast.showToast(
    //       msg: '请选择用户', fontSize: 22, backgroundColor: Colors.blue);
    //   return false;
    // }

    if (isStart && isOpenStart) {
      settingTime = time;
      startTime = DateTime.now();
    }

    // AB BA 01 03(04) 03(04) 01 01 12 36 60 XX XX XX CRCH CRCL
    String data = BYTE00_RW.B01; // 02
    data = "$data ${BYTE01_MD.B01}"; // byt01 功能模块    03
    data = "$data 00"; //BYte02 通道 04

    if (isStart) {
      // byte03 通道启停 05
      data = "$data ${BYTE03_STOP.B01}";
    } else {
      data = "$data ${BYTE03_STOP.B02}";
    }

    //byte04 光疗 06
    if (TextUtil.isEmpty(pattern)) {
      pattern = Globalization.continuous.tr;
    }
    if (pattern == Globalization.continuous.tr) {
      // 04
      // data = "$data ${BYTE04_PT.B01}";
      //转成double类型数据
      var patternValue1 = double.tryParse(BYTE04_PT.B01);
      //转成16进制数据
      var patternTmps1 = patternValue1?.toInt().toRadixString(16);
      //以16进制数据发送
      if (patternTmps1!.length > 1) {
        data = "$data $patternTmps1";
      } else {
        data = "$data 0$patternTmps1";
      }
    }
    if (pattern == Globalization.intermittentOne.tr) {
      // data = "$data ${BYTE04_PT.B02}";
      //转成double类型数据
      var patternValue2 = double.tryParse(BYTE04_PT.B02);
      //转成16进制数据
      var patternTmps2 = patternValue2?.toInt().toRadixString(16);
      //以16进制数据发送
      if (patternTmps2!.length > 1) {
        data = "$data $patternTmps2";
      } else {
        data = "$data 0$patternTmps2";
      }
    }
    if (pattern == Globalization.intermittentTwo.tr) {
      // data = "$data ${BYTE04_PT.B03}";
      //转成double类型数据
      var patternValue3 = double.tryParse(BYTE04_PT.B03);
      //转成16进制数据
      var patternTmps3 = patternValue3?.toInt().toRadixString(16);
      //以16进制数据发送
      if (patternTmps3!.length > 1) {
        data = "$data $patternTmps3";
      } else {
        data = "$data 0$patternTmps3";
      }
    }
    if (pattern == Globalization.intermittentThree.tr) {
      // data = "$data ${BYTE04_PT.B04}";
      //转成double类型数据
      var patternValue4 = double.tryParse(BYTE04_PT.B04);
      //转成16进制数据
      var patternTmps4 = patternValue4?.toInt().toRadixString(16);
      //以16进制数据发送
      if (patternTmps4!.length > 1) {
        data = "$data $patternTmps4";
      } else {
        data = "$data 0$patternTmps4";
      }
    }
    if (pattern == Globalization.frequency.tr) {
      // data = "$data ${BYTE04_PT.B04}";
      //转成double类型数据
      var patternValue4 = double.tryParse(BYTE04_PT.B05);
      //转成16进制数据
      var patternTmps4 = patternValue4?.toInt().toRadixString(16);
      //以16进制数据发送
      if (patternTmps4!.length > 1) {
        data = "$data $patternTmps4";
      } else {
        data = "$data 0$patternTmps4";
      }
    }

    //byte07 光疗工作时间
    if (TextUtil.isEmpty(time)) {
      time = '1';
    }
    // data = "$data $time"; // 07
    // data = "$data ${(double.tryParse(time!))?.toInt()}";
    //转成double类型数据
    var timeValue = double.tryParse(time!);
    //转成16进制数据
    var timeTmps = timeValue?.toInt().toRadixString(16);
    //以16进制数据发送
    if (timeTmps!.length > 1) {
      data = "$data $timeTmps";
    } else {
      data = "$data 0$timeTmps";
    }

    if (TextUtil.isEmpty(power)) {
      power = '0';
    }
    double? powerValue;
    var value = SpUtils.getInt('$pattern$power', defaultValue: -1);

    debugPrint("spower---------<$power");
    debugPrint("spower------pattern---<$value");


    if (value != -1) {
      powerValue = double.tryParse(value!.toString());
    } else {
      powerValue = double.tryParse(power!);
    }
    // data = "$data $power"; // 08
    // data = "$data ${(double.tryParse(power!))?.toInt()}";
    //转成double类型数据
    //转成16进制数据
    var powerTmps = powerValue?.toInt().toRadixString(16);
    //以16进制数据发送
    if (powerTmps!.length > 1) {
      data = "$data $powerTmps";
    } else {
      data = "$data 0$powerTmps";
    }

    data = "$data 00"; //09

    data = "$data 00"; // 10
    data = "$data 00"; // 11
    data = "$data 00"; // 12
    SerialPort().send(data);
    if (!isStart) {
      time = '20';
    }
    return isStart;
  }

  void save() {
    if (user != null && user?.userId != 0) {
      endTime = DateTime.now();
      String min = '';
      Duration diff = endTime!.difference(startTime!);
      if (diff.inMinutes == 0) {
        min = '1';
      } else {
        min = '${diff.inMinutes}';
      }
      // 存储信息 结束
      Record record = Record(
        userId: user?.userId,
        dataTime: formatDate(DateTime.now(),
            [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]),
        utilityTime: settingTime,
        pattern: pattern,
        recordType: Globalization.infrared.tr,
        strengthGrade: power,
        actionTime: min,
      );
      RecordSqlDao.instance().addData(record: record);
    }
  }
}
