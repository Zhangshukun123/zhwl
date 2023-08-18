import 'dart:convert';

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
}