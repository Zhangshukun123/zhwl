import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/Controller/ultrasonic_controller.dart';

import '../base/globalization.dart';
import '../entity/ultrasonic_sound.dart';
import '../utils/event_bus.dart';

typedef PopupListener = void Function(String value);

// ignore: must_be_immutable
class PopupMenuBtn extends StatefulWidget {
  int? index = 0;
  Offset? offset;
  PopupListener? popupListener;
  String? patternStr = "1";
  String? unit = "";
  bool? enabled = true;

  PopupMenuBtn({
    Key? key,
    this.index,
    this.patternStr,
    this.offset,
    this.unit,
    this.popupListener,
    this.enabled,
  }) : super(key: key);

  @override
  State<PopupMenuBtn> createState() => _PopupMenuBtnState();
}

class _PopupMenuBtnState extends State<PopupMenuBtn> {
  List<PopupMenuEntry<String>> pop = [];
  StreamSubscription<Language>? _languageSubscription;

  final UltrasonicController controller = Get.find();
  var value = "0";

  @override
  void initState() {
    super.initState();
    pop = _getPopupMenu(context);
    value = widget.patternStr ?? '0';
    setState(() {});

    _languageSubscription = eventBus.on<Language>().listen((event) {
      if (!mounted) return;
      pop = _getPopupMenu(context);
      value = widget.patternStr ?? '0';
      setState(() {});
    });

  }

  @override
  void dispose() {
    _languageSubscription?.cancel();
    super.dispose();
  }

  bool get _compactEnglishMode =>
      widget.index == 5 && Get.locale?.languageCode == 'en';

  @override
  Widget build(BuildContext context) {
    // Rebuild the menu for current screen dimensions and language.
    pop = _getPopupMenu(context);
    return Container(
      margin: const EdgeInsets.only(left: 30),
      decoration: BoxDecoration(
          color: const Color(0xFFF4F4F4),
          borderRadius: BorderRadius.all(
            Radius.circular(10.w),
          )),
      width: 200.w,
      height: 50.h,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 100),
        child: PopupMenuButton<String>(
            offset: widget.offset ?? Offset(0, 57.h),
            itemBuilder: (BuildContext context) {
              return pop;
            },
            tooltip: widget.patternStr ?? '',
            enabled: widget.enabled!,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 20.0.w, right: 6.0.w),
                  // Keep the original button geometry; only constrain its text.
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          widget.patternStr ?? '0',
                          semanticsLabel: widget.patternStr ?? '0',
                          textAlign: TextAlign.center,
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: widget.enabled!
                                ? const Color(0xFF333333)
                                : Colors.grey,
                            fontSize: _compactEnglishMode ? 14.sp : 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (!TextUtil.isEmpty(widget.unit))
                        Text(widget.unit!,
                            style: TextStyle(fontSize: 12.sp, color: Colors.black)),
                    ],
                  ),
                )),
                Image.asset(
                  'assets/images/2.0x/icon_xiala.png',
                  width: 12.w,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  width: 15.w,
                )
              ],
            ),
            onSelected: (ovc) {
              setState(() {
                widget.patternStr = ovc;
              });
              if (widget.index == 1) {
                eventBus.fire(UltrasonicObs());
                if (widget.patternStr == "1") {
                  controller.ultrasonic.frequency.value = 1;
                } else {
                  controller.ultrasonic.frequency.value = 3;
                }
              }
              widget.popupListener!(widget.patternStr ?? "0");
            },
            onCanceled: () {
              print('cancel');
            }),
      ),
    );
  }

  List<PopupMenuEntry<String>> _getPopupMenu(BuildContext context) {
    switch (widget.index) {
      case 0:
        widget.unit = '';
        widget.offset = Offset(0, 57.h);
        return <PopupMenuEntry<String>>[
          _getPopupMenuItem(Globalization.continuous.tr),
          _getPopupMenuItem(Globalization.intermittentOne.tr),
          _getPopupMenuItem(Globalization.intermittentTwo.tr),
          _getPopupMenuItem(Globalization.intermittentThree.tr),
          // _getPopupMenuItem(Globalization.frequency.tr),
        ];
      case 1:
        widget.unit = "MHz";
        widget.offset = Offset(0, -60.h);
        return <PopupMenuEntry<String>>[
          _getPopupMenuItem('1'),
          _getPopupMenuItem('3'),
        ];
      case 2:
        widget.unit = '';
        widget.offset ??= Offset(0, -120.h);
        return <PopupMenuEntry<String>>[
          _getPopupMenuItem(Globalization.continuous.tr),
          _getPopupMenuItem(Globalization.intermittentOne.tr),
          _getPopupMenuItem(Globalization.intermittentTwo.tr),
          _getPopupMenuItem(Globalization.intermittentThree.tr),
        ];
      case 3:
        widget.unit = '';
        widget.offset = Offset(0, 57.h);
        return <PopupMenuEntry<String>>[
          _getPopupMenuItem(Globalization.continuous.tr),
          _getPopupMenuItem(Globalization.fast.tr),
          _getPopupMenuItem(Globalization.slow.tr),
        ];
      case 4:
        widget.unit = '模式';
        widget.offset = Offset(0, 57.h);
        return <PopupMenuEntry<String>>[
          _getPopupMenuItem('连续 0'),
          _getPopupMenuItem('连续 1'),
          _getPopupMenuItem('连续 2'),
        ];
      case 5:
        widget.offset = Offset(0, 57.h);
        return <PopupMenuEntry<String>>[
          _getPopupMenuItem(Globalization.complete.tr),
          _getPopupMenuItem(Globalization.partial.tr),
        ];
      case 6:
        widget.unit = '模式';
        widget.offset = Offset(0, 57.h);
        return <PopupMenuEntry<String>>[
          _getPopupMenuItem('连续 0'),
          _getPopupMenuItem('连续 1'),
          _getPopupMenuItem('连续 2'),
        ];
      case 7:
        var pop = <PopupMenuEntry<String>>[];
        for (var i = 0; i < 60; i++) {
          pop.add(_getPopupMenuItem((i + 1).toString()));
        }
        return pop;
      case 8:
        widget.offset = Offset(0, 57.h);
        return <PopupMenuEntry<String>>[
          _getPopupMenuItem('1'),
          _getPopupMenuItem('2'),
          _getPopupMenuItem('3'),
        ];
    }
    return [];
  }

  PopupMenuItem<String> _getPopupMenuItem(String value) {
    return PopupMenuItem<String>(
      value: value,
      child: SizedBox(
        width: 230.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.w, top: 5.h),
              child: Tooltip(
                message: value,
                child: Text(
                  value,
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: _compactEnglishMode ? 13.sp : 15.sp,
                    color: const Color(0xff333333),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Container(color: const Color(0xffeeeeee), height: 1.h),
          ],
        ),
      ),
    );
  }
}
