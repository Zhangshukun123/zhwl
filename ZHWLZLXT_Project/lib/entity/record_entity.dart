import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';

import '../base/globalization.dart';

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
  static String width = "widthC"; // 脉宽
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
      infos.add('${Globalization.mode.tr}：$pattern');
    }
    if (!TextUtil.isEmpty(prescription)) {
      infos.add('${Globalization.recipe.tr}：$prescription');
    }
    if (!TextUtil.isEmpty(utilityTime)) {
      infos.add('${Globalization.setTime.tr}：${utilityTime}min');
    }
    if (!TextUtil.isEmpty(power)) {
      infos.add('${Globalization.power.tr}：${power}w');
    }
    if (!TextUtil.isEmpty(strengthGrade)) {
      infos.add('${Globalization.intensity.tr}：$strengthGrade');
    }
    if (!TextUtil.isEmpty(strengthGradeA)) {
      infos.add('${Globalization.intensityA.tr}：$strengthGradeA');
    }
    if (!TextUtil.isEmpty(strengthGradeB)) {
      infos.add('${Globalization.intensityB.tr}：$strengthGradeB');
    }
    if (!TextUtil.isEmpty(soundIntensity)) {
      infos.add('${Globalization.soundIntensity.tr}：${soundIntensity}w/c㎡');
    }
    if (!TextUtil.isEmpty(frequency) && frequency!.endsWith('次/min')) {
      var sp = frequency?.split("次/min");
      if (sp != null && sp.isNotEmpty) {
        infos.add(
            '${Globalization.frequency.tr}： ${sp[0]}${Globalization.ci.tr}/min');
      }
    } else if (!TextUtil.isEmpty(frequency) && frequency!.endsWith('MHz')) {
      infos.add('${Globalization.frequency.tr}：$frequency');
    } else if (!TextUtil.isEmpty(frequency)) {
      infos.add('${Globalization.frequency.tr}：${frequency}Hz');
    }

    if (!TextUtil.isEmpty(width)) {
      infos.add('${Globalization.pulseWidth.tr}：${width}us');
    }
    if (!TextUtil.isEmpty(widthA)) {
      infos.add('${Globalization.pulseWidthA.tr}：${widthA}ms');
    }
    if (!TextUtil.isEmpty(widthB)) {
      infos.add('${Globalization.pulseWidthB.tr}：${widthB}ms');
    }
    if (!TextUtil.isEmpty(delayTime)) {
      infos.add('${Globalization.delayTime.tr}：${delayTime}s');
    }
    if (!TextUtil.isEmpty(circle)) {
      infos.add('${Globalization.pulsePeriod.tr}：${circle}s');
    }
    if (!TextUtil.isEmpty(actionTime)) {
      infos.add('${Globalization.cureTime.tr}：${actionTime}min');
    }
    if (!TextUtil.isEmpty(zdTime) && zdTime != "0") {
      infos.add('${Globalization.openTime.tr}：${zdTime}min');
    }
    return infos;
  }

  String? getValueForKey(String? value) {
    Map<String, String> vK = getListTitle();
    return vK[value];
  }

  Map<String, String> getListTitle() {
    Map<String, String> mapData = {};
    if (!TextUtil.isEmpty(recordType)) {
      mapData[Globalization.therapyMethod.tr] = recordType!;
    }
    if (!TextUtil.isEmpty(pattern)) {
      mapData[Globalization.mode.tr] = pattern!;
    }
    if (!TextUtil.isEmpty(prescription)) {
      mapData[Globalization.recipe.tr] = prescription!;
    }
    if (!TextUtil.isEmpty(utilityTime)) {
      mapData[Globalization.setTime.tr] = '${utilityTime}min';
    }
    if (!TextUtil.isEmpty(power)) {
      mapData[Globalization.power.tr] = '${power}w';
    }
    if (!TextUtil.isEmpty(strengthGrade)) {
      mapData[Globalization.intensity.tr] = strengthGrade!;
    }
    if (!TextUtil.isEmpty(strengthGradeA)) {
      mapData[Globalization.intensityA.tr] = strengthGradeA!;
    }
    if (!TextUtil.isEmpty(strengthGradeB)) {
      mapData[Globalization.intensityB.tr] = strengthGradeB!;
    }
    if (!TextUtil.isEmpty(soundIntensity)) {
      mapData[Globalization.soundIntensity.tr] = '${soundIntensity}w/c㎡';
    }

    if (!TextUtil.isEmpty(frequency) && frequency!.endsWith('次/min')) {
      var sp = frequency?.split("次/min");
      if (sp != null && sp.isNotEmpty) {
        mapData[Globalization.frequency.tr] =
            '${sp[0]}${Globalization.ci.tr}/min';
      }
    } else if (!TextUtil.isEmpty(frequency) && frequency!.endsWith('MHz')) {
      mapData[Globalization.frequency.tr] = '$frequency';
    } else if (!TextUtil.isEmpty(frequency)) {
      mapData[Globalization.frequency.tr] = '${frequency}Hz';
    }
    if (!TextUtil.isEmpty(width)) {
      mapData[Globalization.pulseWidth.tr] = '${width}ms';
    }
    if (!TextUtil.isEmpty(widthA)) {
      mapData[Globalization.pulseWidthA.tr] = '${widthA}ms';
    }
    if (!TextUtil.isEmpty(widthB)) {
      mapData[Globalization.pulseWidthB.tr] = '${widthB}ms';
    }
    if (!TextUtil.isEmpty(delayTime)) {
      mapData[Globalization.delayTime.tr] = '${delayTime}s';
    }
    if (!TextUtil.isEmpty(circle)) {
      mapData[Globalization.pulsePeriod.tr] = '${circle}s';
    }
    if (!TextUtil.isEmpty(actionTime)) {
      mapData[Globalization.cureTime.tr] = '${actionTime}min';
    }
    if (!TextUtil.isEmpty(zdTime) && zdTime != "0") {
      mapData[Globalization.openTime.tr] = '${zdTime}min';
    }
    if (!TextUtil.isEmpty(dataTime)) {
      mapData[Globalization.RecordTime.tr] = '$dataTime';
    }
    return mapData;
  }
}
