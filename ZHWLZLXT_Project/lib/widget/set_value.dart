import 'dart:async';
import 'dart:ffi';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhwlzlxt_project/Controller/ultrasonic_controller.dart';

import '../utils/event_bus.dart';

typedef ValueListener = void Function(double value);

// ignore: must_be_immutable
class SetValue extends StatefulWidget {
  bool enabled = true;
  bool? isInt = true;
  bool? isEventBus = false;
  String? assets;
  String? title;
  String? unit;
  double? initialValue;
  double? minValue;
  double? maxValue;
  double? appreciation = 1;

  ValueListener? valueListener;

  SetValue({
    Key? key,
    required this.enabled,
    this.assets,
    this.title,
    this.unit,
    this.initialValue,
    this.valueListener,
    this.appreciation,
    this.isInt,
    this.isEventBus,
    this.minValue,
    this.maxValue,
  }) : super(key: key);

  @override
  State<SetValue> createState() => _SetValueState();
}

class _SetValueState extends State<SetValue> {
  double value = 0;
  double appreciation = 0;

  var timer;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue ?? 0;
    appreciation = widget.appreciation ?? 1;

    if (widget.isEventBus == true) {
      eventBus.on<Ultrasonic>().listen((event) {
        value = 0;
        if(!mounted){
          return;
        }
        setState(() {});
      });

      eventBus.on<Infrared>().listen((event) { //光疗强度 低功率 。
        value = 1;
        if(!mounted){
          return;
        }
        setState(() {});
      });


    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 29.h),
          width: 72.w,
          child: TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    widget.assets ?? 'assets/images/2.0x/icon_shijian.png',
                    fit: BoxFit.fitWidth,
                    width: 15.w,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    widget.title ?? '时间',
                    style: TextStyle(
                        fontSize: 16.sp, color: const Color(0xFF999999)),
                  ),
                ],
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (widget.enabled) {
                  if (value == 0) return;
                  value = (value - appreciation);
                  if (value <= (widget.minValue ?? 0)) {
                    value = (widget.minValue ?? 0);
                    widget.valueListener!(value);
                  }
                  setState(() {});
                }
              },
              onTapDown: (e) {
                timer = Timer.periodic(const Duration(milliseconds: 100), (e) {
                  if (widget.enabled) {
                    if (value == 0) return;
                    value = (value - appreciation);
                    if (value <= (widget.minValue ?? 0)) {
                      value = (widget.minValue ?? 0);
                      widget.valueListener!(value);
                    }
                    setState(() {});
                  }
                });
              },
              onTapUp: (e) {
                if (timer != null) {
                  timer.cancel();
                }
              },
              onTapCancel: () {
                if (timer != null) {
                  timer.cancel();
                }
              },
              child: Image.asset(
                widget.enabled
                    ? 'assets/images/btn_jian_nor.png'
                    : 'assets/images/2.0x/btn_jian_disabled.png',
                fit: BoxFit.fitWidth,
                width: 34.w,
                height: 34.h,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Container(
              width: 120.w,
              height: 55.h,
              decoration: const BoxDecoration(
                  color: Color(0xFFF0FAFE),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.isInt ?? true
                        ? value.toInt().toString()
                        : value.toStringAsFixed(1),
                    style: TextStyle(
                        color: const Color(0xFF333333), fontSize: 20.sp),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6.0.h, left: 2.w),
                    child: Text(
                      widget.unit ?? "",
                      style: TextStyle(
                          color: const Color(0xFF999999), fontSize: 12.sp),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            GestureDetector(
              onTap: () {
                if (widget.enabled) {
                  value = value + appreciation;
                  if (value > (widget.maxValue ?? 999999)) {
                    value = (widget.maxValue ?? 999999);
                    widget.valueListener!(value);
                  }
                  widget.valueListener!(value);
                  setState(() {});
                }
              },
              onTapDown: (e) {
                timer = Timer.periodic(const Duration(milliseconds: 100), (e) {
                  setState(() {
                    // todo  长按点击事件
                    if (widget.enabled) {
                      value = value + appreciation;
                      if (value > (widget.maxValue ?? 999999)) {
                        value = (widget.maxValue ?? 999999);
                        widget.valueListener!(value);
                      }
                      widget.valueListener!(value);
                      setState(() {});
                    }
                    print("object$value");
                  });
                });
              },
              onTapUp: (e) {
                if (timer != null) {
                  timer.cancel();
                }
              },
              onTapCancel: () {
                if (timer != null) {
                  timer.cancel();
                }
              },
              child: Image.asset(
                widget.enabled
                    ? 'assets/images/btn_jia_nor.png'
                    : 'assets/images/2.0x/btn_jia_disabled.png',
                fit: BoxFit.fitWidth,
                width: 34.w,
                height: 34.h,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
