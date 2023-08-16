import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhwlzlxt_project/page/set_page.dart';
import 'package:zhwlzlxt_project/utils/treatment_type.dart';

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

class _UserHeadViewState extends State<UserHeadView> {
  User? user;

  @override
  void initState() {
    super.initState();
    eventBus.on<UserEvent>().listen((event) {
      user = event.user;
      print("--------->${user?.userName}");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25.5.h, left: 39.5.w, right: 40.w),
      child: Row(
        children: [
          Text(
            '${user?.userName ?? ""}   ${user?.phone ?? ""}   ',
            style: TextStyle(color: const Color(0xFF999999), fontSize: 18.sp),
          ),
          const Expanded(child: SizedBox()),
          Row(
            children: [
              Container(
                width: 130.w,
                height: 40.h,
                decoration: BoxDecoration(
                    color: const Color(0xFF00C290),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.w),
                    )),
                child: TextButton(
                  onPressed: () {
                    debugPrint('点击用户管理');
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
                        '用户管理',
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
                        '设置',
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
}
