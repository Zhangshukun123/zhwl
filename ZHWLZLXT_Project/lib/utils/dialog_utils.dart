import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base/globalization.dart';
import '../main.dart';

typedef fut();


class DialogUtil {
  static void alert({
    String? title = 'title',
    String? message = 'message',
    String? okLabel,
    fut? fu
  }) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    // });

    Get.defaultDialog(
        title: Globalization.hint.tr,
        barrierDismissible:false,
        titlePadding: const EdgeInsets.only(top: 10,bottom: 10),
        titleStyle: const TextStyle(fontSize: 30),
        cancel: InkWell(
          onTap: (){
            Get.back();
            fu?.call();
          },
          child:  Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              Globalization.confirm.tr,
              style: const TextStyle(fontSize: 28),
            ),
          ),
        ),
        content:  Padding(
          padding: const EdgeInsets.only(top: 10,bottom: 10,right: 120,left: 120),
          child: Text(
            message??"",
            style: const TextStyle(fontSize: 30,color: Colors.red),
          ),
        ));
    // showOkAlertDialog(
    //   context: navigatorKey.currentState!.overlay!.context,
    //   title: title,
    //   message: message,
    //   okLabel: okLabel,
    //   barrierDismissible: false,
    // );
  }
}
