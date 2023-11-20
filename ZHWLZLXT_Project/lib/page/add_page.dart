import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/base/globalization.dart';
import 'package:zhwlzlxt_project/dataResource/user_sql_dao.dart';
import 'package:zhwlzlxt_project/entity/user_entity.dart';
import 'package:zhwlzlxt_project/utils/utils_tool.dart';

import '../utils/event_bus.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  //编号
  TextEditingController numController = TextEditingController();

  //姓名
  TextEditingController nameController = TextEditingController();

  //年龄
  TextEditingController ageController = TextEditingController();

  //电话
  TextEditingController telController = TextEditingController();

  //证件
  TextEditingController cerController = TextEditingController();

  //住院号
  TextEditingController zhuController = TextEditingController();

  //床号
  TextEditingController bedController = TextEditingController();

  //性别
  int sex = 1;

  late FocusNode focusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();

  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        toolbarHeight: 45.h,
        leading: InkWell(
          onTap: () async {
            focusNode.unfocus();
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          },
          child: Row(
            children: [
              const SizedBox(
                width: 25,
              ),
              Image.asset(
                'assets/images/ic_nav_back_white.png',
                width: 15.w,
                height: 15.h,
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
        ),
        leadingWidth: 40.w,
        title: Text(
          Globalization.addUser.tr,
          style: TextStyle(fontSize: 15.sp, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: 52.w,
                          child: Text(
                            Globalization.no.tr,
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontSize: 16.sp),
                          )),
                      SizedBox(
                        width: 250.w,
                        height: 43.h,
                        child: TextField(
                          controller: numController,
                          style: TextStyle(
                              fontSize: 15.sp, color: const Color(0xFF333333)),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: '请输入编号',
                            hintStyle: TextStyle(
                                color: const Color(0xFFaaaaaa),
                                fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 52.w,
                          child: Text(
                            Globalization.name.tr,
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontSize: 16.sp),
                          )),
                      SizedBox(
                        width: 250.w,
                        height: 43.h,
                        child: TextField(
                          controller: nameController,
                          style: TextStyle(
                              fontSize: 15.sp, color: const Color(0xFF333333)),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: '请输入姓名',
                            hintStyle: TextStyle(
                                color: const Color(0xFFaaaaaa),
                                fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: 52.w,
                          child: Text(
                            Globalization.age.tr,
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontSize: 16.sp),
                          )),
                      SizedBox(
                        width: 250.w,
                        height: 43.h,
                        child: TextField(
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontSize: 15.sp, color: const Color(0xFF333333)),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: '请输入年龄',
                            hintStyle: TextStyle(
                                color: const Color(0xFFaaaaaa),
                                fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 52.w,
                          child: Text(
                            Globalization.gender.tr,
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontSize: 16.sp),
                          )),
                      Container(
                        width: 250.w,
                        height: 43.h,
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: const Color(0xFFBBBBBB),
                          width: 1.w,
                        )),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Radio(
                                    value: 1, //按钮的值
                                    groupValue: sex,
                                    onChanged: (value) {
                                      setState(() {
                                        sex = value!;
                                      });
                                    }),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  '男',
                                  style: TextStyle(
                                      color: const Color(0xFF333333),
                                      fontSize: 15.sp),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: 2, //按钮的值
                                    groupValue: sex,
                                    onChanged: (value) {
                                      setState(() {
                                        sex = value!;
                                      });
                                    }),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  '女',
                                  style: TextStyle(
                                      color: const Color(0xFF333333),
                                      fontSize: 15.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: 52.w,
                          child: Text(
                            Globalization.tel.tr,
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontSize: 16.sp),
                          )),
                      SizedBox(
                        width: 250.w,
                        height: 43.h,
                        child: TextField(
                          controller: telController,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                              fontSize: 15.sp, color: const Color(0xFF333333)),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: '请输入电话',
                            hintStyle: TextStyle(
                                color: const Color(0xFFaaaaaa),
                                fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 52.w,
                          child: Text(
                            Globalization.certificate.tr,
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontSize: 16.sp),
                          )),
                      SizedBox(
                        width: 250.w,
                        height: 43.h,
                        child: TextField(
                          controller: cerController,
                          style: TextStyle(
                              fontSize: 15.sp, color: const Color(0xFF333333)),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: '请输入身份证号',
                            hintStyle: TextStyle(
                                color: const Color(0xFFaaaaaa),
                                fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: 52.w,
                          child: Text(
                            Globalization.hospitalNo.tr,
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontSize: 16.sp),
                          )),
                      SizedBox(
                        width: 250.w,
                        height: 43.h,
                        child: TextField(
                          controller: zhuController,
                          style: TextStyle(
                              fontSize: 15.sp, color: const Color(0xFF333333)),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: '请输入住院号',
                            hintStyle: TextStyle(
                                color: const Color(0xFFaaaaaa),
                                fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 52.w,
                          child: Text(
                            Globalization.bedNo.tr,
                            style: TextStyle(
                                color: const Color(0xFF999999),
                                fontSize: 16.sp),
                          )),
                      SizedBox(
                        width: 250.w,
                        height: 43.h,
                        child: TextField(
                          controller: bedController,
                          style: TextStyle(
                              fontSize: 15.sp, color: const Color(0xFF333333)),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: '请输入床号',
                            hintStyle: TextStyle(
                                color: const Color(0xFFaaaaaa),
                                fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 110.w,
                    height: 43.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.w),
                        ),
                        border: Border.all(
                          width: 0.5,
                          color: const Color(0xFF00A8E7),
                        )),
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        Globalization.cancel.tr,
                        style: TextStyle(
                            color: const Color(0xFF00A8E7), fontSize: 18.sp),
                      ),
                    ),
                  ),
                  Container(
                    width: 110.w,
                    height: 43.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00A8E7),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.w),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (TextUtil.isEmpty(numController.text)) {
                          showToastMsg(msg: "请输入用户编号");
                          return;
                        }
                        if (TextUtil.isEmpty(nameController.text)) {
                          showToastMsg(msg: "请输入用户姓名");
                          return;
                        }
                        if (TextUtil.isEmpty(ageController.text)) {
                          showToastMsg(msg: "请输入用户年龄");
                          return;
                        }
                        User user = User();
                        user.userNub = numController.text; //编号
                        user.userName = nameController.text;
                        user.sex = sex;
                        user.age = int.parse(ageController.text); //年龄
                        user.sex = sex; //性别
                        user.phone = telController.text; //电话
                        user.idCard = cerController.text; //证件
                        user.ad = zhuController.text; //住院号
                        user.bedNumber = bedController.text; //床号
                        UserSqlDao.instance().addData(user: user).then(
                            (value) => {if (value) eventBus.fire(User())});
                        // ignore: avoid_print
                        Get.back();

                        // print('AAAAAAA$');
                      },
                      child: Text(
                        Globalization.save.tr,
                        style: TextStyle(
                            color: const Color(0xFFFFFFFF), fontSize: 18.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
