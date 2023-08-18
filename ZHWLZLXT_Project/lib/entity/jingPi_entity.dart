import 'dart:convert';

class PercutaneousField {
  static String PercutaneousKey = "PercutaneousKey"; // 存储 -key
  static String userId = "userId";
  static String patternA = "patternA";//模式 A
  static String timeA = "timeA";// 时间 A
  static String powerA = "powerA";// 强度 A
  static String frequencyA = "frequencyA";// 频率 A
  static String pulseA = "pulseA";// 脉宽 A
  static String patternB = "patternB";//模式 B
  static String timeB = "timeB";// 时间 B
  static String powerB = "powerB";// 强度 B
  static String frequencyB = "frequencyB";// 频率 B
  static String pulseB = "pulseB";// 脉宽 B
}

class Percutaneous {
  int? userId;
  String? patternA;
  String? timeA;
  String? powerA;
  String? frequencyA;
  String? pulseA;
  String? patternB;
  String? timeB;
  String? powerB;
  String? frequencyB;
  String? pulseB;


  Percutaneous({
    this.userId,
    this.patternA,
    this.timeA,
    this.powerA,
    this.frequencyA,
    this.pulseA,
    this.patternB,
    this.timeB,
    this.powerB,
    this.frequencyB,
    this.pulseB,
  });

  factory Percutaneous.fromJson(String str) => Percutaneous.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Percutaneous.fromMap(Map<String, dynamic> json) => Percutaneous(
    userId: json[PercutaneousField.userId],
    patternA: json[PercutaneousField.patternA],
    timeA: json[PercutaneousField.timeA],
    powerA: json[PercutaneousField.powerA],
    frequencyA: json[PercutaneousField.frequencyA],
    pulseA: json[PercutaneousField.pulseA],
    patternB: json[PercutaneousField.patternB],
    timeB: json[PercutaneousField.timeB],
    powerB: json[PercutaneousField.powerB],
    frequencyB: json[PercutaneousField.frequencyB],
    pulseB: json[PercutaneousField.pulseB],
  );

  Map<String, dynamic> toMap() => {
    PercutaneousField.userId: userId,
    PercutaneousField.patternA: patternA,
    PercutaneousField.timeA: timeA,
    PercutaneousField.powerA: powerA,
    PercutaneousField.frequencyA: frequencyA,
    PercutaneousField.pulseA: pulseA,
    PercutaneousField.patternB: patternB,
    PercutaneousField.timeB: timeB,
    PercutaneousField.powerB: powerB,
    PercutaneousField.frequencyB: frequencyB,
    PercutaneousField.pulseB: pulseB,
  };
}