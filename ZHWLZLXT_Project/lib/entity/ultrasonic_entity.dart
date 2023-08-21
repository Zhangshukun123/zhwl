import 'dart:convert';

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
  int? userId;
  String? pattern;
  String? time;
  String? power;
  String? soundIntensity;
  String? frequency;


  Ultrasonic({
    this.userId,
    this.pattern,
    this.time,
    this.power,
    this.soundIntensity,
    this.frequency,
  });

  factory Ultrasonic.fromJson(String str) => Ultrasonic.fromMap(json.decode(str));

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




}
