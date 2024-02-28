import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:zhwlzlxt_project/entity/set_value_entity.dart';
import 'package:zhwlzlxt_project/widget/container_bg.dart';

import '../entity/set_value_state.dart';
import '../entity/ultrasonic_sound.dart';
import '../utils/event_bus.dart';
import '../utils/treatment_type.dart';

typedef ValueListener = void Function(double value);

// ignore: must_be_immutable
class SetValueHorizontal extends StatefulWidget {
  String? title;
  String? assets;
  bool? enabled = true;
  bool? isVisJa = true;
  bool? isInt = true;
  bool? isClock = false;
  bool? isAnimate = false;
  double? initialValue;
  double? width;
  String? unit;
  double? appreciation = 1;
  ValueListener? valueListener;
  double? height;
  double? minValue;
  int? indexType;
  double? maxValue;
  TreatmentType? type;

  SetValueHorizontal({
    Key? key,
    this.title,
    this.assets,
    this.enabled,
    this.isClock,
    this.isAnimate,
    this.initialValue,
    this.appreciation,
    this.isInt,
    this.height,
    this.indexType,
    this.valueListener,
    this.minValue,
    this.maxValue,
    this.width,
    this.isVisJa,
    this.type,
    this.unit,
  }) : super(key: key);

  @override
  State<SetValueHorizontal> createState() => _SetValueHorizontalState();
}

class _SetValueHorizontalState extends State<SetValueHorizontal> {
  double value = 0;
  double appreciation = 0;

  var timer;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue ?? 0;
    appreciation = widget.appreciation ?? 1;

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

    if (widget.indexType == 12 || widget.indexType == 13) {
      // 中频 时间
      eventBus.on<SetValueEntity>().listen((event) {
        if (widget.indexType == 12 && (event.value ?? 0) >= 0) {
          value = event.value ?? 0;
        }
        if (widget.indexType == 13 && (event.power ?? 0) >= 0) {
          value = event.power ?? 0;
        }
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
      if (widget.indexType == null) {
        return;
      }

      if (widget.indexType != event.intType) {
        return;
      }

      value = event.value ?? 0;
      widget.valueListener!(value);
      setState(() {});
    });

    eventBus.on<MC>().listen((event) {
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
    return ContainerBg(
        width: widget.width ?? 340.w,
        height: widget.height ?? 100.h,
        child: Row(
          children: [
            SizedBox(
              width: 20.w,
            ),
            Offstage(
              offstage: widget.title?.isEmpty ?? true,
              child: SizedBox(
                width: (Get.locale?.countryCode == "CN") ? 70.w : 100.w,
                child: TextButton(
                    onPressed: () {},
                    child: Row(children: [
                      (widget.isClock ?? false)
                          ? Lottie.asset('assets/lottie/clock.json',
                              repeat: true,
                              animate: widget.isAnimate,
                              width: 18.w,
                              fit: BoxFit.fitWidth)
                          : Image.asset(
                              widget.assets ??
                                  'assets/images/2.0x/icon_shijian.png',
                              fit: BoxFit.fitWidth,
                              width: 15.w,
                            ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text(
                          widget.title ?? "时间",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: const Color(0xFF999999), fontSize: 16.sp),
                        ),
                      ),
                    ])),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (widget.enabled ?? false) {
                  value = (value - appreciation);
                  if (value <= (widget.minValue ?? 0)) {
                    value = (widget.minValue ?? 0);
                  }
                  widget.valueListener!(value);
                  setState(() {});
                }
              },
              onTapDown: (e) {
                timer = Timer.periodic(const Duration(milliseconds: 200), (e) {
                  setState(() {
                    if (widget.enabled ?? false) {
                      value = (value - appreciation);
                      if (value <= (widget.minValue ?? 0)) {
                        value = (widget.minValue ?? 0);
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
                visible: widget.isVisJa ?? true,
                child: Image.asset(
                  widget.enabled == true && (value != widget.minValue)
                      ? 'assets/images/btn_jian_nor.png'
                      : 'assets/images/2.0x/btn_jian_disabled.png',
                  fit: BoxFit.fitWidth,
                  width: 30.w,
                  height: 30.h,
                ),
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Container(
              width: 120.w,
              height: 55.h,
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
                if (widget.enabled ?? false) {
                  value = value + appreciation;
                  if (value > (widget.maxValue ?? 999999)) {
                    value = (widget.maxValue ?? 999999);
                  }
                  widget.valueListener!(value);
                  setState(() {});
                }
              },
              onTapDown: (e) {
                timer = Timer.periodic(const Duration(milliseconds: 200), (e) {
                  setState(() {
                    if (widget.enabled ?? false) {
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
                visible: widget.isVisJa ?? true,
                child: Image.asset(
                  widget.enabled == true && (value != widget.maxValue)
                      ? 'assets/images/btn_jia_nor.png'
                      : 'assets/images/2.0x/btn_jia_disabled.png',
                  fit: BoxFit.fitWidth,
                  width: 30.w,
                  height: 30.h,
                ),
              ),
            ),
            // TextButton(
            //     onPressed: () {e
            //       if (widget.enabled ?? true) {
            //         value = (value - appreciation);
            //         if (value < 0) {
            //           value = 0;
            //           return;
            //         }
            //         widget.valueListener!(value);
            //         setState(() {});
            //       }
            //     },
            //     child: Image.asset(
            //       widget.enabled ?? true
            //           ? 'assets/images/2.0x/btn_jian_nor.png'
            //           : 'assets/images/2.0x/btn_jian_disabled.png',
            //       fit: BoxFit.fitWidth,
            //       width: 34.w,
            //       height: 34.w,
            //     )),
            // Container(
            //   width: 110.w,
            //   height: 55.h,
            //   decoration: const BoxDecoration(
            //       color: Color(0xFFF0FAFE),
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(10),
            //       )),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         widget.isInt ?? true
            //             ? value.toInt().toString()
            //             : value.toStringAsFixed(1),
            //         style: TextStyle(
            //             color: const Color(0xFF333333), fontSize: 22.sp),
            //       ),
            //       Padding(
            //         padding: EdgeInsets.only(top: 6.0.h, left: 2.w),
            //         child: Text(
            //           widget.unit ?? "",
            //           style: TextStyle(
            //               color: const Color(0xFF999999), fontSize: 12.sp),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // TextButton(
            //     onPressed: () {
            //       if (widget.enabled ?? true) {
            //         value = value + appreciation;
            //         if(value > 99){
            //           return;
            //         }
            //         widget.valueListener!(value);
            //         setState(() {});
            //       }
            //     },
            //     child: Image.asset(
            //       widget.enabled ?? true
            //           ? 'assets/images/2.0x/btn_jia_nor.png'
            //           : 'assets/images/2.0x/btn_jia_disabled.png',
            //       fit: BoxFit.fitWidth,
            //       width: 34.w,
            //       height: 34.w,
            //     )),
          ],
        ));
  }
}
