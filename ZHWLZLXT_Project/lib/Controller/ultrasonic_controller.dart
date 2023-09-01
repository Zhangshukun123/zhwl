import 'dart:async';

import 'package:get/get.dart';

class UltrasonicObs {
  var frequency = 1.obs; // 频率
}

class Infrared {}

class UltrasonicController extends GetxController {
  UltrasonicObs ultrasonic = UltrasonicObs();
  var count = 10.obs;

  // ignore: prefer_typing_uninitialized_variables
  var time;

  var title = ''.obs;
  var context = ''.obs;

  void startTimer() {
    count.value = 10;
    time = Timer.periodic(const Duration(seconds: 1), (timer) {
      count--;
      // ignore: unrelated_type_equality_checks
      if (count == 0) {
        time.cancel();
      }
    });
  }
}
