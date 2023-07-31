import 'dart:convert';

class RecordField {
  static String recordId = "recordId"; // ID
  static String recordType = "recordType"; // 治疗方式
  static String pattern = "pattern"; // 模式
  static String power = "power"; // 功率
  static String soundIntensity = "soundIntensity"; // 声强
  static String frequency = "frequency"; // 频率
  static String dataTime = "dataTime"; // 时间
  static String utilityTime = "utilityTime"; // 时长



}

class Record {
  int? recordId;
  String? recordType;
  String? pattern;
  String? power;
  String? soundIntensity;
  String? frequency;
  String? dataTime;
  String? utilityTime;

  Record({
    this.recordId,
    this.recordType,
    this.pattern,
    this.power,
    this.soundIntensity,
    this.frequency,
    this.dataTime,
    this.utilityTime,
  });

  factory Record.fromJson(String str) => Record.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Record.fromMap(Map<String, dynamic> json) => Record(
        recordId: json[RecordField.recordId],
        recordType: json[RecordField.recordType],
        pattern: json[RecordField.pattern],
        power: json[RecordField.power],
        soundIntensity: json[RecordField.soundIntensity],
        frequency: json[RecordField.frequency],
        dataTime: json[RecordField.dataTime],
        utilityTime: json[RecordField.utilityTime],
      );

  Map<String, dynamic> toMap() => {
        RecordField.recordId: recordId,
        RecordField.recordType: recordType,
        RecordField.pattern: pattern,
        RecordField.power: power,
        RecordField.soundIntensity: soundIntensity,
        RecordField.frequency: frequency,
        RecordField.dataTime: dataTime,
        RecordField.utilityTime: utilityTime,
      };
}
