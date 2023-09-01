import 'dart:async';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../cofig/config.dart';
import '../entity/port_data.dart';

class SerialMsg {
  factory SerialMsg() => _instance;

  SerialMsg._internal();

  static final SerialMsg _instance = SerialMsg._internal();

  // _channel 是通道的实例，package_manager 是自定义的通道名称
  // ignore: unnecessary_const
  static const MethodChannel _channel = MethodChannel("serialMsg_manager");

  // 注：方法名install和invokeMethod中的参数install不是要一定相同，这里相同是为了方便一眼看出函数的功能
  Future<String> startPort() async {
    // sendData 调用方法的名称，com.example.zhwlzlxt_project 应用包名
    String res = await _channel.invokeMethod("startPort");
    print('-----startPort-------$res');

    return res;
  }

  Future<String> sendHeart() async {
    String res = await _channel.invokeMethod("heard");
    return res;
  }

  Future<String> sendData(String data) async {
    // sendData 调用方法的名称，com.example.zhwlzlxt_project 应用包名
    String buffer = '${PortData.FH} $data ${PortData.FE}';
    Fluttertoast.showToast(msg: '发送数据=$buffer');
    String res = await _channel.invokeMethod("sendData", buffer);
    // print('-----sendData-------$res');
    Future.delayed(const Duration(seconds: 1), () {
      Fluttertoast.showToast(msg: '返回数据=$res');
    });

    return res;
  }
}
