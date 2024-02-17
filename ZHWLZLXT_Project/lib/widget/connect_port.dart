import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/Controller/ultrasonic_controller.dart';

import '../base/globalization.dart';

typedef RestConnect = Function(bool isBack);

// ignore: must_be_immutable
class ConnectPort extends Dialog {
  RestConnect? restConnect;
  final UltrasonicController controller = Get.find();

  ConnectPort({Key? key, this.restConnect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // controller.count.value = 10;
    controller.startTimer();

    return Center(
      child: Container(
        width: 800,
        height: 350,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Obx(() => Text(
                    '${Globalization.hint.tr}：${controller.title}',
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  )),
              Expanded(child: Center(child: Obx(() => ObsTxt()))),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ObsTxt() {
    if (controller.count.value  == 0) {
      restConnect?.call(false);
      controller.startTimer();
    }

    return Text(
      '${controller.context} ${Globalization.loading_1.tr}...  ${controller.count}s',
      style: const TextStyle(fontSize: 22, color: Color(0xff666666)),
    );
  }
}
