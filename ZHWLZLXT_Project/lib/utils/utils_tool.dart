/*
 * @Descripttion: 
 * @version: 
 * @Author: TT
 * @Date: 2022-08-15 09:45:37
 * @LastEditors: TT
 * @LastEditTime: 2022-08-16 10:21:05
 */

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 显示toast msg
/// 传content 后,如果没传ontap 会调用返回上一个界面的方法
/// type == 1 普通 toast , 2 成功toast 3 失败toast
void showToastMsg({
  required String msg,
  int type = 1,
  BuildContext? context,
  Function()? ontap,
}) {
  // EasyLoading.instance.loadingStyle = EasyLoadingStyle.dark;
  // if (type == 1) {
  //   EasyLoading.showToast(msg);
  // } else if (type == 2) {
  //   EasyLoading.showSuccess(msg);
  // } else if (type == 3) {
  //   EasyLoading.showError(msg);
  // }
  // if (ontap != null || context != null) {
  //   Future.delayed(EasyLoading.instance.displayDuration).then(
  //     (value) {
  //       if (ontap != null) {
  //         ontap();
  //       } else {
  //         Navigator.of(context!).pop();
  //       }
  //     },
  //   );
  // }


  Fluttertoast.showToast(msg: msg,fontSize: 30,backgroundColor: const Color(0x7f000000));


}
