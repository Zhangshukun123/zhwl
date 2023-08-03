import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PopupMenuBtn extends StatefulWidget {
  int? index = 0;
  Offset? offset;
  String? patternStr = "1";
  String? unit = "";

  PopupMenuBtn({
    Key? key,
    this.index,
    this.offset,
    this.unit,
  }) : super(key: key);

  @override
  State<PopupMenuBtn> createState() => _PopupMenuBtnState();
}

class _PopupMenuBtnState extends State<PopupMenuBtn> {
  var pop;

  @override
  void initState() {
    super.initState();
    pop = _getPopupMenu(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFFF0FAFE),
          borderRadius: BorderRadius.all(
            Radius.circular(10.w),
          )),
      width: 230.w,
      height: 55.h,
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
                      widget.patternStr ?? "",
                      style: TextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 3.h),
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
              widget.patternStr = ovc as String?;
            });
            if (ovc == "连续 0") {
            } else if (ovc == "连续 1") {
            } else if (ovc == "连续 2") {}
          },
          onCanceled: () {
            print('cancel');
          }),
    );
  }

  _getPopupMenu(BuildContext context) {
    switch (widget.index) {
      case 0:
        widget.unit = '模式';
        widget.patternStr = '连续 0';
        widget.offset = Offset(0, 57.h);
        return <PopupMenuEntry<String>>[
          _getPopupMenuItem('连续 0'),
          _getPopupMenuItem('连续 1'),
          _getPopupMenuItem('连续 2'),
        ];
      case 1:
        widget.unit = "MHz";
        widget.patternStr = '1';
        widget.offset = Offset(0, -120.h);
        return <PopupMenuEntry<String>>[
          _getPopupMenuItem('1'),
          _getPopupMenuItem('3'),
        ];
      case 2:
        widget.unit = '模式';
        widget.patternStr = '连续 0';
        widget.offset = Offset(0, -120.h);
        return <PopupMenuEntry<String>>[
          _getPopupMenuItem('连续 0'),
          _getPopupMenuItem('连续 1'),
          _getPopupMenuItem('连续 2'),
        ];
      case 3:
        widget.unit = '模式';
        widget.patternStr = '连续 0';
        widget.offset = Offset(0, 57.h);
        return <PopupMenuEntry<String>>[
          _getPopupMenuItem('连续 0'),
          _getPopupMenuItem('连续 1'),
          _getPopupMenuItem('连续 2'),
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
        widget.unit = '模式';
        widget.patternStr = '连续 0';
        widget.offset = Offset(0, 57.h);
        return <PopupMenuEntry<String>>[
          _getPopupMenuItem('连续 0'),
          _getPopupMenuItem('连续 1'),
          _getPopupMenuItem('连续 2'),
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
        return <PopupMenuEntry<String>>[
          _getPopupMenuItem('1'),
          _getPopupMenuItem('2'),
          _getPopupMenuItem('3'),
        ];
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
          width: 200.w,
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
