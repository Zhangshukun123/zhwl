import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';

class DialogUtil {
  static void alert({
    String? title = 'title',
    String? message = 'message',
    String? okLabel,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.defaultDialog(
          title: "提示",
          titlePadding: const EdgeInsets.only(top: 10,bottom: 10),
          titleStyle: const TextStyle(fontSize: 30),
          cancel: InkWell(
            onTap: (){
              Get.back();
            },
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "确定",
                style: TextStyle(fontSize: 28),
              ),
            ),
          ),
          content: const Padding(
            padding: EdgeInsets.only(top: 10,bottom: 10,right: 120,left: 120),
            child: Text(
              '检查到温度异常',
              style: TextStyle(fontSize: 30,color: Colors.red),
            ),
          ));
    });
    // showOkAlertDialog(
    //   context: navigatorKey.currentState!.overlay!.context,
    //   title: title,
    //   message: message,
    //   okLabel: okLabel,
    //   barrierDismissible: false,
    // );
  }
}
