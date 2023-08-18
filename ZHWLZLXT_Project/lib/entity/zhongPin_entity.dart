import 'dart:convert';

class MidFrequencyField {
  static String MidFrequencyKey = "MidFrequencyKey"; // 存储 -key
  static String userId = "userId";
  static String patternA = "patternA";//模式 A
  static String timeA = "timeA";// 时间 A
  static String powerA = "powerA";// 强度 A
  static String patternB = "patternB";//模式 B
  static String timeB = "timeB";// 时间 B
  static String powerB = "powerB";// 强度 B
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

  factory MidFrequency.fromJson(String str) => MidFrequency.fromMap(json.decode(str));

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
}