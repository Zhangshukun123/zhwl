import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/base/globalization.dart';
import 'package:zhwlzlxt_project/page/set_page.dart';
import 'package:zhwlzlxt_project/utils/treatment_type.dart';

import '../Controller/treatment_controller.dart';
import '../base/run_state_page.dart';
import '../entity/user_entity.dart';
import '../utils/event_bus.dart';
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
  DateTime? lastPopTime;

  final TreatmentController controller = Get.find();

  @override
  void initState() {
    super.initState();
    user = userMap[widget.type];
    setState(() {});
    eventBus.on<TreatmentType>().listen((event) {
      if (!mounted) {
        return;
      }
      widget.type = event;
      user = userMap[event];
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.only(top: 15.h, left: 39.5.w, right: 40.w),
      child: Row(
        children: [
          // Obx(() => ),
          Container(
            constraints: BoxConstraints(maxWidth: 350.w),
            child: Row(
              children: [
                (user == null || TextUtil.isEmpty(user?.phone))
                    ? const Center()
                    : Text(
                        "${Globalization.user.tr}:",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: const Color(0xFF999999), fontSize: 16.sp),
                      ),
                Text(
                  user?.userName ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: const Color(0xFF333333), fontSize: 18.sp),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        user?.phone ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: const Color(0xFF333333), fontSize: 18.sp),
                      ),
                      Column(
                        children: [
                          (user == null || TextUtil.isEmpty(user?.phone))
                              ? const Center()
                              : InkWell(
                                  onTap: () {
                                    if(checkCure(widget.type)){
                                      return;
                                    }
                                    userMap.remove(widget.type);
                                    user = null;
                                    setState(() {});
                                  },
                                  child: Image.asset(
                                    'assets/images/icon_cancel.png',
                                    fit: BoxFit.fitWidth,
                                    width: 15.w,
                                    height: 15.h,
                                  ),
                                ),
                          const SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

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
                    if(checkCure(widget.type)){
                      return;
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ControlPage(
                                  type: widget.type,
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

                    if(checkCure(widget.type)){
                      return;
                    }
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
