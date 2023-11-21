import 'dart:async';
import 'dart:ffi';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zhwlzlxt_project/Controller/ultrasonic_controller.dart';
import 'package:zhwlzlxt_project/entity/set_value_state.dart';
import 'package:zhwlzlxt_project/entity/ultrasonic_sound.dart';
import 'package:zhwlzlxt_project/utils/treatment_type.dart';

import '../utils/event_bus.dart';

typedef ValueListener = void Function(double value);

// ignore: must_be_immutable
class SetValue extends StatefulWidget {
  bool enabled = true;
  bool? isInt = true;
  bool? isEventBus = true;
  bool? isViImg = true;
  bool? isClock = false;
  bool? isAnimate = false;
  String? assets;
  String? title;
  String? unit;
  double? initialValue;
  double? minValue;
  double? maxValue;
  int? indexType;
  int? IntFixed = 1;
  double? appreciation = 1;
  TreatmentType? type;
  ValueListener? valueListener;

  SetValue({
    Key? key,
    required this.enabled,
    this.assets,
    this.isClock,
    this.title,
    this.unit,
    this.type,
    this.isAnimate,
    this.IntFixed,
    this.indexType,
    this.initialValue,
    this.valueListener,
    this.appreciation,
    this.isInt,
    this.isEventBus,
    this.minValue,
    this.isViImg,
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
      eventBus.on<UltrasonicObs>().listen((event) {
        value = 0;
        if (!mounted) {
          return;
        }
        widget.valueListener!(value);
        setState(() {});
      });
    }

    eventBus.on<SetValueState>().listen((event) {
      if (event.type != widget.type) {
        return;
      }
      value = widget.initialValue ?? 0;
      if (!mounted) {
        return;
      }
      setState(() {});
    });

    if (widget.indexType == 1) {
      // 超声声强
      eventBus.on<UltrasonicSound>().listen((event) {
        value = event.value ?? 0;
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    }
    eventBus.on<RunTime>().listen((event) {
      if (!mounted) {
        return;
      }
      if (widget.indexType != event.intType) {
        return;
      }
      value = event.value ?? 0;
      widget.valueListener!(value);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10.h),
          width: (Get.locale?.countryCode == "CN") ? 180.w : 220.w,
          child: TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (widget.isClock ?? false)
                      ? Lottie.asset('assets/lottie/clock.json',
                      repeat: true,
                      animate: widget.isAnimate,
                      width: 24.w,
                      height: 24.h,
                      fit: BoxFit.fitWidth)
                      : Image.asset(
                    widget.assets ??
                        'assets/images/2.0x/icon_shijian.png',
                    fit: BoxFit.fitWidth,
                    width: 24.w,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    widget.title ?? '时间',
                    style: TextStyle(
                        fontSize: 24.sp, color: const Color(0xFF999999)),
                  ),
                ],
              )),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.enabled) {
                    if (value == 0) return;
                    value = (value - appreciation);
                    if (value <= (widget.minValue ?? 0)) {
                      value = (widget.minValue ?? 0);
                    }
                    widget.valueListener!(value);
                    setState(() {});
                  }
                },
                onTapDown: (e) {
                  timer = Timer.periodic(const Duration(milliseconds: 300), (e) {
                    if (widget.enabled) {
                      if (value == 0) return;
                      value = (value - appreciation);
                      if (value <= (widget.minValue ?? 0)) {
                        value = (widget.minValue ?? 0);
                      }
                      widget.valueListener!(value);
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
                child: Visibility(
                  visible: widget.isViImg ?? true,
                  child: Image.asset(
                    widget.enabled
                        ? 'assets/images/btn_jian_nor.png'
                        : 'assets/images/2.0x/btn_jian_disabled.png',
                    fit: BoxFit.fitWidth,
                    width: 34.w,
                    height: 34.h,
                  ),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Container(
                width: 180.w,
                height: 60.h,
                decoration: const BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.isInt ?? true
                          ? value.toInt().toString()
                          : value.toStringAsFixed(widget.IntFixed ?? 1),
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
                    }
                    widget.valueListener!(value);
                    setState(() {});
                  }
                },
                onTapDown: (e) {
                  timer = Timer.periodic(const Duration(milliseconds: 300), (e) {
                    setState(() {
                      // todo  长按点击事件
                      if (widget.enabled) {
                        value = value + appreciation;
                        if (value > (widget.maxValue ?? 999999)) {
                          value = (widget.maxValue ?? 999999);
                        }
                        widget.valueListener!(value);
                        setState(() {});
                      }
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
                child: Visibility(
                  visible: widget.isViImg ?? true,
                  child: Image.asset(
                    widget.enabled
                        ? 'assets/images/btn_jia_nor.png'
                        : 'assets/images/2.0x/btn_jia_disabled.png',
                    fit: BoxFit.fitWidth,
                    width: 34.w,
                    height: 34.h,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}