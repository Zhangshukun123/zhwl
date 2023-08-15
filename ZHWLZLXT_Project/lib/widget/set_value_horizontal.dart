import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhwlzlxt_project/widget/container_bg.dart';

typedef ValueListener = void Function(double value);

// ignore: must_be_immutable
class SetValueHorizontal extends StatefulWidget {
  String? title;
  String? assets;
  bool? enabled = true;
  bool? isInt = true;
  double? initialValue;
  String? unit;
  double? appreciation = 1;
  ValueListener? valueListener;
  double? height;
  double? minValue;
  double? maxValue;

  SetValueHorizontal(
      {Key? key,
      this.title,
      this.assets,
      this.enabled,
      this.initialValue,
      this.appreciation,
      this.isInt,
      this.height,
      this.valueListener,
      this.minValue,
      this.maxValue,
      this.unit})
      : super(key: key);

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
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBg(
        width: 340.w,
        height: widget.height ?? 100.h,
        child: Row(
          children: [
            SizedBox(
              width: 20.w,
            ),
            SizedBox(
              width: 70.w,
              child: TextButton(
                  onPressed: () {},
                  child: Row(children: [
                    Image.asset(
                      widget.assets ?? 'assets/images/2.0x/icon_shijian.png',
                      fit: BoxFit.fitWidth,
                      width: 16.w,
                      height: 16.w,
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
            GestureDetector(
              onTap: () {
                if (widget.enabled == true) {
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
                  setState(() {
                    if (widget.enabled == true) {
                      if (value == 0) return;
                      value = (value - appreciation);
                      if (value <= (widget.minValue ?? 0)) {
                        value = (widget.minValue ?? 0);
                        widget.valueListener!(value);
                      }
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
                widget.enabled ?? true
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
                if (widget.enabled = true) {
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
                    if (widget.enabled = true) {
                      value = value + appreciation;
                      if (value > (widget.maxValue ?? 999999)) {
                        value = (widget.maxValue ?? 999999);
                        widget.valueListener!(value);
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
              child: Image.asset(
                widget.enabled ?? true
                    ? 'assets/images/btn_jia_nor.png'
                    : 'assets/images/2.0x/btn_jia_disabled.png',
                fit: BoxFit.fitWidth,
                width: 34.w,
                height: 34.h,
              ),
            ),
            // TextButton(
            //     onPressed: () {
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
