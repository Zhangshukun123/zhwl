import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ContainerBg extends StatelessWidget {
  Widget? child;
  final EdgeInsetsGeometry? margin;

  ContainerBg({Key? key, this.child,this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 15.w,
                offset: const Offset(0, 2),
                spreadRadius: 0)
          ],
          borderRadius: BorderRadius.all(Radius.circular(15.w))),
      width: 340.w,
      margin: margin,
      child: child,
    );
  }
}
