import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:zhwlzlxt_project/base/globalization.dart';
import 'package:zhwlzlxt_project/page/chuChang_page.dart';

import '../cofig/AnpConfig.dart';


class SettingDialog {

  //输入框
  TextEditingController numController = TextEditingController();

  void showSettingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: true, //表示点击灰色背景的时候是否消失弹出框
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 500.w,
            height: 300.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.w),
                )),
            child: Column(
              children: [
                Container(
                    width: 500.w,
                    height: 50.h,
                    color: const Color(0xFF00A8E7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: Text(
                              Globalization.password.tr,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.sp),
                            )),
                      ],
                    )),
                SizedBox(
                    width: 500.w,
                    height: 250.h,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 55.h),
                          width:300.w,
                          height: 60.h,
                          child: TextField(
                            controller: numController,
                            maxLength: 20,
                            style: TextStyle(
                                fontSize: 15.sp, color: const Color(0xFF333333)),
                            decoration: InputDecoration(
                              counterText: '',
                              border: const OutlineInputBorder(),
                              hintText: Globalization.password.tr,
                              hintStyle: TextStyle(
                                  color: const Color(0xFF999999),
                                  fontSize: 15.sp),
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(8),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                height: 34.5.h,
                                width: 90.5.w,
                                margin: EdgeInsets.only(top: 29.h),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5,
                                    color: const Color(0xFF00A8E7),
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(7.w)),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    Globalization.cancel.tr,
                                    style: TextStyle(
                                        color: const Color(0xFF00A8E7),
                                        fontSize: 18.sp),
                                  ),
                                )),
                            Container(
                                height: 34.5.h,
                                width: 90.5.w,
                                margin: EdgeInsets.only(top: 29.h),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF00A8E7),
                                  border: Border.all(
                                    width: 0.5,
                                    color: const Color(0xFF00A8E7),
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(7.w)),
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      if (PswLIst.contains(numController.text)){
                                        Get.to(const ChuChangPage());
                                      }
                                      else{
                                        Fluttertoast.showToast(
                                            msg: Globalization.hint_018.tr);
                                      }
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (BuildContext context) =>
                                      //         const ChuChangPage()));
                                    },
                                    child: Text(
                                      Globalization.confirm.tr,
                                      style: TextStyle(
                                          color: const Color(0xFFFFFFFF),
                                          fontSize: 18.sp),
                                    ))),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}