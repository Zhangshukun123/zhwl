import 'dart:async';

import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/Controller/ultrasonic_controller.dart';
import 'package:zhwlzlxt_project/base/globalization.dart';
import 'package:zhwlzlxt_project/entity/set_value_state.dart';
import 'package:zhwlzlxt_project/page/user_head_view.dart';
import 'package:zhwlzlxt_project/utils/event_bus.dart';
import 'package:zhwlzlxt_project/utils/sp_utils.dart';
import 'package:zhwlzlxt_project/utils/treatment_type.dart';
import 'package:zhwlzlxt_project/utils/utils_tool.dart';
import 'package:zhwlzlxt_project/widget/connect_port.dart';
import 'package:zhwlzlxt_project/widget/details_dialog.dart';
import 'package:zhwlzlxt_project/widget/set_value.dart';

import '../Controller/treatment_controller.dart';
import '../base/run_state_page.dart';
import '../entity/ultrasonic_entity.dart';
import '../entity/ultrasonic_sound.dart';
import '../utils/utils.dart';
import '../widget/container_bg.dart';
import '../widget/popup_menu_btn.dart';

class UltrasonicPage extends StatefulWidget {
  const UltrasonicPage({Key? key}) : super(key: key);

  @override
  State<UltrasonicPage> createState() => _UltrasonicPageState();
}

class _UltrasonicPageState extends State<UltrasonicPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final TreatmentController controller = Get.find();
  final UltrasonicController ultrasonicController = Get.find();

  Ultrasonic ultrasonic = Ultrasonic();
  DetailsDialog? dialog;

  // 运行 & 连接 & 温度状态
  bool isRunning = false;
  bool isConnected = false;
  bool tempOk = true;
  bool dialogVisible = false;

  // 频率/文案
  String frequencyText = '1'; // “1” 或 “3”
  String linkText = Globalization.unlink.tr;
  String tempText = Globalization.temperatureNormals.tr;

  // 计时
  Timer? _timer;
  int _countdown = 0;
  TabController? _dialogTabController;

  @override
  void initState() {
    super.initState();
    dialog = DetailsDialog(index: 1); // 1=超声
    _dialogTabController =
        TabController(length: dialog?.tabs.length ?? 0, vsync: this);
    dialog?.setTabController(_dialogTabController!);

    ultrasonic.init(false);
    ultrasonic.time = "20";
    _bindEventBus();
  }

  void _bindEventBus() {
    eventBus.on<TreatmentType>().listen((event) {
      if (!mounted) return;
      if (event == TreatmentType.ultrasonic) {
        ultrasonic.user = userMap[event];
      }
    });

    eventBus.on<Language>().listen((_) {
      ultrasonic.init(false);
      linkText =
          isConnected ? Globalization.onLine.tr : Globalization.unlink.tr;
      tempText = tempOk
          ? Globalization.temperatureNormals.tr
          : Globalization.temperatureAnomaly.tr;
      setState(() {});
    });

    eventBus.on<MethodCall>().listen(_onMethodCall);
  }

  void _onMethodCall(MethodCall call) {
    switch (call.method) {
      case 'UltrasonicState03':
      case 'UltrasonicState04':
        _handleDeviceFrame(toUnitList(call.arguments));
        break;
      case 'saponin': // 频扫
        ultrasonic.pattern = Globalization.Sweepfrequency.tr;
        ultrasonic.start(true, false, '${frequencyText}M');
        break;
      case 'open':
      case 'saveP':
        ultrasonic.start(true, false, '${frequencyText}M');
        break;
      case 'close':
        ultrasonic.start(false, false, '${frequencyText}M');
        break;
    }
  }

  void _handleDeviceFrame(Uint8List frame) {
    // 温度异常：frame[4]==16 且 frame[12]==1
    final tempError = frame[4] == 16 && frame[12] == 1;
    // 连接状态：frame[11]==1
    final connected = frame[11] == 1;

    if (tempError) {
      _onTemperatureAnomaly();
      return;
    }

    // 解析频率：某些帧类型代表3MHz（示例用 frame[4]==16），否则 1MHz
    if (connected) {
      final freq = (frame[4] == 16) ? "3" : "1";
      _updateConnection(true, freq);
    } else {
      _updateConnection(false, null);
    }

    setState(() {});
  }

  void _onTemperatureAnomaly() {
    tempOk = false;
    tempText = Globalization.temperatureAnomaly.tr;

    if (isRunning) _stopTreatment();

    if (!dialogVisible) {
      _showConnectPort(Globalization.temperatureAnomaly.tr);
    }
  }

  void _updateConnection(bool connected, String? freq) {
    isConnected = connected;
    linkText = connected ? Globalization.onLine.tr : Globalization.unlink.tr;

    if (connected && freq != null) {
      frequencyText = freq;
      ultrasonic.frequency = freq;
      unltrasonicPw = freq; // 兼容原有事件
      eventBus.fire(unltrasonicPw);
    }

    if (!connected && isRunning) {
      _stopTreatment();
    }
  }

  void _showConnectPort(String title) {
    ultrasonicController
      ..title.value = title
      ..context.value = ''
      ..count.value = 30;

    Future.delayed(const Duration(milliseconds: 300), () {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => ConnectPort(
          restConnect: (_) {
            Get.back();
            dialogVisible = false;
            tempOk = true;
            tempText = Globalization.temperatureNormals.tr;
            setState(() {});
          },
        ),
      );
      dialogVisible = true;
    });
  }

  void _toggleStart() {
    EasyThrottle.throttle('ultra-start', const Duration(seconds: 1), () {
      if (!isConnected && !isRunning) {
        showToastMsg(msg: Globalization.unlink.tr);
        return;
      }

      isRunning = !isRunning;

      if (!isRunning) {
        _stopTreatment();
        setState(() {});
        return;
      }

      ultrasonic.start(
        true, // 开
        true, // 保存参数
        '${frequencyText}M',
        back: _startTimer,
        finish: _finishTreatment,
      );
      setState(() {});
    });
  }

  void _startTimer() {
    final t = int.tryParse(ultrasonic.time ?? '20') ?? 20;
    _countdown = t;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (_countdown <= 0) {
        _finishTreatment();
        return;
      }
      _countdown--;
      ultrasonic.time = _countdown.toString();
      eventBus.fire(RunTime(_countdown.toDouble(), 1001));
    });

    // 首次回调同步一次 UI
    eventBus.fire(RunTime(_countdown.toDouble(), 1001));
  }

  void _stopTreatment() {
    _timer?.cancel();
    ultrasonic.init(true);
    ultrasonic.start(false, false, '${frequencyText}M'); // 关
    Future.delayed(const Duration(milliseconds: 500), () {
      eventBus.fire(SetValueState(TreatmentType.ultrasonic));
    });
    isRunning = false;
    cureState = false;
  }

  void _finishTreatment() {
    _stopTreatment();
    setState(() {});
    showToastMsg(msg: Globalization.endOfTreatment.tr);
  }

  void save(int userId) => SpUtils.set(UltrasonicField.UltrasonicKey, userId);

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ScreenUtil.init(context, designSize: const Size(960, 600));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFCFCFC),
      body: SafeArea(
        child: Column(
          children: [
            UserHeadView(type: TreatmentType.ultrasonic),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 11.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatusRow(),
                    _buildPowerRow(),
                    _buildTimeRow(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow() => SizedBox(
        height: 150.h,
        child: Row(
          children: [
            // 模式
            ContainerBg(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 120.w,
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: Image.asset('assets/images/2.0x/icon_moshi.png',
                          width: 16.w, fit: BoxFit.fitWidth),
                      label: Text(
                        Globalization.mode.tr,
                        style: TextStyle(
                            fontSize: 20.sp, color: const Color(0xFF999999)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PopupMenuBtn(
                    index: 0,
                    patternStr:
                        ultrasonic.pattern ?? Globalization.intermittentOne.tr,
                    enabled: !isRunning,
                    popupListener: (v) => ultrasonic.pattern = v,
                  ),
                ],
              ),
            ),
            SizedBox(width: 30.w),
            // 连接/频率/温度
            ContainerBg(
              padding: EdgeInsets.only(top: 40.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (isConnected)
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              frequencyText,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text('MHz',
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.red)),
                          ],
                        ),
                        const SizedBox(height: 22),
                        Text(Globalization.Hz.tr,
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: const Color(0xff666666))),
                      ],
                    ),
                  Column(
                    children: [
                      Image.asset(
                        isConnected
                            ? 'assets/images/icon_line.png'
                            : 'assets/images/icon_un_line.png',
                        width: 30.w,
                        height: 30.h,
                      ),
                      const SizedBox(height: 22),
                      Text(linkText,
                          style: TextStyle(
                              fontSize: 16.sp, color: const Color(0xff666666))),
                    ],
                  ),
                  if (isConnected)
                    Column(
                      children: [
                        Image.asset(
                          tempOk
                              ? 'assets/images/icon_wd_online.gif'
                              : 'assets/images/icon_wd_unline.gif',
                          width: 40.w,
                          height: 40.h,
                        ),
                        Text(tempText,
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: const Color(0xff666666))),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildPowerRow() => SizedBox(
        height: 150.h,
        child: Row(
          children: [
            // 输出功率
            ContainerBg(
              child: SetValue(
                enabled: isRunning,
                type: TreatmentType.ultrasonic,
                title: Globalization.pPower.tr,
                isEventBus: true,
                assets: 'assets/images/2.0x/icon_gonglv.png',
                initialValue: double.tryParse(ultrasonic.power ?? '0.0'),
                appreciation: 0.6,
                unit: 'W',
                maxValue: frequencyText == "1" ? 7.2 : 3,
                // 1MHz:0~7.2W(0.6步进)；3MHz:0~3W
                isInt: false,
                valueListener: (v) {
                  ultrasonic.power = v.toStringAsFixed(2);
                  final sound = (frequencyText == "1") ? v / 4 : v / 2;
                  ultrasonic.soundIntensity = sound.toStringAsFixed(2);
                  eventBus.fire(UltrasonicSound(sound));
                  if (isRunning) {
                    ultrasonic.start(true, false, '${frequencyText}M');
                  }
                },
              ),
            ),
            SizedBox(width: 30.w),
            // 有效声强（只读）
            ContainerBg(
              child: SetValue(
                enabled: false,
                isInt: false,
                isViImg: false,
                indexType: 1,
                type: TreatmentType.ultrasonic,
                isEventBus: true,
                IntFixed: 2,
                title: Globalization.pSoundIntensity.tr,
                assets: 'assets/images/2.0x/icon_shengqiang.png',
                initialValue:
                    double.tryParse(ultrasonic.soundIntensity ?? '0.0'),
                unit: 'W/cm²',
                valueListener: (v) =>
                    ultrasonic.soundIntensity = v.toStringAsFixed(2),
              ),
            ),
          ],
        ),
      );

  Widget _buildTimeRow() => SizedBox(
        height: 150.h,
        child: Row(
          children: [
            // 时间
            ContainerBg(
              child: SetValue(
                enabled: !isRunning,
                type: TreatmentType.ultrasonic,
                title: Globalization.time.tr,
                isClock: true,
                isAnimate: isRunning,
                assets: 'assets/images/2.0x/icon_shijian.png',
                initialValue: double.tryParse(ultrasonic.time ?? '20'),
                minValue: 1,
                maxValue: 30,
                indexType: 1001,
                unit: 'min',
                valueListener: (v) => ultrasonic.time = v.toString(),
              ),
            ),
            SizedBox(width: 30.w),
            // 详情 + 启停
            ContainerBg(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: (Get.locale?.countryCode == "CN") ? 78.w : 100.w,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/2.0x/img_xiangqing.png'),
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                      child: TextButton.icon(
                        onPressed: () => dialog?.showCustomDialog(context),
                        icon: Image.asset(
                          'assets/images/2.0x/icon_xiangqing.png',
                          width: 15.w,
                          fit: BoxFit.fitWidth,
                        ),
                        label: Text(
                          Globalization.details.tr,
                          style: TextStyle(
                              color: const Color(0xFF403B5B), fontSize: 15.sp),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isRunning)
                        Image.asset('assets/images/2.0x/hourglass_68.gif',
                            width: 34.w, height: 34.h),
                      Container(
                        width: 120.w,
                        height: 55.h,
                        margin: EdgeInsets.only(left: 10.w),
                        decoration: BoxDecoration(
                          color: isRunning
                              ? const Color(0xFF00C290)
                              : const Color(0xFF41B962),
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        child: TextButton(
                          onPressed: _toggleStart,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/2.0x/icon_kaishi.png',
                                  width: 18.w, fit: BoxFit.fitWidth,),
                              SizedBox(width: 8.w),
                              Text(
                                isRunning
                                    ? Globalization.stop.tr
                                    : Globalization.start.tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  @override
  bool get wantKeepAlive => true;
}
