import 'dart:async';
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
import '../utils/event_bus.dart';
import '../utils/sp_utils.dart';
import '../utils/treatment_type.dart';
import '../widget/connect_port.dart';
import 'infrared_page.dart';

class FunctionPage extends StatefulWidget {
  const FunctionPage({Key? key}) : super(key: key);

  @override
  State<FunctionPage> createState() => _FunctionPageState();
}

class _FunctionPageState extends State<FunctionPage>
    with WidgetsBindingObserver {
  final PageController _pageController = PageController();
  final TreatmentController controller = Get.put(TreatmentController());
  final UltrasonicController ultrasonicController = Get.put(UltrasonicController());

  int curPosition = 0;
  bool isDialogVisible = false;
  DateTime? _lastTapTime;
  int secretTapCount = 0;

  late final List<Widget> _pages = const [
    UltrasonicPage(),
    PulsedPage(),
    InfraredPage(),
    ElectrotherapyPage(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initTreatment();
    _initSerial();
    _startHeartBeat();
    _initDAC();
  }

  /// 初始化治疗类型
  void _initTreatment() {
    controller.treatmentType.value = TreatmentType.ultrasonic;
    controller.setUserForType(TreatmentType.ultrasonic);
  }

  /// 初始化串口与平台通信
  void _initSerial() {
    SerialMsg().startPort();
    SerialMsg.platform.setMethodCallHandler(_onMethodCall);
  }

  /// 心跳包定时任务
  void _startHeartBeat() {
    Timer.periodic(const Duration(seconds: 1), (_) {
      SerialMsg().sendHeart();
    });
  }

  /// 初始化 DAC 设置
  Future<void> _initDAC() async {
    await Future.delayed(const Duration(seconds: 1));
    final isKDL = SpUtils.getBool("keyKDL", defaultValue: false) ?? false;
    final dac = isKDL
        ? "01 b3 00 00 01 00 00 00 00 00 00"
        : "01 b3 00 00 00 00 00 00 00 00 00";
    SerialPort().send(dac, false);
  }

  /// 处理平台消息
  Future<dynamic> _onMethodCall(MethodCall call) async {
    eventBus.fire(call);
    switch (call.method) {
      case 'onHeart':
        if (isDialogVisible) {
          Get.back();
          isDialogVisible = false;
        }
        break;
      case 'onHeartFail':
        if (!isDialogVisible) {
          // _showConnectDialog(Globalization.connection1.tr, Globalization.connection2.tr);
          isDialogVisible = true;
        }
        break;
    }
  }

  /// 弹出重新连接弹窗
  Future<void> _showConnectDialog(String title, String content) async {
    ultrasonicController
      ..title.value = title
      ..context.value = content
      ..count.value = 10;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: ConnectPort(
          restConnect: (v) => SerialMsg().startPort(),
        ),
      ),
    );
  }

  /// 生命周期监听
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      debugPrint("👉 App 回到前台");
    } else if (state == AppLifecycleState.paused) {
      debugPrint("👈 App 进入后台");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    super.dispose();
  }

  /// 隐藏调试入口（连点 logo 六次）
  Future<void> _onLogoTap() async {
    final now = DateTime.now();
    if (_lastTapTime == null || now.difference(_lastTapTime!) < const Duration(seconds: 5)) {
      secretTapCount++;
      if (secretTapCount >= 6) {
        final result = await promptText(context);
        if (result == "733") {
          secretTapCount = 0;
          await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          openAppSettings();
        }
      }
      _lastTapTime = now;
    }
  }

  /// 切换治疗页面并分发事件
  void _onPageChanged(int index) {
    curPosition = index;
    final type = [
      TreatmentType.ultrasonic,
      TreatmentType.pulsed,
      TreatmentType.infrared,
      TreatmentType.spasm
    ][index];

    controller.treatmentType.value = type;
    controller.setUserForType(type);
    eventBus.fire(type);

    // 电刺激页面的子模式特殊处理
    if (type == TreatmentType.spasm) {
      final tabIndex = tabController?.index ?? 0;
      final subTypes = [
        TreatmentType.spasm,
        TreatmentType.percutaneous,
        TreatmentType.neuromuscular,
        TreatmentType.frequency
      ];
      eventBus.fire(subTypes[tabIndex]);
    }

    setState(() {});
  }

  Widget _buildPageButton(String label, int index) {
    final selected = curPosition == index;
    return Container(
      width: 150.w,
      height: 60.h,
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF403B5B) : const Color(0xFFF0F4F9),
        borderRadius: BorderRadius.circular(30.w),
      ),
      child: TextButton(
        onPressed: () => _pageController.jumpToPage(index),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.white : const Color(0xFF403B5B),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Row(
          children: [
            // 左侧功能栏
            SizedBox(
              width: 180.w,
              child: Column(
                children: [
                  InkWell(
                    onTap: _onLogoTap,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.5.h),
                      child: Image.asset(
                        'assets/images/2.0x/function_logo.png',
                        width: 120.w,
                        height: 39.5.h,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildPageButton(Globalization.ultrasound.tr, 0),
                        _buildPageButton(Globalization.pulse.tr, 1),
                        _buildPageButton(Globalization.infrared.tr, 2),
                        _buildPageButton(Globalization.electricity.tr, 3),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 主体内容区
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: _onPageChanged,
                children: _pages,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
