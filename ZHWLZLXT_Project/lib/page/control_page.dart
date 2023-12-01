import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zhwlzlxt_project/base/globalization.dart';
import 'package:zhwlzlxt_project/entity/user_entity.dart';
import 'package:zhwlzlxt_project/page/add_page.dart';
import 'package:zhwlzlxt_project/page/record_page.dart';
import 'package:zhwlzlxt_project/utils/event_bus.dart';
import 'package:zhwlzlxt_project/widget/delete_dialog.dart';

import '../Controller/treatment_controller.dart';
import '../dataResource/user_sql_dao.dart';
import '../utils/treatment_type.dart';
import '../utils/utils_tool.dart';

class UserEvent {
  User? user;
  TreatmentType? type;

  UserEvent({this.user, this.type});
}

// ignore: must_be_immutable
class ControlPage extends StatefulWidget {
  TreatmentType? type;

  ControlPage({Key? key, this.type}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  //搜索框
  TextEditingController searchController = TextEditingController();

  //编号
  TextEditingController numController = TextEditingController();

  //姓名
  TextEditingController nameController = TextEditingController();

  //年龄
  TextEditingController ageController = TextEditingController();

  //性别
  TextEditingController sexController = TextEditingController();

  //电话
  TextEditingController telController = TextEditingController();

  //证件
  TextEditingController cerController = TextEditingController();

  //住院号
  TextEditingController zhuController = TextEditingController();

  //床号
  TextEditingController bedController = TextEditingController();

  //是否点击编辑按钮
  bool isEdit = true;

  //删除dialog
  DeleteDialog? dialog;

  List<User> userList = [];

  User? user;

  int sex = 1;

  final TreatmentController controller = Get.find();

  @override
  void initState() {
    super.initState();
    UserSqlDao.instance().queryAllUser().then((value) => {userForJson(value)});
    eventBus.on<User>().listen((event) {
      if (!TextUtil.isEmpty(searchController.text)) {
        UserSqlDao.instance()
            .queryIUser(key: searchController.text)
            .then((v) => {userForJson(v)});
      } else {
        UserSqlDao.instance()
            .queryAllUser()
            .then((value) => {userForJson(value)});
      }
    });

    StreamController<String> controller = StreamController<String>();
    searchController.addListener(() {
      controller.add(searchController.text);
    });
    controller.stream
        .debounceTime(const Duration(seconds: 1))
        .listen((inputList) {
      if (!TextUtil.isEmpty(inputList)) {
        UserSqlDao.instance()
            .queryIUser(key: inputList)
            .then((v) => {userForJson(v)});
      } else {
        UserSqlDao.instance()
            .queryAllUser()
            .then((value) => {userForJson(value)});
      }
    });
  }

  void userForJson(value) {
    if (!mounted) {
      return;
    }
    userList.clear();
    for (var map in value) {
      userList.add(User.fromMap(map));
    }
    if (userList.isNotEmpty) {
      userList = userList.reversed.toList();
      userList[0].isChoose = true;
      user = userList[0];
      chooseUser(user!);
    }
    setState(() {});
  }

  void chooseUser(User user) {
    this.user = user;
    numController.text = user.userNub ?? "";
    nameController.text = user.userName ?? "";
    ageController.text = user.age.toString();
    telController.text = user.phone.toString();
    cerController.text = user.idCard.toString();
    zhuController.text = user.ad.toString();
    bedController.text = user.bedNumber.toString();
    sex = user.sex ?? 1;
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
          onTap: () {
            Get.back();
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
          Globalization.userManagement.tr,
          style: TextStyle(fontSize: 15.sp, color: Colors.white),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              debugPrint('点击新增用户');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const AddPage()));
            },
            child: Container(
              margin: const EdgeInsets.only(top: 13.0, right: 20, bottom: 10),
              padding: const EdgeInsets.all(5),
              // color: Color(0xFF19B1E9),
              decoration: BoxDecoration(
                color: const Color(0xFF19B1E9),
                border: Border.all(
                  color: const Color(0xFF19B1E9),
                  width: 0.5.w,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.w),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  Image.asset(
                    'assets/images/2.0x/icon_xinzeng.png',
                    width: 14.w,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    Globalization.newUsers.tr,
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          margin:
              EdgeInsets.only(left: 15.w, right: 10.w, top: 10.h, bottom: 10.h),
          child: Row(
            children: [
              Container(
                  width: 295.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 0.5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.w),
                    ),
                  ),
                  margin: EdgeInsets.only(right: 10.w),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: 6.w, right: 6.w, top: 10.h, bottom: 10.h),
                        padding: EdgeInsets.only(left: 60.w, right: 10.w),
                        height: 45.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5,
                            color: const Color(0xFFD6D6D6),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(7.w)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/images/2.0x/icon_sousuo.png',
                              fit: BoxFit.fitWidth,
                              width: 16.w,
                            ),
                            SizedBox(
                              width: 6.w,
                            ),
                            SizedBox(
                              width: 180.w,
                              child: TextField(
                                controller: searchController,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color(0xFF333333)),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '请输入手机号',
                                  hintStyle: TextStyle(
                                      color: const Color(0xFFaaaaaa),
                                      fontSize: 13.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 6.w, right: 6.w),
                        height: 43.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F7F9),
                          border: Border.all(
                            width: 0.5,
                            color: const Color(0xFFF5F7F9),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(7.w)),
                        ),
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 41.w),
                                width: 60.w,
                                child: Text(
                                  Globalization.name.tr,
                                  style: TextStyle(
                                      color: const Color(0xFF999999),
                                      fontSize: 14.sp),
                                )),
                            Container(
                                margin: EdgeInsets.only(left: 20.w),
                                child: Text(
                                  Globalization.tel.tr,
                                  style: TextStyle(
                                      color: const Color(0xFF999999),
                                      fontSize: 14.sp),
                                )),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.only(top: 15, left: 15),
                          shrinkWrap: true,
                          itemCount: userList.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                                thickness: 1,
                                height: 10,
                                color: Color(0xffeeeeee));
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return userItem(index);
                          },
                        ),
                      ),
                    ],
                  )),
              Container(
                  width: 610.w,
                  height: 550.h,
                  margin: EdgeInsets.only(left: 10.w, right: 10.w),
                  padding: EdgeInsets.only(top: 40.h, left: 20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(15.w)),
                  ),
                  child: userList.isEmpty
                      ? Center(
                          child: Text(
                          "当前没有用户，添加用户吧~",
                          style: TextStyle(fontSize: 15.sp),
                        ))
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 60.w,
                                        child: Text(
                                          Globalization.no.tr,
                                          style: TextStyle(
                                              color: const Color(0xFF999999),
                                              fontSize: 16.sp),
                                        )),
                                    Container(
                                        width: 220.w,
                                        height: 43.h,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 0.5,
                                            color: const Color(0xFFDBDBDB),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7.w)),
                                        ),
                                        child: Center(
                                          child: TextField(
                                            maxLength: 20,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: const Color(0xFF333333)),
                                            controller: numController,
                                            decoration: InputDecoration(
                                              counterText: '',
                                              contentPadding:
                                                  EdgeInsets.only(left: 10.w),
                                              border: InputBorder.none,
                                              enabled: isEdit ? false : true,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 40.w,
                                        child: Text(
                                          Globalization.name.tr,
                                          style: TextStyle(
                                              color: const Color(0xFF999999),
                                              fontSize: 16.sp),
                                        )),
                                    Container(
                                        width: 220.w,
                                        height: 43.h,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 0.5,
                                            color: const Color(0xFFDBDBDB),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7.w)),
                                        ),
                                        child: Center(
                                          child: TextField(
                                            maxLength: 5,
                                            controller: nameController,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: const Color(0xFF333333)),
                                            decoration: InputDecoration(
                                              counterText: '',
                                              contentPadding:
                                                  EdgeInsets.only(left: 10.w),
                                              border: InputBorder.none,
                                              enabled: isEdit ? false : true,
                                            ),
                                          ),
                                        )),
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
                                        width: 60.w,
                                        child: Text(
                                          Globalization.age.tr,
                                          style: TextStyle(
                                              color: const Color(0xFF999999),
                                              fontSize: 16.sp),
                                        )),
                                    Container(
                                        width: 220.w,
                                        height: 43.h,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 0.5,
                                            color: const Color(0xFFDBDBDB),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7.w)),
                                        ),
                                        child: Center(
                                          child: TextField(
                                            maxLength: 3,
                                            controller: ageController,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: const Color(0xFF333333)),
                                            decoration: InputDecoration(
                                              counterText: '',
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.only(left: 10.w),
                                              enabled: isEdit ? false : true,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 60.w,
                                        child: Text(
                                          Globalization.gender.tr,
                                          style: TextStyle(
                                              color: const Color(0xFF999999),
                                              fontSize: 16.sp),
                                        )),
                                    Container(
                                        width: 220.w,
                                        height: 43.h,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 0.5,
                                            color: const Color(0xFFDBDBDB),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7.w)),
                                        ),
                                        child: Center(
                                          child: isEdit
                                              ? Text(
                                                  sex == 1 ? "男" : '女',
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: const Color(
                                                          0xFF333333)),
                                                )
                                              : Row(
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
                                                              color: const Color(
                                                                  0xFF333333),
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
                                                              color: const Color(
                                                                  0xFF333333),
                                                              fontSize: 15.sp),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                        )),
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
                                        width: 60.w,
                                        child: Text(
                                          Globalization.tel.tr,
                                          style: TextStyle(
                                              color: const Color(0xFF999999),
                                              fontSize: 16.sp),
                                        )),
                                    Container(
                                        width: 220.w,
                                        height: 43.h,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 0.5,
                                            color: const Color(0xFFDBDBDB),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7.w)),
                                        ),
                                        child: Center(
                                          child: TextField(
                                            maxLength: 20,
                                            controller: telController,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: const Color(0xFF333333)),
                                            decoration: InputDecoration(
                                              counterText: '',
                                              contentPadding:
                                                  EdgeInsets.only(left: 10.w),
                                              border: InputBorder.none,
                                              enabled: isEdit ? false : true,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 40.w,
                                        child: Text(
                                          Globalization.certificate.tr,
                                          style: TextStyle(
                                              color: const Color(0xFF999999),
                                              fontSize: 16.sp),
                                        )),
                                    Container(
                                        width: 220.w,
                                        height: 43.h,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 0.5,
                                            color: const Color(0xFFDBDBDB),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7.w)),
                                        ),
                                        child: Center(
                                          child: TextField(
                                            maxLength: 30,
                                            controller: cerController,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: const Color(0xFF333333)),
                                            decoration: InputDecoration(
                                              counterText: '',
                                              contentPadding: EdgeInsets.only(
                                                  left: 10.w, top: 5.h),
                                              border: InputBorder.none,
                                              enabled: isEdit ? false : true,
                                            ),
                                          ),
                                        )),
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
                                        width: 60.w,
                                        child: Text(
                                          Globalization.hospitalNo.tr,
                                          style: TextStyle(
                                              color: const Color(0xFF999999),
                                              fontSize: 16.sp),
                                        )),
                                    Container(
                                        width: 220.w,
                                        height: 43.h,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 0.5,
                                            color: const Color(0xFFDBDBDB),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7.w)),
                                        ),
                                        child: Center(
                                          child: TextField(
                                            maxLength: 2,
                                            controller: zhuController,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: const Color(0xFF333333)),
                                            decoration: InputDecoration(
                                              counterText: '',
                                              contentPadding: EdgeInsets.only(
                                                  left: 10.w, top: 5.h),
                                              border: InputBorder.none,
                                              enabled: isEdit ? false : true,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 40.w,
                                        child: Text(
                                          Globalization.bedNo.tr,
                                          style: TextStyle(
                                              color: const Color(0xFF999999),
                                              fontSize: 16.sp),
                                        )),
                                    Container(
                                        width: 220.w,
                                        height: 43.h,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 0.5,
                                            color: const Color(0xFFDBDBDB),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7.w)),
                                        ),
                                        child: Center(
                                          child: TextField(
                                            maxLength: 20,
                                            controller: bedController,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: const Color(0xFF333333)),
                                            decoration: InputDecoration(
                                              counterText: '',
                                              contentPadding: EdgeInsets.only(
                                                  left: 10.w, top: 5.h),
                                              border: InputBorder.none,
                                              enabled: isEdit ? false : true,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 40.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      height: (Get.locale?.countryCode == "CN")
                                          ? 43.h
                                          : 60.h,
                                      width: 110.w,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 0.5,
                                          color: const Color(0xFF00A8E7),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7.w)),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          isEdit = !isEdit;
                                          setState(() {});
                                        },
                                        child: Text(
                                          isEdit
                                              ? Globalization.editInfo.tr
                                              : Globalization.cancel.tr,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: const Color(0xFF00A8E7),
                                              fontSize: 18.sp),
                                        ),
                                      )),
                                  Visibility(
                                    visible: isEdit ? true : false,
                                    maintainState: false,
                                    maintainAnimation: false,
                                    maintainSize: false,
                                    child: Container(
                                        height:
                                            (Get.locale?.countryCode == "CN")
                                                ? 43.h
                                                : 60.h,
                                        width: 110.w,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF00A8E7),
                                          border: Border.all(
                                            width: 0.5,
                                            color: const Color(0xFF00A8E7),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7.w)),
                                        ),
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          RecordPage(
                                                              user?.userId,
                                                              user?.userName)));
                                            },
                                            child: Text(
                                              Globalization.treatmentRecords.tr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xFFFFFFFF),
                                                  fontSize: 18.sp),
                                            ))),
                                  ),
                                  Container(
                                      height: (Get.locale?.countryCode == "CN")
                                          ? 43.h
                                          : 60.h,
                                      width: 110.w,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF00C290),
                                        border: Border.all(
                                          width: 0.5,
                                          color: const Color(0xFF00C290),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7.w)),
                                      ),
                                      child: TextButton(
                                          onPressed: () {
                                            if (!isEdit) {
                                              user?.userNub =
                                                  numController.text; //编号
                                              user?.userName =
                                                  nameController.text;
                                              user?.sex = sex;
                                              user?.age = int.parse(
                                                  ageController.text); //年龄
                                              user?.sex = sex; //性别
                                              user?.phone =
                                                  telController.text; //电话
                                              user?.idCard =
                                                  cerController.text; //证件
                                              user?.ad =
                                                  zhuController.text; //住院号
                                              user?.bedNumber =
                                                  bedController.text; //床号


                                              RegExp mobile = RegExp(r"1[0-9]\d{9}$");
                                              if (!mobile.hasMatch(telController.text)) {
                                                showToastMsg(msg: "电话号码格式不正确");
                                                return;
                                              }

                                              UserSqlDao.instance()
                                                  .updateData(user: user!);
                                              isEdit = true;
                                              setState(() {});
                                            } else {
                                              userMap[widget.type!] = user!;
                                              eventBus.fire(UserEvent(
                                                  user: user,
                                                  type: widget.type));
                                              eventBus.fire(widget.type);
                                              Get.back();
                                            }
                                          },
                                          child: Text(
                                            isEdit
                                                ? Globalization
                                                    .startTreatment.tr
                                                : Globalization.save.tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: const Color(0xFFFFFFFF),
                                                fontSize: 18.sp),
                                          ))),
                                ],
                              ),
                            ),
                          ],
                        )),
            ],
          ),
        ),
      ),
    );
  }

  var lastIndex = 0;

  Widget userItem(index) {
    if (userList[index].isChoose ?? false) {
      lastIndex = index;
    }
    return Container(
      margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                chooseUser(userList[index]);
                userList[lastIndex].isChoose = false;
                userList[index].isChoose = true;
                lastIndex = index;
                setState(() {});
              },
              child: Row(
                children: [
                  Opacity(
                    opacity: userList[index].isChoose ?? false ? 1 : 0,
                    child: Container(
                        child: Image.asset(
                      'assets/images/2.0x/icon_xuanzhong.png',
                      fit: BoxFit.fitWidth,
                      width: 14.w,
                      height: 14.h,
                    )),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 15.w),
                      width: 60.w,
                      child: Text(
                        userList[index].userName ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: const Color(0xFF333333), fontSize: 15.sp),
                      )),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 20.w),
                        child: Text(
                          userList[index].phone ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: const Color(0xFF333333), fontSize: 15.sp),
                        )),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
              onTap: () {
                dialog = DeleteDialog(suer: () async {
                  var suc = await UserSqlDao.instance()
                      .delectData(userId: user!.userId!);
                  if (suc) {
                    userList.removeAt(index);
                    if (userList.isNotEmpty && lastIndex == index) {
                      lastIndex = 0;
                      user = userList[0];
                      user?.isChoose = true;
                    }
                    setState(() {});
                  }
                });
                dialog?.showDeleteDialog(context);
              },
              child: Container(
                padding: const EdgeInsets.only(
                    right: 30, left: 30, top: 10, bottom: 10),
                child: Image.asset(
                  'assets/images/2.0x/icon_shanchu.png',
                  fit: BoxFit.fitWidth,
                  width: 10.w,
                ),
              )),
        ],
      ),
    );
  }
}
