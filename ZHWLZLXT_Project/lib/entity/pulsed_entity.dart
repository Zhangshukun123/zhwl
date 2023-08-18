import 'dart:convert';

class PulsedField {
  static String PulsedKey = "PulsedKey"; // 存储 -key
  static String userId = "userId";
  static String power = "power";//强度
  static String frequency = "frequency";//频率
  static String time = "time";//时间
}

class Pulsed {
  int? userId;
  String? time;
  String? power;
  String? frequency;


  Pulsed({
    this.userId,
    this.time,
    this.power,
    this.frequency,
  });

  factory Pulsed.fromJson(String str) => Pulsed.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pulsed.fromMap(Map<String, dynamic> json) => Pulsed(
    userId: json[PulsedField.userId],
    time: json[PulsedField.time],
    power: json[PulsedField.power],
    frequency: json[PulsedField.frequency],
  );

  Map<String, dynamic> toMap() => {
    PulsedField.userId: userId,
    PulsedField.time: time,
    PulsedField.power: power,
    PulsedField.frequency: frequency,
  };

}