import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/Controller/serial_msg.dart';
import 'package:zhwlzlxt_project/utils/utils_tool.dart';

import '../base/globalization.dart';

typedef sendSuccessBack();
typedef sendFinish();

class SerialPort {
  factory SerialPort() => _instance;

  SerialPort._internal();

  static final SerialPort _instance = SerialPort._internal();

  void send(String data, bool isStart,
      {sendSuccessBack? back, sendFinish? finish}) {

    print("----sendSuccessBack-------$data");

    if(back!=null){
      SerialMsg().sendData(data).then((value) {
        if (value == "success") {
          back.call();
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }
        }
        if (value == "fail") {
          if (isStart) {
            if (!EasyLoading.isShow) {
              EasyLoading.instance.userInteractions = false;
              EasyLoading.show(dismissOnTap: false);
            }
          }
          send(data, isStart, back: back, finish: finish);
        }
        if (value == "finish") {
          if (isStart) {
            EasyLoading.dismiss();
            showToastMsg(msg: Globalization.hint_021.tr);
          }
          finish?.call();
        }
      });
    }else{
      SerialMsg().sendHData(data);
    }
  }
}
