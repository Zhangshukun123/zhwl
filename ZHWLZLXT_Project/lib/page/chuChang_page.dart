import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/utils/event_bus.dart';
import 'package:zhwlzlxt_project/utils/sp_utils.dart';
import 'package:zhwlzlxt_project/utils/utils_tool.dart';

import '../base/globalization.dart';
import '../entity/set_value_entity.dart';
import '../widget/set_value_horizontal.dart';

class ChuChangPage extends StatefulWidget {
  const ChuChangPage({Key? key}) : super(key: key);

  @override
  State<ChuChangPage> createState() => _ChuChangPageState();
}

class _ChuChangPageState extends State<ChuChangPage> {
  var power = 0.0;
  var utMxt = "1";
  var powerDAC = 0.0;
  var isOpen = false;

  @override
  void initState() {
    super.initState();

    eventBus.on<String>().listen((event) {
      if (!mounted) {
        return;
      }
      utMxt = event;
      setState(() {});
    });
    powerDAC = SpUtils.getDouble(power.toString(), defaultValue: 0.0)!;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text(
          Globalization.setting.tr,
          style: TextStyle(fontSize: 18.sp, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 700.w,
                height: 90.h,
                margin: EdgeInsets.only(left: 115.w, right: 115.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: const Color(0xFFDBDBDB),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.w)),
                ),
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 33.w),
                        child: Text(
                          "频率${utMxt}M",
                          style: TextStyle(
                              color: const Color(0xFF999999), fontSize: 18.sp),
                        )),
                    Expanded(
                        child: SizedBox(
                      width: 10.w,
                    )),
                    Container(
                      width: 110.w,
                      height: 43.h,
                      margin: EdgeInsets.only(right: 33.w),
                      decoration: BoxDecoration(
                          color: const Color(0xFF00A8E7),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.w),
                          )),
                      child: TextButton(
                          onPressed: () {
                            eventBus.fire(const MethodCall("saponin"));
                          },
                          child: Text(
                            '扫频',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.sp),
                          )),
                    )
                  ],
                ),
              ),
              Container(
                  width: 700.w,
                  height: 90.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFFDBDBDB),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.w)),
                  ),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 33.w),
                          child: Text(
                            '输出功率',
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontSize: 18.sp),
                          )),
                      Expanded(
                          child: SizedBox(
                        width: 10.w,
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 15.w,
                          ),
                          SetValueHorizontal(
                            enabled: true,
                            assets: 'assets/images/2.0x/icon_gonglv.png',
                            initialValue: 0,
                            width: 250.w,
                            appreciation: 0.6,
                            unit: 'W',
                            maxValue: utMxt == "1" ? 7.2 : 3,
                            isInt: false,
                            valueListener: (value) {
                              power = value;
                              var set = SetValueEntity();
                              set.value = SpUtils.getDouble(power.toString());
                              set.type = 15;
                              eventBus.fire(set);
                              setState(() {});
                              // cPower.add(value.toString());
                            },
                          ),
                        ],
                      ),
                    ],
                  )),
              Container(
                  width: 700.w,
                  height: 90.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFFDBDBDB),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.w)),
                  ),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 33.w),
                          child: Text(
                            'DAC',
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontSize: 18.sp),
                          )),
                      Expanded(
                          child: SizedBox(
                        width: 10.w,
                      )),
                      SetValueHorizontal(
                        enabled: true,
                        assets: 'assets/images/2.0x/icon_gonglv.png',
                        initialValue: SpUtils.getDouble(power.toString()),
                        width: 250.w,
                        appreciation: 0.1,
                        indexType: 15,
                        unit: 'W',
                        isInt: false,
                        valueListener: (value) {
                          powerDAC = value;
                          eventBus.fire(const MethodCall("saveP"));
                          // SpUtils.setDouble(power.toString(), value);
                          // cPower.add(value.toString());
                        },
                      ),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: 43.h,
                      width: 110.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00C290),
                        borderRadius: BorderRadius.all(Radius.circular(7.w)),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (isOpen) {
                            eventBus.fire(const MethodCall("close"));
                          } else {
                            eventBus.fire(const MethodCall("open"));
                          }
                          isOpen = !isOpen;
                          setState(() {
                          });
                        },
                        child: Text(
                          isOpen ? "关闭超声" : "开启超声",
                          style: TextStyle(
                              color: const Color(0xFFFFFFFF), fontSize: 18.sp),
                        ),
                      )),
                  Container(
                      height: 43.h,
                      width: 110.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A8E7),
                        borderRadius: BorderRadius.all(Radius.circular(7.w)),
                      ),
                      child: TextButton(
                          onPressed: () {
                            String formattedNum = powerDAC.toStringAsFixed(2);
                            SpUtils.setDouble(
                                power.toString(), double.parse(formattedNum));
                            showToastMsg(msg: "保存成功");
                          },
                          child: Text(
                            '保存',
                            style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontSize: 18.sp),
                          ))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
