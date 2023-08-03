import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

typedef CDateTime = Function(List<DateTime?> date);

// ignore: must_be_immutable
class TCalender extends StatefulWidget {
  CDateTime cDateTime;

  TCalender({Key? key, required this.cDateTime}) : super(key: key);

  @override
  State<TCalender> createState() => _TCalenderState();
}

class _TCalenderState extends State<TCalender> {
  List<DateTime?> _dates = [
    DateTime.now(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 120.h, left: 170.w, right: 170.w),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 40.h,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Color(0xff00a8e7),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    "日期选择",
                    style: TextStyle(color: Colors.white, fontSize: 17.sp),
                  ),
                  Positioned(
                    right: 20.w,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(
                        'assets/images/2.0x/btn_guanbi.png',
                        width: 18.w,
                        height: 18.h,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: 20.w, right: 20.w, top: 10.h, bottom: 20.h),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  CalendarDatePicker2(
                    config: CalendarDatePicker2WithActionButtonsConfig(
                      selectedDayHighlightColor: const Color(0xff00a8ee),
                      currentDate: DateTime.now(),
                      centerAlignModePicker: true,
                      firstDayOfWeek: 1,
                      dayTextStyle:
                          const TextStyle(color: Colors.black87, fontSize: 17),
                      selectedRangeHighlightColor: const Color(0x9600a8ef),
                      selectedDayTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                      calendarType: CalendarDatePicker2Type.range,
                    ),
                    value: _dates,
                    onValueChanged: (dates) => _dates = dates,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Text("取消",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: const Color(0xff666666))),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      InkWell(
                        onTap: () {
                          widget.cDateTime(_dates);
                          debugPrint("------------>$_dates");
                        },
                        child: Text(
                          "导出记录",
                          style: TextStyle(fontSize: 15.sp, color: Colors.blue),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
