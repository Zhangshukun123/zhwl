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

  bool isRun = false;

  void startTimer() {
    if (!isRun) {
      if(time!=null){
        time.cancel();
        time = null;
      }
      time = Timer.periodic(const Duration(seconds: 1), (timer) {
        count--;
        if (count < 0) {
          count.value = 0;
        }
        isRun = true;
        // ignore: unrelated_type_equality_checks
        if (count <= 0) {
          isRun = false;
          time.cancel();
        }
      });
    }
  }
  }
