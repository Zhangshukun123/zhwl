import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/dataResource/record_sql_dao.dart';
import 'package:zhwlzlxt_project/entity/port_data.dart';
import 'package:zhwlzlxt_project/entity/record_entity.dart';
import 'package:zhwlzlxt_project/entity/user_entity.dart';

import '../Controller/serial_port.dart';
import '../Controller/treatment_controller.dart';

class MidFrequencyField {
  static String MidFrequencyKey = "MidFrequencyKey"; // 存储 -key
  static String userId = "userId";
  static String patternA = "patternA"; //模式 A
  static String timeA = "timeA"; // 时间 A
  static String powerA = "powerA"; // 强度 A
  static String patternB = "patternB"; //模式 B
  static String timeB = "timeB"; // 时间 B
  static String powerB = "powerB"; // 强度 B
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

  void init(isSave) {
    if (isSave) {
      save1();
    }
    // patternA = "1";
    powerA = "0";
  }

  void init2(isSave) {
    if (isSave) {
      save2();
    }
    // patternB = "1";
    powerB = "0";
  }

  factory MidFrequency.fromJson(String str) =>
      MidFrequency.fromMap(json.decode(str));

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

  DateTime? startTime;
  DateTime? endTime;
  User? user;
  String? settingTimeA;

  bool start1(bool isStart, isOpenStart,{sendSuccessBack? back, sendFinish? finish}) {
    if (isStart && isOpenStart) {
      settingTimeA = timeA;
      startTime = DateTime.now();
    }
    // final TreatmentController controller = Get.find();
    // if (controller.user.value.userId == 0||controller.user.value.userId == null) {
    //   Fluttertoast.showToast(
    //       msg: '请选择用户', fontSize: 22, backgroundColor: Colors.blue);
    //   return false;
    // }

    // AB BA 01 03(04) 03(04) 01 01 12 36 60 XX XX XX CRCH CRCL
    String data = BYTE00_RW.B01;
    data = "$data ${BYTE01_MD.B08}"; // byt01 功能模块    01

    //如果开始按钮1
    data = "$data ${BYTE02_CN.B81}"; //BYte02 通道 02

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
    // data = "$data $patternA";
    var patternValue = double.tryParse(patternA!);
    var patternTmps = patternValue?.toInt().toRadixString(16);
    if (patternTmps!.length > 1) {
      data = "$data $patternTmps";
    } else {
      data = "$data 0$patternTmps";
    }

    if (TextUtil.isEmpty(timeA)) {
      timeA = '1';
    }
    // data = "$data $timeA"; //byte05 工作时间 05
    // data = "$data ${(double.tryParse(timeA!))?.toInt()}";
    var timeAValue = double.tryParse(timeA!);
    var timeATmps = timeAValue?.toInt().toRadixString(16);
    if (timeATmps!.length > 1) {
      data = "$data $timeATmps";
    } else {
      data = "$data 0$timeATmps";
    }

    if (TextUtil.isEmpty(powerA)) {
      powerA = '0';
    }
    // data = "$data $powerA"; // byte06 强度 06
    // data = "$data ${(double.tryParse(powerA!))?.toInt()}";
    var powerAValue = double.tryParse(powerA!);

    if (!isStart) {
      powerAValue = 0;
    }

    var powerATmps = powerAValue?.toInt().toRadixString(16);
    if (powerATmps!.length > 1) {
      data = "$data $powerATmps";
    } else {
      data = "$data 0$powerATmps";
    }

    data = "$data 00"; // byte07  07
    data = "$data 00"; // byte08  08
    data = "$data 00"; // 09
    data = "$data 00"; // 10

    SerialPort().send(data,isStart,back: back,finish: finish);
    if (!isStart) {
      timeA = '20';
    }
    return isStart;
  }

  void save1() {
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
        prescription: patternA,
        utilityTime: settingTimeA,
        recordType: '中频/干扰电治疗',
        actionTime: min,
        strengthGrade: powerA,
      );
      RecordSqlDao.instance().addData(record: record);
    }
  }

  DateTime? startTime2;
  DateTime? endTime2;
  String? settingTimeB;

  bool start2(bool isStart, {bool? isOpenStart,sendSuccessBack? back, sendFinish? finish}) {
    if (isStart && isOpenStart == true) {
      settingTimeB = timeB;
      startTime2 = DateTime.now();
    }
    // final TreatmentController controller = Get.find();
    // if (controller.user.value.userId == 0||controller.user.value.userId == null) {
    //   Fluttertoast.showToast(
    //       msg: '请选择用户', fontSize: 22, backgroundColor: Colors.blue);
    //   return false;
    // }

    // AB BA 01 03(04) 03(04) 01 01 12 36 60 XX XX XX CRCH CRCL
    String data = BYTE00_RW.B01;
    data = "$data ${BYTE01_MD.B08}"; // byt01 功能模块    01

    //如果开始按钮1
    data = "$data ${BYTE02_CN.B82}"; //BYte02 通道 02

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
    // data = "$data $patternB";
    var patternValue = double.tryParse(patternB!);
    var patternTmps = patternValue?.toInt().toRadixString(16);
    if (patternTmps!.length > 1) {
      data = "$data $patternTmps";
    } else {
      data = "$data 0$patternTmps";
    }

    if (TextUtil.isEmpty(timeB)) {
      timeB = '1';
    }
    // data = "$data $timeB"; //byte05 工作时间 05
    // data = "$data ${(double.tryParse(timeB!))?.toInt()}";
    var timeBValue = double.tryParse(timeB!);
    var timeBTmps = timeBValue?.toInt().toRadixString(16);
    if (timeBTmps!.length > 1) {
      data = "$data $timeBTmps";
    } else {
      data = "$data 0$timeBTmps";
    }

    if (TextUtil.isEmpty(powerB)) {
      powerB = '0';
    }
    // data = "$data $powerB"; // byte06 强度 06
    // data = "$data ${(double.tryParse(powerB!))?.toInt()}";
    var powerBValue = double.tryParse(powerB!);
    if (!isStart) {
      powerBValue = 0;
    }
    var powerBTmps = powerBValue?.toInt().toRadixString(16);

    if (powerBTmps!.length > 1) {
      data = "$data $powerBTmps";
    } else {
      data = "$data 0$powerBTmps";
    }

    data = "$data 00"; // byte07  07
    data = "$data 00"; // byte08  08
    data = "$data 00"; // 09
    data = "$data 00"; // 10

    SerialPort().send(data,isStart,back:back,finish: finish);
    if (!isStart) {
      timeB = '20';
    }
    return isStart;
  }

  void save2() {
    if (user != null && user?.userId != 0) {
      endTime2 = DateTime.now();
      String min = '';
      if(startTime2==null){
        return;
      }

      Duration diff = endTime2!.difference(startTime2!);
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
        prescription: patternB,
        utilityTime: settingTimeB,
        recordType: '中频/干扰电治疗',
        actionTime: min,
        strengthGrade: powerB,
      );
      RecordSqlDao.instance().addData(record: record);
    }
  }
}
