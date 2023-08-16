import 'dart:convert';

import 'package:zhwlzlxt_project/utils/treatment_type.dart';

class UserTableField {
  static String userId = "userId";
  static String userName = 'userName';
  static String account = "account";
  static String pssWord = 'pssWord';
  static String age = 'age';
  static String userNub = 'userNub';
  static String sex = 'sex';
  static String phone = 'phone';
  static String idCard = 'idCard';
  static String ad = 'ad';
  static String bedNumber = 'bedNumber';
}

class User {
  int? userId;
  String? userName;
  String? userNum;
  String? account;
  String? pssWord;
  bool? isChoose;
  int? age;
  String? userNub;
  int? sex;
  String? phone;
  String? idCard;
  String? ad; // 住院号
  String? bedNumber; //床号

  User({
    this.userId,
    this.userName,
    this.isChoose,
    this.account,
    this.pssWord,
    this.age,
    this.userNub,
    this.sex,
    this.phone,
    this.idCard,
    this.ad,
    this.bedNumber,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        userId: json[UserTableField.userId],
        userName: json[UserTableField.userName],
        account: json[UserTableField.account],
        pssWord: json[UserTableField.pssWord],
        age: json[UserTableField.age],
        userNub: json[UserTableField.userNub],
        sex: json[UserTableField.sex],
        phone: json[UserTableField.phone],
        idCard: json[UserTableField.idCard],
        ad: json[UserTableField.ad],
        bedNumber: json[UserTableField.bedNumber],
      );

  Map<String, dynamic> toMap() => {
        UserTableField.userId: userId,
        UserTableField.userName: userName,
        UserTableField.account: account,
        UserTableField.pssWord: pssWord,
        UserTableField.age: age,
        UserTableField.userNub: userNub,
        UserTableField.sex: sex,
        UserTableField.phone: phone,
        UserTableField.idCard: idCard,
        UserTableField.ad: ad,
        UserTableField.bedNumber: bedNumber,
      };
}
