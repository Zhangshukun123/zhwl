import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/base/globalization.dart';
import 'package:zhwlzlxt_project/entity/port_data.dart';
import 'package:zhwlzlxt_project/entity/record_entity.dart';
import 'package:zhwlzlxt_project/entity/user_entity.dart';

import '../Controller/serial_port.dart';
import '../Controller/treatment_controller.dart';
import '../dataResource/record_sql_dao.dart';

class NeuromuscularField {
  static String NeuromuscularKey = "NeuromuscularKey"; // 存储 -key
  static String userId = "userId";
  static String patternA = "patternA";//模式 A
  static String timeA = "timeA";// 时间 A
  static String powerA = "powerA";// 强度 A
  static String frequencyA = "frequencyA";// 频率 A
  static String patternB = "patternB";//模式 B
  static String timeB = "timeB";// 时间 B
  static String powerB = "powerB";// 强度 B
  static String frequencyB = "frequencyB";// 频率 B
}

class Neuromuscular {
  int? userId;
  String? patternA;
  String? timeA;
  String? powerA;
  String? frequencyA;
  String? patternB;
  String? timeB;
  String? powerB;
  String? frequencyB;
  String? settingTime;


  Neuromuscular({
    this.userId,
    this.patternA,
    this.timeA,
    this.powerA,
    this.frequencyA,
    this.patternB,
    this.timeB,
    this.powerB,
    this.frequencyB,
  });

  void init() {
    patternA = Globalization.complete.tr;
    timeA = "20";
    powerA = "0";
    frequencyA = "0.5";
    patternB = Globalization.complete.tr;
    timeB = "20";
    powerB = "0";
    frequencyB = "0.5";
  }


  void setARestValue(){
    save1();

    patternA = Globalization.complete.tr;
    timeA = "20";
    powerA = "0";
    frequencyA = "0.5";
  }

  void setBRestValue(){
    save2();
    patternB = Globalization.complete.tr;
    timeB = "20";
    powerB = "0";
    frequencyB = "0.5";
  }



  factory Neuromuscular.fromJson(String str) => Neuromuscular.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Neuromuscular.fromMap(Map<String, dynamic> json) => Neuromuscular(
    userId: json[NeuromuscularField.userId],
    patternA: json[NeuromuscularField.patternA],
    timeA: json[NeuromuscularField.timeA],
    powerA: json[NeuromuscularField.powerA],
    frequencyA: json[NeuromuscularField.frequencyA],
    patternB: json[NeuromuscularField.patternB],
    timeB: json[NeuromuscularField.timeB],
    powerB: json[NeuromuscularField.powerB],
    frequencyB: json[NeuromuscularField.frequencyB],
  );

  Map<String, dynamic> toMap() => {
    NeuromuscularField.userId: userId,
    NeuromuscularField.patternA: patternA,
    NeuromuscularField.timeA: timeA,
    NeuromuscularField.powerA: powerA,
    NeuromuscularField.frequencyA: frequencyA,
    NeuromuscularField.patternB: patternB,
    NeuromuscularField.timeB: timeB,
    NeuromuscularField.powerB: powerB,
    NeuromuscularField.frequencyB: frequencyB,
  };


  DateTime? startTime;
  DateTime? endTime;
  User? user;
  bool start1(bool isStart,bool isOpenStart) {

    if(isStart&&isOpenStart){
      settingTime = timeA;
      startTime = DateTime.now();
    }

    // AB BA 01 03(04) 03(04) 01 01 12 36 60 XX XX XX CRCH CRCL
    String data = BYTE00_RW.B01;
    data = "$data ${BYTE01_MD.B07}"; // byt01 功能模块    01

    //如果开始按钮1
    data = "$data ${BYTE02_CN.B71}";//BYte02 通道 02


    if (isStart) {
      // byte03 通道启停 03
      data = "$data ${BYTE03_STOP.B01}";

    } else {
      data = "$data ${BYTE03_STOP.B02}";
    }

    if (TextUtil.isEmpty(patternA)) {
      patternA = Globalization.complete.tr;
    }
    if (patternA == Globalization.complete.tr) {
      // 04
      // data = "$data ${BYTE04_PT.B01}";
      var patternValue = double.tryParse(BYTE04_PT.B01);
      var patternTmps = patternValue?.toInt().toRadixString(16);
      if (patternTmps!.length > 1){
        data = "$data $patternTmps";
      }
      else{
        data = "$data 0$patternTmps";
      }
    }
    if (patternA == Globalization.partial.tr) {
      // data = "$data ${BYTE04_PT.B02}";
      var patternValue = double.tryParse(BYTE04_PT.B02);
      var patternTmps = patternValue?.toInt().toRadixString(16);
      if (patternTmps!.length > 1){
        data = "$data $patternTmps";
      }
      else{
        data = "$data 0$patternTmps";
      }
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
    }
    else{
      data = "$data 0$timeATmps";
    }

    if (TextUtil.isEmpty(powerA)) {
      powerA = '1';
    }
    // data = "$data $powerA"; // byte06 强度 06
    // data = "$data ${(double.tryParse(powerA!))?.toInt()}";
    var powerAValue = double.tryParse(powerA!);
    var powerATmps = powerAValue?.toInt().toRadixString(16);
    if (powerATmps!.length > 1) {
      data = "$data $powerATmps";
    }
    else{
      data = "$data 0$powerATmps";
    }

    if (TextUtil.isEmpty(frequencyA)) {
      frequencyA = '0.5';
    }
    // data = "$data $frequencyA"; // byte07 频率 07
    // data = "$data ${((double.tryParse(frequencyA!))!*10).toInt()}";
    var frequencyAValue = double.tryParse(frequencyA!)!*10;
    var frequencyATmps = frequencyAValue?.toInt().toRadixString(16);
    if (frequencyATmps!.length > 1) {
      data = "$data $frequencyATmps";
    }
    else{
      data = "$data 0$frequencyATmps";
    }

    data = "$data 00";  // byte08  08
    data = "$data 00"; // 09
    data = "$data 00"; // 10

    SerialPort().send(data);
    return isStart;
  }
  void save1(){
    if (user != null && user?.userId != 0){
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
          pattern: patternA,
          utilityTime: settingTime,
          recordType: '神经肌肉电刺激',
          actionTime: min,
          strengthGrade: powerA,
          frequency: frequencyA,
        );
        RecordSqlDao.instance().addData(record: record);
    }
  }




  DateTime? startTime2;
  DateTime? endTime2;
String? settingTimeB;

  bool start2(bool isStart,bool isOpenStart) {
    if(isStart&&isOpenStart){
      settingTimeB = timeB;
      startTime2 = DateTime.now();
    }

    // AB BA 01 03(04) 03(04) 01 01 12 36 60 XX XX XX CRCH CRCL
    String data = BYTE00_RW.B01;
    data = "$data ${BYTE01_MD.B07}"; // byt01 功能模块    01

    //如果开始按钮1
    data = "$data ${BYTE02_CN.B72}";//BYte02 通道 02


    if (isStart) {
      // byte03 通道启停 03
      data = "$data ${BYTE03_STOP.B01}";
    } else {
      data = "$data ${BYTE03_STOP.B02}";
    }

    if (TextUtil.isEmpty(patternB)) {
      patternB = Globalization.complete.tr;
    }
    if (patternB == Globalization.complete.tr) {
      // 04
      // data = "$data ${BYTE04_PT.B01}";
      var patternValue = double.tryParse(BYTE04_PT.B01);
      var patternTmps = patternValue?.toInt().toRadixString(16);
      if (patternTmps!.length > 1){
        data = "$data $patternTmps";
      }
      else{
        data = "$data 0$patternTmps";
      }
    }
    if (patternB == Globalization.partial.tr) {
      // data = "$data ${BYTE04_PT.B02}";
      var patternValue = double.tryParse(BYTE04_PT.B02);
      var patternTmps = patternValue?.toInt().toRadixString(16);
      if (patternTmps!.length > 1){
        data = "$data $patternTmps";
      }
      else{
        data = "$data 0$patternTmps";
      }
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
    }
    else{
      data = "$data 0$timeBTmps";
    }

    if (TextUtil.isEmpty(powerB)) {
      powerB = '1';
    }
    // data = "$data $powerB"; // byte06 强度 06
    // data = "$data ${(double.tryParse(powerB!))?.toInt()}";
    var powerBValue = double.tryParse(powerB!);
    var powerBTmps = powerBValue?.toInt().toRadixString(16);
    if (powerBTmps!.length > 1) {
      data = "$data $powerBTmps";
    }
    else{
      data = "$data 0$powerBTmps";
    }

    if (TextUtil.isEmpty(frequencyB)) {
      frequencyB = '0.5';
    }
    // data = "$data $frequencyB"; // byte07 频率 07
    // data = "$data ${((double.tryParse(frequencyB!))!*10).toInt()}";
    var frequencyBValue = double.tryParse(frequencyB!)!*10;
    var frequencyBTmps = frequencyBValue.toInt().toRadixString(16);
    if (frequencyBTmps.length > 1) {
      data = "$data $frequencyBTmps";
    }
    else{
      data = "$data 0$frequencyBTmps";
    }

    data = "$data 00";  // byte08  08
    data = "$data 00"; // 09
    data = "$data 00"; // 10

    SerialPort().send(data);
    return isStart;
  }



  void save2(){
    if (user != null && user?.userId != 0){
        endTime2 = DateTime.now();
        String min = '';
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
          pattern: patternB,
          utilityTime: settingTimeB,
          recordType: '神经肌肉电刺激',
          actionTime: min,
          strengthGrade: powerB,
          frequency: frequencyB,
        );
        RecordSqlDao.instance().addData(record: record);
    }
  }




}