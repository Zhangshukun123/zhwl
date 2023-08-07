
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef SingleCallback<int> = void Function(int obj);

class HomeSwitchButton extends StatefulWidget {

  final String? onString;
  final String? offString;
  final bool pressed;
  final SingleCallback? onTap;

  HomeSwitchButton({
    Key? key,
    required this.onString,
    required this.offString,
    required this.pressed,
    required this.onTap
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeSwitchButtonState();
  }

}

class HomeSwitchButtonState extends State<HomeSwitchButton> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _switchButton();
  }

  Widget _switchButton() {
    BoxDecoration BoxDecoration_left1 = BoxDecoration(
      color: const Color(0xFF00A8E7),
        border: Border.all(
            width: 0.5, style: BorderStyle.solid, color: const Color(0xFFF0F0F0)),
        borderRadius: BorderRadius.circular(22.5.h));
    BoxDecoration BoxDecoration_left2 = BoxDecoration(
        color: const Color(0xFFF0F0F0),
        border: Border.all(
            width: 0.5, style: BorderStyle.solid, color: const Color(0xFFF0F0F0)),
        borderRadius: BorderRadius.circular(22.5.h));
    BoxDecoration BoxDecoration_right1 = BoxDecoration(
        color: const Color(0xFFF0F0F0),
        border: Border.all(
            width: 0.5, style: BorderStyle.solid, color: const Color(0xFFF0F0F0)),
        borderRadius: BorderRadius.circular(22.5.h));
    BoxDecoration BoxDecoration_right2 = BoxDecoration(
        color: const Color(0xFF00A8E7),
        border: Border.all(
            width: 0.5, style: BorderStyle.solid, color: const Color(0xFFF0F0F0)),
        borderRadius: BorderRadius.circular(22.5.h));

    TextStyle textStyle =  TextStyle(fontSize: 18.sp, color: Colors.white);
    TextStyle textStyle1 =  TextStyle(fontSize: 18.sp, color: Colors.black);

    return Container(
      width: 130.w,
      height: 45.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(22.5.h),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 65.w,
            height: 45.h,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 3, bottom: 3, right: 3, left: 3),
            decoration: widget.pressed ? BoxDecoration_left1 : BoxDecoration_left2,
            child: GestureDetector(
                child: Text(widget.onString ?? "", style: widget.pressed ? textStyle : textStyle1, ),
                onTap: () {
                  if (widget.onTap != null){
                    widget.onTap!(0);
                  }
                }),
          ),
          Container(
            width: 65.w,
            height: 45.h,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 3, bottom: 3, right: 3, left: 3),
            decoration: widget.pressed ? BoxDecoration_right1 : BoxDecoration_right2,
            child: GestureDetector(
                child: Text(widget.offString ?? "", style: widget.pressed ? textStyle1 : textStyle),
                onTap: () {
                  if (widget.onTap != null){
                    widget.onTap!(1);
                  }
                }),
          ),
        ],
      ),
    );
  }
}

