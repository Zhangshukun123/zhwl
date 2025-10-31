import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zhwlzlxt_project/base/globalization.dart';
import 'package:zhwlzlxt_project/page/electrotherapy_page.dart';
import 'package:zhwlzlxt_project/page/pulsed_page.dart';
import 'package:zhwlzlxt_project/page/show_dialog.dart';
import 'package:zhwlzlxt_project/page/ultrasonic_page.dart';

import '../Controller/serial_msg.dart';
import '../Controller/serial_port.dart';
import '../Controller/treatment_controller.dart';
import '../Controller/ultrasonic_controller.dart';
import '../cofig/config.dart';
import '../utils/event_bus.dart';
import '../utils/sp_utils.dart';
import '../utils/treatment_type.dart';
import '../widget/connect_port.dart';
import 'control_page.dart';
import 'infrared_page.dart';

class FunctionPage extends StatefulWidget {
  const FunctionPage({Key? key}) : super(key: key);

  @override
  State<FunctionPage> createState() => _FunctionPageState();
}

class _FunctionPageState extends State<FunctionPage>  with WidgetsBindingObserver{
  int curPosition = 0;
  final PageController _pageController = PageController();
  final TreatmentController controller = Get.put(TreatmentController());
  final UltrasonicController ultrasonicController =
      Get.put(UltrasonicController());
  List<Widget> pageView = [
    const UltrasonicPage(),
    const PulsedPage(),
    const InfraredPage(),
    const ElectrotherapyPage(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    controller.treatmentType.value = TreatmentType.ultrasonic;
    controller.setUserForType(TreatmentType.ultrasonic);

    // eventBus.on<UserEvent>().listen((event) {
    //   controller.setUserForType(event.type);
    // });
    Future.delayed(Duration.zero, () {
      SerialMsg().startPort();
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      SerialMsg().sendHeart().then((value) => {});
    });
    SerialMsg.platform.setMethodCallHandler(flutterMethod);

    Future.delayed(const Duration(seconds: 1), () {
      var kdl =  SpUtils.getBool("keyKDL",defaultValue: false);
      if(kdl!){
        var dac = "01 b3 00 00 01 00 00 00 00 00 00";
        SerialPort().send(dac, false);
      }else{
        var dac = "01 b3 00 00 00 00 00 00 00 00 00";
        SerialPort().send(dac, false);
      }
    });

  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      print("切换到了前台");
    } else if (state == AppLifecycleState.paused) {
      print("切换到了后台");
      // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  bool isShow = false;
  Future<dynamic> flutterMethod(MethodCall methodCall) async {
    eventBus.fire(methodCall);
    switch (methodCall.method) {
      case 'onHeart':
        if (isShow) {
          Get.back();
        }
        isShow = false;
        break;
      case 'onHeartFail':
        if (!isShow) {
          // showConnectPort(Globalization.connection1.tr, Globalization.connection2.tr);
        }
        isShow = true;
        break;
    }
  }


  showConnectPort(title, con) async {
    ultrasonicController.title.value = title;
    ultrasonicController.context.value = con;
    ultrasonicController.count.value = 10;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async{
              return false;
            },
            child: ConnectPort(
              restConnect: (value) {
                if (value) {}
                SerialMsg().startPort().then((value) => {});
              },
            ),
          );
        });
  }

  DateTime? _lastTime; //上次点击时间

  int ocIndex = 0;

  @override
  Widget build(BuildContext context) {
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Row(
          children: [
            Container(
              width: 180.w,
              color: const Color(0xFF00A8E7),
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      if (_lastTime == null || DateTime.now().difference(_lastTime!) < const Duration(seconds: 5)) {
                        ocIndex++;
                        if (ocIndex >= 6) {
                          final result = await promptText(context);
                          if (result != null&&result=="733") {
                            ocIndex = 0;
                            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                            openAppSettings();
                          }
                        }
                        _lastTime = DateTime.now();
                      }
                    },
                    child: Visibility(
                      visible: true,
                      child: Container(
                          margin: EdgeInsets.only(
                            top: 12.5.h,
                          ),
                          child: Image.asset(
                            'assets/images/2.0x/function_logo.png',
                            fit: BoxFit.fitWidth,
                            width: 140.w,
                            height: 39.5.h,
                          )),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        pageButton(Globalization.ultrasound.tr, 0),
                        pageButton(Globalization.pulse.tr, 1),
                        pageButton(Globalization.infrared.tr, 2),
                        pageButton(Globalization.electricity.tr, 3),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 180.w,
              height: MediaQuery.of(context).size.height,
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                //上下滚动
                onPageChanged: (int index) {
                  curPosition = index;
                  if (index == 0) {
                    controller.treatmentType.value = TreatmentType.ultrasonic;
                    controller.setUserForType(TreatmentType.ultrasonic);
                    eventBus.fire(TreatmentType.ultrasonic);
                  }
                  if (index == 1) {
                    controller.treatmentType.value = TreatmentType.pulsed;
                    controller.setUserForType(TreatmentType.pulsed);
                    eventBus.fire(TreatmentType.pulsed);
                  }
                  if (index == 2) {
                    controller.treatmentType.value = TreatmentType.infrared;
                    controller.setUserForType(TreatmentType.infrared);
                    eventBus.fire(TreatmentType.infrared);
                  }
                  if (index == 3) {
                    controller.treatmentType.value = TreatmentType.spasm;
                    controller.setUserForType(TreatmentType.spasm);
                    int index = tabController?.index ?? 0;
                    if (index == 0) {
                      eventBus.fire(TreatmentType.spasm);
                    }
                    if (index == 1) {
                      eventBus.fire(TreatmentType.percutaneous);
                    }
                    if (index == 2) {
                      eventBus.fire(TreatmentType.neuromuscular);
                    }
                    if (index == 3) {
                      eventBus.fire(TreatmentType.frequency);
                    }
                  }
                  setState(() {});
                },
                children: pageView,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pageButton(String txt, int index) {
    return Container(
      width: 150.w,
      height: 60.h,
      decoration: BoxDecoration(
          color: curPosition == index
              ? const Color(0XFFFFFFFF)
              : const Color(0xFF19B1E9),
          borderRadius: BorderRadius.all(
            Radius.circular(30.w),
          )),
      child: TextButton(
          onPressed: () {
            _pageController.jumpToPage(index);
          },
          child: Text(
            txt,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: curPosition == index
                    ? const Color(0xFF00A8E7)
                    : const Color(0xFFFFFFFF)),
          )),
    );
  }
}
