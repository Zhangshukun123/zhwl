import 'dart:convert';
import 'dart:core';
import 'dart:ffi';

import 'package:common_utils/common_utils.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/Controller/serial_port.dart';
import 'package:zhwlzlxt_project/dataResource/record_sql_dao.dart';
import 'package:zhwlzlxt_project/entity/port_data.dart';
import 'package:zhwlzlxt_project/entity/record_entity.dart';
import 'package:zhwlzlxt_project/entity/set_value_state.dart';
import 'package:zhwlzlxt_project/entity/user_entity.dart';

import '../Controller/treatment_controller.dart';
import '../base/globalization.dart';
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
  String? pattern = Globalization.intermittentOne.tr;
  String? time = '1';
  String? power = '0.0';
  String? soundIntensity = '0.0';
  String? frequency = '1';
  String? setTime = '1';

  Ultrasonic({
    this.userId,
    this.pattern,
    this.time,
    this.power,
    this.soundIntensity,
    this.frequency,
  });

  init(bool isSave) {

    if(isSave){
      save();
    }
    pattern = Globalization.intermittentOne.tr;
    time = '20';
    power = '0';
    soundIntensity = '0.0';
    // frequency = '1';
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

  DateTime? startTime;
  DateTime? endTime;

  User? user;

  bool start(bool isStart,isOpenStart) {

    if(isStart&&isOpenStart){
      setTime = time;
      startTime = DateTime.now();
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

    if (pattern == BYTE04_PT.B_T_05) {
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

    if (TextUtil.isEmpty(time)) {
      time = '1';
    }
    //李建成09.06提出修改，时间输出应该由10进制改成16进制
    var value = double.tryParse(time!);
    //转成16进制数据
    var tmpS = value?.toInt().toRadixString(16);
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
    // data = "$data ${((double.tryParse(power!))! * 10).toInt()}"; // 06
    //数据进制转换
    var powerValue = double.tryParse(power!)! * 10;
    var powerTmps = powerValue.toInt().toRadixString(16);
    if (powerTmps.length > 1) {
      data = "$data $powerTmps";
    } else {
      data = "$data 0$powerTmps";
    }

    if (TextUtil.isEmpty(soundIntensity)) {
      soundIntensity = '0.0';
    }
    // data = "$data ${((double.tryParse(soundIntensity!))! * 100).toInt()}"; // 07
    //数据进制转换
    var soundValue = double.tryParse(soundIntensity!)! * 100;
    var soundTmps = soundValue.toInt().toRadixString(16);
    if (soundTmps.length > 1) {
      data = "$data $soundTmps";
    } else {
      data = "$data 0$soundTmps";
    }

    data = "$data 00"; // 08
    data = "$data 00"; // 09
    data = "$data 00"; // 10



    SerialPort().send(data);
    return isStart;
  }


  void save(){
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
        utilityTime: setTime,
        pattern: pattern,
        recordType: Globalization.ultrasound.tr,
        power: power,
        soundIntensity: soundIntensity,
        actionTime: min,
        frequency: frequency,
      );
      RecordSqlDao.instance().addData(record: record);
    }
  }

}
