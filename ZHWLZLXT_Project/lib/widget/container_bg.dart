import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ContainerBg extends StatelessWidget {
  Widget? child;
  final EdgeInsetsGeometry? margin;
  double? width;
  double? height;

  ContainerBg({Key? key, this.child, this.margin, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFFF0FAFE),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 15.w,
                offset: const Offset(0, 2),
                spreadRadius: 0)
          ],
          borderRadius: BorderRadius.all(Radius.circular(15.w))),
      width: width ?? 340.w,
      height: height,
      margin: margin,
      child: child,
    );
  }
}
