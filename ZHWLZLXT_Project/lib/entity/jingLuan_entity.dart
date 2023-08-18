import 'dart:convert';

class SpasticField {
  static String SpasticKey = "SpasticKey"; // 存储 -key
  static String userId = "userId";
  static String time = "time"; //时间
  static String circle = "circle";//周期
  static String widthA = "widthA";//脉宽 A
  static String widthB = "widthB";// 脉宽 B
  static String delayTime = "delayTime"; //延时时间
  static String powerA = "powerA";//强度 A
  static String powerB = "powerB";// 强度 B
}
class Spastic {
  int? userId;
  String? time;
  String? circle;
  String? widthA;
  String? widthB;
  String? delayTime;
  String? powerA;
  String? powerB;


  Spastic({
    this.userId,
    this.time,
    this.circle,
    this.widthA,
    this.widthB,
    this.delayTime,
    this.powerA,
    this.powerB,
  });

  factory Spastic.fromJson(String str) => Spastic.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Spastic.fromMap(Map<String, dynamic> json) => Spastic(
    userId: json[SpasticField.userId],
    time: json[SpasticField.time],
    circle: json[SpasticField.circle],
    widthA: json[SpasticField.widthA],
    widthB: json[SpasticField.widthB],
    delayTime: json[SpasticField.delayTime],
    powerA: json[SpasticField.powerA],
    powerB: json[SpasticField.powerB],
  );

  Map<String, dynamic> toMap() => {
    SpasticField.userId: userId,
    SpasticField.time: time,
    SpasticField.circle: circle,
    SpasticField.widthA: widthA,
    SpasticField.widthB: widthB,
    SpasticField.delayTime: delayTime,
    SpasticField.powerA: powerA,
    SpasticField.powerB: powerB,
  };

}







