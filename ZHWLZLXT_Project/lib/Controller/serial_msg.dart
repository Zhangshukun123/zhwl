import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../cofig/config.dart';
import '../entity/port_data.dart';

class SerialMsg {

  static const platform = MethodChannel('toFlutter');


  factory SerialMsg() {
    return _instance;
  }

  SerialMsg._internal();

  static final SerialMsg _instance = SerialMsg._internal();


  Future init() async {
    print("----------onPortDataReceived------");

  }



  // _channel 是通道的实例，package_manager 是自定义的通道名称
  // ignore: unnecessary_const
  static const MethodChannel _channel = MethodChannel("serialMsg_manager");

  // 注：方法名install和invokeMethod中的参数install不是要一定相同，这里相同是为了方便一眼看出函数的功能
  Future<String> startPort() async {
    // sendData 调用方法的名称，com.example.zhwlzlxt_project 应用包名
    // String res = await _channel.invokeMethod("startPort");
    return "res";
  }

  Future<String> sendHeart() async {
    String res = await _channel.invokeMethod("heard");
    return res;
  }

  Future<String> sendData(String data) async {
    // sendData 调用方法的名称，com.example.zhwlzlxt_project 应用包名
    String buffer = '${PortData.FH} $data';
    print("-----sendData----$buffer");

    Fluttertoast.showToast(
        msg: '发送数据=$buffer', fontSize: 22, backgroundColor: Colors.blue);
    // String res = await _channel.invokeMethod("sendData", buffer);
    // print('-----sendData-------$res');


    return "res";
  }
}
