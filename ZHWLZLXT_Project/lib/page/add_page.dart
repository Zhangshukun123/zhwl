import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  var regexNotNull = "[\\s]";
  var regexOnlyNumber = "[0-9]";

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();

    ageController.addListener(() {
      final text = ageController.text;
      if (text.isNotEmpty) {
        final value = int.tryParse(text);
        if (value != null && value > 120) {
          ageController.text = '120';
          ageController.selection = TextSelection.fromPosition(
            TextPosition(offset: ageController.text.length),
          );
        }
      }
    });
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
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(left: 30,right: 30),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  width: 80.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.w),
                      )
                  ),
                  child: InkWell(
                    onTap: (){
                      focusNode.unfocus();
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 10.w,),
                        Image.asset('assets/images/2.0x/icon_fanhui.png',width: 14.w,height: 14.h,fit: BoxFit.fitWidth,),
                        Text(
                          Globalization.back.tr,
                          style: TextStyle(fontSize: 18.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 10.w),
                    child: Center(
                        child: Text(Globalization.addUser.tr,style: TextStyle(fontSize: 18.sp, color: const Color(0xff555555)),)
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 50,),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 55.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/2.0x/icon_bitian.png',
                            width: 10.w,
                            height: 10.h,
                            fit: BoxFit.fitWidth,
                          ),
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
                              maxLength: 20,
                              controller: numController,
                              style: TextStyle(
                                  fontSize: 15.sp, color: const Color(0xFF333333)),
                              decoration: InputDecoration(
                                counterText: '',
                                border: const OutlineInputBorder(),
                                hintText: Globalization.hint_015.tr,
                                hintStyle: TextStyle(
                                    color: const Color(0xFFaaaaaa),
                                    fontSize: 14.sp),
                              ),
                              inputFormatters: [
                                // FilteringTextInputFormatter.digitsOnly,//数字，只能是整数
                                LengthLimitingTextInputFormatter(8),
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z0-9]'),
                                ),
                                //限制长度8位，推荐年月日+2 位数字组合
                                // FilteringTextInputFormatter.allow(RegExp("[0-9.]")),//数字包括小数
                                //FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),//只允许输入字母
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/2.0x/icon_bitian.png',
                            width: 10.w,
                            height: 10.h,
                            fit: BoxFit.fitWidth,
                          ),
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
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(5),
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z0-9\u4e00-\u9fa5]'), // 允许：英文、数字、中文
                                ),
                              ],
                              controller: nameController,
                              style: TextStyle(
                                  fontSize: 15.sp, color: const Color(0xFF333333)),

                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: Globalization.hint_010.tr,
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
                  SizedBox(
                    height: 55.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          // Image.asset('assets/images/2.0x/icon_bitian.png',width: 10.w,height: 10.h,fit: BoxFit.fitWidth,),
                          SizedBox(
                            width: 10.w,
                          ),
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
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(3),
                                FilteringTextInputFormatter.digitsOnly, // 只允许数字
                              ],
                              controller: ageController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 15.sp, color: const Color(0xFF333333)),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: Globalization.hint_011.tr,
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
                          // Image.asset('assets/images/2.0x/icon_bitian.png',width: 10.w,height: 10.h,fit: BoxFit.fitWidth,),
                          SizedBox(
                            width: 10.w,
                          ),
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
                                      Globalization.man.tr,
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
                                      Globalization.nv.tr,
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
                  SizedBox(
                    height: 55.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/2.0x/icon_bitian.png',
                            width: 10.w,
                            height: 10.h,
                            fit: BoxFit.fitWidth,
                          ),
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
                             maxLength: 20,
                              controller: telController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 15.sp, color: const Color(0xFF333333)),
                              decoration: InputDecoration(
                                counterText: '',
                                border: const OutlineInputBorder(),
                                hintText: Globalization.hint_007.tr,
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
                          // Image.asset('assets/images/2.0x/icon_bitian.png',width: 10.w,height: 10.h,fit: BoxFit.fitWidth,),
                          SizedBox(
                            width: 10.w,
                          ),
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
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(18),
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z0-9\u4e00-\u9fa5]'),
                                ),
                              ],
                              controller: cerController,
                              style: TextStyle(
                                  fontSize: 15.sp, color: const Color(0xFF333333)),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: Globalization.hint_012.tr,
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
                  SizedBox(
                    height: 55.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          // Image.asset('assets/images/2.0x/icon_bitian.png',width: 10.w,height: 10.h,fit: BoxFit.fitWidth,),
                          SizedBox(
                            width: 10.w,
                          ),
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
                              maxLength: 50,
                              controller: zhuController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z0-9\u4e00-\u9fa5]'),
                                ),
                              ],
                              style: TextStyle(
                                  fontSize: 15.sp, color: const Color(0xFF333333)),
                              decoration: InputDecoration(
                                counterText: '',
                                border: const OutlineInputBorder(),
                                hintText: Globalization.hint_013.tr,
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
                          // Image.asset('assets/images/2.0x/icon_bitian.png',width: 10.w,height: 10.h,fit: BoxFit.fitWidth,),
                          SizedBox(
                            width: 10.w,
                          ),
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
                              maxLength: 50,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z0-9\u4e00-\u9fa5]'),
                                ),
                              ],
                              style: TextStyle(
                                  fontSize: 15.sp, color: const Color(0xFF333333)),
                              decoration: InputDecoration(
                                counterText: '',
                                border: const OutlineInputBorder(),
                                hintText: Globalization.hint_014.tr,
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
                  SizedBox(
                    height: 55.h,
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
                              color: const Color(0xFF403B5B),
                            )),
                        child: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            Globalization.cancel.tr,
                            style: TextStyle(
                                color: const Color(0xFF403B5B), fontSize: 18.sp),
                          ),
                        ),
                      ),
                      Container(
                        width: 110.w,
                        height: 43.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF403B5B),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.w),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (TextUtil.isEmpty(numController.text)) {
                              showToastMsg(msg: Globalization.hint_015.tr);
                              return;
                            }
                            if (TextUtil.isEmpty(nameController.text)) {
                              showToastMsg(msg: Globalization.hint_010.tr);
                              return;
                            }
                            // if (TextUtil.isEmpty(ageController.text)) {
                            //   showToastMsg(msg: "请输入用户年龄");
                            //   return;
                            // }
                            if (TextUtil.isEmpty(telController.text)) {
                              showToastMsg(msg: Globalization.hint_007.tr);
                              return;
                            }
                            RegExp mobile = RegExp(r"1[0-9]\d{9}$");
                            if (!mobile.hasMatch(telController.text)) {
                              showToastMsg(msg: Globalization.hint_016.tr);
                              return;
                            }

                            User user = User();
                            user.userNub = numController.text; //编号
                            user.userName = nameController.text;
                            user.sex = sex;
                            if(ageController.text.isEmpty){
                              user.age = 0;
                            }
                            else{
                              user.age = int.parse(ageController.text); //年龄
                            }
                            user.sex = sex; //性别
                            user.phone = telController.text; //电话
                            user.idCard = cerController.text; //证件
                            user.ad = zhuController.text; //住院号
                            user.bedNumber = bedController.text; //床号
                            UserSqlDao.instance().addData(user: user).then((value) {
                              if (value) {
                                eventBus.fire(User());
                                Get.back();
                              }
                            });
                            // ignore: avoid_print

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
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
