import 'package:common_utils/common_utils.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/Controller/ultrasonic_controller.dart';

import '../utils/event_bus.dart';

typedef PopupListener = void Function(String value);

// ignore: must_be_immutable
class PopupMenuBtn extends StatefulWidget {
  int? index = 0;
  Offset? offset;
  PopupListener? popupListener;
  String? patternStr = "1";
  String? unit = "";

  PopupMenuBtn({
    Key? key,
    this.index,
    this.patternStr,
    this.offset,
    this.unit,
    this.popupListener,
  }) : super(key: key);

  @override
  State<PopupMenuBtn> createState() => _PopupMenuBtnState();
}

class _PopupMenuBtnState extends State<PopupMenuBtn> {
  var pop;

  final UltrasonicController controller = Get.find();
  var value = "0";

  @override
  void initState() {
    super.initState();
    pop = _getPopupMenu(context);
    value = widget.patternStr ?? '0';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFFF0FAFE),
            borderRadius: BorderRadius.all(
              Radius.circular(10.w),
            )),
        width: 230.w,
        height: 55.h,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 100.0),
          child: PopupMenuButton(
              offset: widget.offset ?? Offset(0, 57.h),
              itemBuilder: (BuildContext context) {
                return pop;
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: 30.0.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          value,
                          style: TextStyle(
                              color: const Color(0xFF333333),
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        Container(
                          child: !TextUtil.isEmpty(widget.unit)
                              ? Text(
                                  widget.unit!,
                                  style: TextStyle(
                                      fontSize: 10.sp, color: Colors.black),
                                )
                              : const Text(''),
                        ),
                      ],
                    ),
                  )),
                  Image.asset(
                    'assets/images/2.0x/icon_xiala.png',
                    width: 16.w,
                  ),
                  SizedBox(
                    width: 15.w,
                  )
                ],
              ),
              onSelected: (ovc) {
                setState(() {
                  value = (ovc as String);
                });
                if (widget.index == 1) {
                  eventBus.fire(Ultrasonic());
                  if (value == "1") {
                    controller.ultrasonic.frequency.value = 1;
                  } else {
                    controller.ultrasonic.frequency.value = 3;
                  }
                  widget.popupListener!(value);
                }

                if (widget.index == 2) {
                  if (value == "连续模式1") {
                    widget.popupListener!('01');
                  }
                  if (value == "断续模式1") {
                    widget.popupListener!('02');
                  }
                  if (value == "断续模式2") {
                    widget.popupListener!('03');
                  }
                  if (value == "断续模式3") {
                    widget.popupListener!('04');
                  }
                }

                if (ovc == "连续 0") {
                } else if (ovc == "连续 1") {
                } else if (ovc == "连续 2") {}
              },
              onCanceled: () {
                print('cancel');
              }),
        ),
      ),
    );
  }

  _getPopupMenu(BuildContext context) {
    switch (widget.index) {
      case 0:
        widget.unit = '';
        widget.offset = Offset(0, 57.h);
        return <PopupMenuEntry<String>>[
          _getPopupMenuItem('连续模式1'),
          _getPopupMenuItem('断续模式1'),
          _getPopupMenuItem('断续模式2'),
          _getPopupMenuItem('断续模式3'),
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
        widget.offset = Offset(0, -120.h);
        return <PopupMenuEntry<String>>[
          _getPopupMenuItem('连续模式1'),
          _getPopupMenuItem('断续模式1'),
          _getPopupMenuItem('断续模式2'),
          _getPopupMenuItem('断续模式3'),
        ];
      case 3:
        widget.unit = '';
        widget.patternStr = '连续输出';
        widget.offset = Offset(0, 57.h);
        return <PopupMenuEntry<String>>[
          _getPopupMenuItem('连续输出'),
          _getPopupMenuItem('慢速输出'),
          _getPopupMenuItem('快速输出'),
        ];
      case 4:
        widget.unit = '模式';
        widget.patternStr = '连续 0';
        widget.offset = Offset(0, 57.h);
        return <PopupMenuEntry<String>>[
          _getPopupMenuItem('连续 0'),
          _getPopupMenuItem('连续 1'),
          _getPopupMenuItem('连续 2'),
        ];
      case 5:
        widget.patternStr = '完全失神经';
        widget.offset = Offset(0, 57.h);
        return <PopupMenuEntry<String>>[
          _getPopupMenuItem('完全失神经'),
          _getPopupMenuItem('部分失神经'),
        ];
      case 6:
        widget.unit = '模式';
        widget.patternStr = '连续 0';
        widget.offset = Offset(0, 57.h);
        return <PopupMenuEntry<String>>[
          _getPopupMenuItem('连续 0'),
          _getPopupMenuItem('连续 1'),
          _getPopupMenuItem('连续 2'),
        ];
      case 7:
        widget.patternStr = '1';
        widget.offset = Offset(0, 57.h);
        var pop = <PopupMenuEntry<String>>[];
        for (var i = 0; i < 60; i++) {
          pop.add(_getPopupMenuItem((i + 1).toString()));
        }
        return pop;
      case 8:
        widget.patternStr = '1';
        widget.offset = Offset(0, 57.h);
        return <PopupMenuEntry<String>>[
          _getPopupMenuItem('1'),
          _getPopupMenuItem('2'),
          _getPopupMenuItem('3'),
        ];
    }
  }

  _getPopupMenuItem(String value) {
    return PopupMenuItem(
      value: value,
      child: SizedBox(
          width: 230.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.0.w, top: 5.h),
                child: Text(
                  value,
                  style: TextStyle(
                      fontSize: 15.sp, color: const Color(0xff333333)),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                color: const Color(0xffeeeeee),
                height: 1.h,
              )
            ],
          )),
    );
  }
}
