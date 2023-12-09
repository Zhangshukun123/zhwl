import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../main.dart';

class DialogUtil {
  static void alert({
    String? title = 'title',
    String? message = 'message',
    String? okLabel,
  }) {
    showOkAlertDialog(
      context: navigatorKey.currentState!.overlay!.context,
      title: title,
      message: message,
      okLabel: okLabel,
      barrierDismissible: false,
    );
  }
}
