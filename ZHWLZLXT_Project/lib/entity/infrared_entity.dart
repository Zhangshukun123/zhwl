import 'dart:convert';

class InfraredField {
  static String InfraredKey = "InfraredKey"; // 存储 -key
  static String userId = "userId";
  static String time = "time";//时间
  static String power = "power";//强度
  static String pattern = "pattern";//模式
}

class InfraredEntity {
  int? userId;
  String? time;
  String? power;
  String? pattern;


  InfraredEntity({
    this.userId,
    this.time,
    this.power,
    this.pattern,
  });

  factory InfraredEntity.fromJson(String str) => InfraredEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InfraredEntity.fromMap(Map<String, dynamic> json) => InfraredEntity(
    userId: json[InfraredField.userId],
    time: json[InfraredField.time],
    power: json[InfraredField.power],
    pattern: json[InfraredField.pattern],
  );

  Map<String, dynamic> toMap() => {
    InfraredField.userId: userId,
    InfraredField.time: time,
    InfraredField.power: power,
    InfraredField.pattern: pattern,
  };

}