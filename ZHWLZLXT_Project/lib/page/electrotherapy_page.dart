import 'dart:typed_data';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:zhwlzlxt_project/base/globalization.dart';
import 'package:zhwlzlxt_project/entity/Electrotherapy.dart';
import 'package:zhwlzlxt_project/page/jingLuan_page.dart';
import 'package:zhwlzlxt_project/page/jingPi_page.dart';
import 'package:zhwlzlxt_project/page/shenJing_page.dart';
import 'package:zhwlzlxt_project/page/user_head_view.dart';
import 'package:zhwlzlxt_project/page/zhongPin_page.dart';
import 'package:zhwlzlxt_project/utils/event_bus.dart';
import 'package:zhwlzlxt_project/utils/treatment_type.dart';

import '../Controller/treatment_controller.dart';
import '../entity/ultrasonic_sound.dart';
import '../utils/dialog_utils.dart';
import '../utils/utils.dart';
import '../widget/custom_tabIndicator.dart';
import '../widget/details_dialog.dart';
import 'package:zhwlzlxt_project/widget/tabstwo.dart' as Cum;

class ElectrotherapyPage extends StatefulWidget {
  const ElectrotherapyPage({Key? key}) : super(key: key);

  @override
  State<ElectrotherapyPage> createState() => _ElectrotherapyPageState();
}

class _ElectrotherapyPageState extends State<ElectrotherapyPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final List<Widget> _pages = const [
    JingLuanPage(),
    JingPiPage(),
    ShenJingPage(),
    ZhongPinPage(),
  ];

  late TabController _tabController;
  TabController? _dialogTabController;
  DetailsDialog? _dialog;

  /// 当前电疗类型（随 Tab 变化）
  TreatmentType _type = TreatmentType.spasm;

  /// 弹窗只出现一次的防抖
  bool _isAlertShowing = false;

  /// 事件总线订阅，统一在 dispose 里销毁
  StreamSubscription? _langSub, _notifySub, _methodSub;

  final TreatmentController _controller = Get.find();

  List<String> _labels() => [
    Globalization.spasm.tr,
    Globalization.tens.tr,
    Globalization.muscle.tr,
    Globalization.medium.tr,
  ];

  /// 索引映射为具体治疗类型
  static const List<TreatmentType> _indexToType = <TreatmentType>[
    TreatmentType.spasm,
    TreatmentType.percutaneous,
    TreatmentType.neuromuscular,
    TreatmentType.frequency,
  ];

  @override
  void initState() {
    super.initState();

    _type = TreatmentType.spasm;
    _tabController = TabController(length: _pages.length, vsync: this)
      ..addListener(_onTabChanged);

    // 让其他页面能读到当前 TabController（沿用你的全局用法）
    tabController = _tabController;

    // 初始化详情弹窗（默认对应第 1 个电疗类型：索引+4）
    _setupDetailsDialog(indexForDialog: 4);

    // 设置初始治疗类型
    _controller.treatmentType.value = _type;
    _controller.setUserForType(_type);

    // 订阅语言变化：只需刷新文本
    _langSub = eventBus.on<Language>().listen((_) {
      if (mounted) setState(() {});
    });

    // 外部通知强制刷新（保持与你现有逻辑兼容）
    _notifySub = eventBus.on<Notify>().listen((_) {
      if (mounted) setState(() {});
    });

    // 串口帧处理（卡顿/异常）
    _methodSub = eventBus.on<MethodCall>().listen((methodCall) {
      if (methodCall.method != "Electrotherapy") return;

      final Uint8List list = toUnitList(methodCall.arguments);
      // 过滤：电疗功能（179），通道9或10，状态1或2 → 弹窗一次，并把通道广播出去
      if (list.length > 12 &&
          list[3] == 179 &&
          (list[4] == 9 || list[4] == 10) &&
          (list[12] == 1 || list[12] == 2)) {
        if (!_isAlertShowing) {
          _isAlertShowing = true;
          DialogUtil.alert(
            title: "",
            message: Globalization.kadu.tr,
            okLabel: "确定",
            fu: () => _isAlertShowing = false,
          );
          final e = Electrotherapy()..channel = list[4];
          eventBus.fire(e);
        }
      }
    });
  }

  void _onTabChanged() {
    // 动画进行中或正在电疗运行时禁止切换
    if (_tabController.indexIsChanging) return;
    final bool running = electrotherapyIsRunIng ?? false;
    if (running) {
      // 回退到上一个 index
      _tabController.animateTo(_tabController.previousIndex);
      return;
    }

    final idx = _tabController.index.clamp(0, _pages.length - 1);
    _type = _indexToType[idx];

    // 更新治疗类型
    _controller.treatmentType.value = _type;
    _controller.setUserForType(_type);
    eventBus.fire(_type);

    // 每次切换重建详情弹窗：你的 DetailsDialog 依赖 index+4
    _setupDetailsDialog(indexForDialog: idx + 4);

    setState(() {});
  }

  void _setupDetailsDialog({required int indexForDialog}) {
    _dialog = DetailsDialog(index: indexForDialog);
    _dialogTabController?.dispose();
    _dialogTabController =
        TabController(length: _dialog?.tabs.length ?? 0, vsync: this);
    _dialog?.setTabController(_dialogTabController!);
  }

  @override
  void dispose() {
    _langSub?.cancel();
    _notifySub?.cancel();
    _methodSub?.cancel();
    _dialogTabController?.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ScreenUtil.init(context, designSize: const Size(960, 600));

    final labels = _labels();

    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFC),
      body: SafeArea(
        child: Column(
          children: [
            UserHeadView(type: _type),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Center(
                          child: SizedBox(
                            height: 120,
                            child: Cum.TabBar(
                              controller: _tabController,
                              tabs: labels.map((e) => Tab(text: e)).toList(),
                              isScrollable: true,
                              labelColor: const Color(0xFF403B5B),
                              unselectedLabelColor: const Color(0xFF666666),
                              labelPadding: EdgeInsets.symmetric(horizontal: 25.w),
                              labelStyle: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                              unselectedLabelStyle:
                              const TextStyle(fontSize: 30),
                              indicatorColor: const Color(0xFF403B5B),
                              indicatorSize: Cum.TabBarIndicatorSize.label,
                              indicator: const CustomTabIndicator(
                                width: 100,
                                borderSide:
                                BorderSide(width: 5.0, color: Color(0xFF403B5B)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: (Get.locale?.countryCode == "CN") ? 88.w : 110.w,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/2.0x/img_xiangqing.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: TextButton.icon(
                          onPressed: () => _dialog?.showCustomDialog(context),
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
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      physics: (electrotherapyIsRunIng ?? false)
                          ? const NeverScrollableScrollPhysics()
                          : const AlwaysScrollableScrollPhysics(),
                      children: _pages,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
