import 'dart:convert';

import 'package:common_utils/common_utils.dart';

class RecordField {
  static String recordId = "recordId"; // ID
  static String userId = "userId"; // ID
  static String recordType = "recordType"; // 治疗方式
  static String pattern = "pattern"; // 模式
  static String power = "power"; // 功率
  static String strengthGrade = "strengthGrade"; // 强度
  static String soundIntensity = "soundIntensity"; // 声强
  static String frequency = "frequency"; // 频率
  static String dataTime = "dataTime"; // 时间
  static String utilityTime = "utilityTime"; // 时长
  static String actionTime = "actionTime"; // 使用时间
  static String zdTime = "zdTime"; // 震动打开时间
  static String width = "width"; // 脉宽
  static String widthA = "widthA"; // 脉宽A
  static String widthB = "widthB"; // 脉宽B
  static String delayTime = "delayTime"; // 延时时间
  static String circle = "circle"; // 脉冲周期
  static String strengthGradeA = "strengthGradeA"; // 强度A
  static String strengthGradeB = "strengthGradeB"; // 强度B
  static String prescription = "prescription"; // 处方
}

class Record {
  int? recordId;
  String? recordType;
  String? pattern;
  String? power;
  String? strengthGrade;
  String? strengthGradeA;
  String? strengthGradeB;
  String? width;
  String? soundIntensity;
  String? frequency;
  String? dataTime;
  String? widthA;
  String? utilityTime;
  String? actionTime;
  String? zdTime;
  String? widthB;
  String? circle;
  String? delayTime;
  String? prescription;
  int? userId;

  Record({
    this.recordId,
    this.recordType,
    this.pattern,
    this.power,
    this.width,
    this.strengthGrade,
    this.soundIntensity,
    this.frequency,
    this.actionTime,
    this.dataTime,
    this.zdTime,
    this.widthB,
    this.widthA,
    this.circle,
    this.delayTime,
    this.utilityTime,
    this.strengthGradeA,
    this.strengthGradeB,
    this.prescription,
    this.userId,
  });

  factory Record.fromJson(String str) => Record.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Record.fromMap(Map<String, dynamic> json) => Record(
        recordId: json[RecordField.recordId],
        userId: json[RecordField.userId],
        recordType: json[RecordField.recordType],
        actionTime: json[RecordField.actionTime],
        strengthGrade: json[RecordField.strengthGrade],
        pattern: json[RecordField.pattern],
        zdTime: json[RecordField.zdTime],
        power: json[RecordField.power],
        widthA: json[RecordField.widthA],
        widthB: json[RecordField.widthB],
        delayTime: json[RecordField.delayTime],
        strengthGradeA: json[RecordField.strengthGradeA],
        strengthGradeB: json[RecordField.strengthGradeB],
        width: json[RecordField.width],
        circle: json[RecordField.circle],
        soundIntensity: json[RecordField.soundIntensity],
        frequency: json[RecordField.frequency],
        dataTime: json[RecordField.dataTime],
        prescription: json[RecordField.prescription],
        utilityTime: json[RecordField.utilityTime],
      );

  Map<String, dynamic> toMap() => {
        RecordField.recordId: recordId,
        RecordField.userId: userId,
        RecordField.recordType: recordType,
        RecordField.pattern: pattern,
        RecordField.zdTime: zdTime,
        RecordField.actionTime: actionTime,
        RecordField.strengthGrade: strengthGrade,
        RecordField.power: power,
        RecordField.strengthGradeA: strengthGradeA,
        RecordField.strengthGradeB: strengthGradeB,
        RecordField.widthA: widthA,
        RecordField.delayTime: delayTime,
        RecordField.width: width,
        RecordField.circle: circle,
        RecordField.widthB: widthB,
        RecordField.soundIntensity: soundIntensity,
        RecordField.frequency: frequency,
        RecordField.dataTime: dataTime,
        RecordField.prescription: prescription,
        RecordField.utilityTime: utilityTime,
      };

  List<String>? getInfoList() {
    List<String> infos = [];
    if (!TextUtil.isEmpty(pattern)) {
      infos.add('模式：$pattern');
    }
    if (!TextUtil.isEmpty(prescription)) {
      infos.add('处方：$prescription');
    }
    if (!TextUtil.isEmpty(utilityTime)) {
      infos.add('设定时间：${utilityTime}min');
    }
    if (!TextUtil.isEmpty(power)) {
      infos.add('功率：${power}w');
    }
    if (!TextUtil.isEmpty(strengthGrade)) {
      infos.add('强度：${strengthGrade}w');
    }
    if (!TextUtil.isEmpty(soundIntensity)) {
      infos.add('声强：${power}w/c㎡');
    }
    if (!TextUtil.isEmpty(frequency)) {
      infos.add('频率：${frequency}MHz');
    }
    if (!TextUtil.isEmpty(width)) {
      infos.add('脉宽：${width}ms');
    }
    if (!TextUtil.isEmpty(widthA)) {
      infos.add('脉宽A：${widthA}ms');
    }
    if (!TextUtil.isEmpty(widthB)) {
      infos.add('脉宽B：${widthB}ms');
    }
    if (!TextUtil.isEmpty(delayTime)) {
      infos.add('延时时间：${delayTime}s');
    }
    if (!TextUtil.isEmpty(circle)) {
      infos.add('脉冲周期：${circle}s');
    }
    if (!TextUtil.isEmpty(actionTime)) {
      infos.add('治疗时长：${actionTime}min');
    }
    if (!TextUtil.isEmpty(zdTime) && zdTime != "0") {
      infos.add('震动打开时间：${zdTime}min');
    }
    return infos;
  }
}
