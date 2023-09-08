import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/base/globalization.dart';
import 'package:zhwlzlxt_project/dataResource/user_sql_dao.dart';
import 'package:zhwlzlxt_project/entity/infrared_entity.dart';
import 'package:zhwlzlxt_project/entity/jingLuan_entity.dart';
import 'package:zhwlzlxt_project/entity/jingPi_entity.dart';
import 'package:zhwlzlxt_project/entity/pulsed_entity.dart';
import 'package:zhwlzlxt_project/entity/zhongPin_entity.dart';
import 'package:zhwlzlxt_project/page/set_page.dart';
import 'package:zhwlzlxt_project/utils/treatment_type.dart';

import '../Controller/treatment_controller.dart';
import '../entity/shenJing_entity.dart';
import '../entity/ultrasonic_entity.dart';
import '../entity/user_entity.dart';
import '../utils/event_bus.dart';
import '../utils/sp_utils.dart';
import 'control_page.dart';

// ignore: must_be_immutable
class UserHeadView extends StatefulWidget {
  TreatmentType? type;

  UserHeadView({Key? key, this.type}) : super(key: key);

  @override
  State<UserHeadView> createState() => _UserHeadViewState();
}

class _UserHeadViewState extends State<UserHeadView>
    with AutomaticKeepAliveClientMixin {
  User? user;
  var event;
  DateTime? lastPopTime;

  final TreatmentController controller = Get.find();

  @override
  void initState() {
    super.initState();

    eventBus.on<UserEvent>().listen((event) {
      if (!mounted) {
        return;
      }
      if (event.type == controller.treatmentType.value) {
        user = event.user;
        controller.user.value = event.user!;
      }
    });
    // event = eventBus.on<TreatmentType>().listen((event) {
    //   if (!mounted) {
    //     return;
    //   }
    //   if (event != TreatmentType.spasm &&
    //       event != TreatmentType.percutaneous &&
    //       event != TreatmentType.neuromuscular &&
    //       event != TreatmentType.frequency) {````````````````````````````
    //     return;
    //   }
    //   widget.type = event;
    //   setUserForType(event);
    // });
    // setUserForType(widget.type!);
  }

  @override
  void dispose() {
    super.dispose();
    event.cancel();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.only(top: 25.5.h, left: 39.5.w, right: 40.w),
      child: Row(
        children: [
          Obx(() => Text(
                '${controller.user.value.userName ?? ""}   ${controller.user.value.phone ?? ""}   ',
                style:
                    TextStyle(color: const Color(0xFF999999), fontSize: 18.sp),
              )),
          const Expanded(child: SizedBox()),
          Row(
            children: [
              Container(
                width: (Get.locale?.countryCode == "CN") ? 130.w : 180.w,
                height: 40.h,
                decoration: BoxDecoration(
                    color: const Color(0xFF00C290),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.w),
                    )),
                child: TextButton(
                  onPressed: () {
                    debugPrint('点击用户管理${controller.treatmentType.value}');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ControlPage(
                                  type: controller.treatmentType.value,
                                )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/2.0x/icon_yonghu.png',
                        fit: BoxFit.fitWidth,
                        width: 18.w,
                        height: 18.h,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        Globalization.userManagement.tr,
                        style: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 29.5.w,
              ),
              Container(
                width: 100.w,
                height: 40.h,
                decoration: BoxDecoration(
                    color: const Color(0xFF00C290),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.w),
                    )),
                child: TextButton(
                  onPressed: () {
                    debugPrint('点击设置');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const SetPage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/2.0x/icon_shezhi.png',
                        fit: BoxFit.fitWidth,
                        width: 18.w,
                        height: 18.h,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        Globalization.setting.tr,
                        style: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
