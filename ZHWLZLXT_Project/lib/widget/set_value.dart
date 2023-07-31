import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef ValueListener = void Function(double value);

// ignore: must_be_immutable
class SetValue extends StatefulWidget {
  bool enabled = true;
  bool? isInt = true;
  String? assets;
  String? title;
  String? unit;
  double? initialValue;
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
  }) : super(key: key);

  @override
  State<SetValue> createState() => _SetValueState();
}

class _SetValueState extends State<SetValue> {
  double value = 0;
  double appreciation = 0;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue ?? 0;
    appreciation = widget.appreciation ?? 1;
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
                    width: 16.w,
                    height: 16.h,
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
            TextButton(
                onPressed: () {
                  if (widget.enabled) {
                    value = (value - appreciation);
                    if (value < 0) {
                      value = 0;
                      return;
                    }

                    widget.valueListener!(value);
                    setState(() {});
                  }
                },
                child: Image.asset(
                  widget.enabled
                      ? 'assets/images/btn_jian_nor.png'
                      : 'assets/images/2.0x/btn_jian_disabled.png',
                  fit: BoxFit.fitWidth,
                  width: 34.w,
                  height: 34.h,
                )),
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
            TextButton(
                onPressed: () {
                  if (widget.enabled) {
                    value = value + appreciation;
                    if(value > 99){
                      return;
                    }
                    widget.valueListener!(value);
                    setState(() {});
                  }
                },
                child: Image.asset(
                  widget.enabled
                      ? 'assets/images/btn_jia_nor.png'
                      : 'assets/images/2.0x/btn_jia_disabled.png',
                  fit: BoxFit.fitWidth,
                  width: 34.w,
                  height: 34.h,
                )),
          ],
        ),
      ],
    );
  }
}
