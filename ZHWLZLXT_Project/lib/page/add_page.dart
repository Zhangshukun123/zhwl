import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  @override
  Widget build(BuildContext context) {
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(

        title: Text('添加用户',style: TextStyle(fontSize: 18.sp,color: Colors.white),),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(left: 15.w,right: 15.w,top: 10.h),
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
                          child: Text('编号',style: TextStyle(color: const Color(0xFF999999),fontSize: 16.sp),)
                      ),
                      SizedBox(
                        width: 250.w,
                        height: 43.h,
                        child: TextField(
                          controller: numController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: '12345356',
                            hintStyle: TextStyle(color: const Color(0xFF333333),fontSize: 16.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    // color: Colors.green,
                      child: Row(
                        children: [
                          Container(
                              width: 52.w,
                              child: Text('姓名',style: TextStyle(color: const Color(0xFF999999),fontSize: 16.sp),)
                          ),
                          Container(
                            width: 250.w,
                            height: 43.h,
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: '请输入姓名',
                                hintStyle: TextStyle(color: const Color(0xFF333333),fontSize: 16.sp),
                              ),
                            ),
                          ),
                        ],
                      )
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
                          child: Text('年龄',style: TextStyle(color: const Color(0xFF999999),fontSize: 16.sp),)
                      ),
                      SizedBox(
                        width: 250.w,
                        height: 43.h,
                        child: TextField(
                          controller: ageController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: '12345356',
                            hintStyle: TextStyle(color: const Color(0xFF333333),fontSize: 16.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    // color: Colors.green,
                      child: Row(
                        children: [
                          Container(
                              width: 52.w,
                              child: Text('性别',style: TextStyle(color: const Color(0xFF999999),fontSize: 16.sp),)
                          ),
                          Container(
                            width: 250.w,
                            height: 43.h,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(7),
                              ),
                              border: Border.all(
                                color: const Color(0xFFBBBBBB),
                                width: 1.5,
                              )
                            ),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                        value: 1,//按钮的值
                                        groupValue: sex,
                                        onChanged: (value){
                                          setState(() {
                                            sex = value!;
                                          });
                                        }
                                    ),
                                    SizedBox(width: 5.w,),
                                    Text('男',style: TextStyle(color: const Color(0xFF333333),fontSize: 16.sp),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                        value: 2,//按钮的值
                                        groupValue: sex,
                                        onChanged: (value){
                                          setState(() {
                                            sex = value!;
                                          });

                                        }
                                    ),
                                    SizedBox(width: 5.w,),
                                    Text('女',style: TextStyle(color: const Color(0xFF333333),fontSize: 16.sp),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
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
                          child: Text('电话',style: TextStyle(color: const Color(0xFF999999),fontSize: 16.sp),)
                      ),
                      SizedBox(
                        width: 250.w,
                        height: 43.h,
                        child: TextField(
                          controller: telController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: '12345356',
                            hintStyle: TextStyle(color: const Color(0xFF333333),fontSize: 16.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    // color: Colors.green,
                      child: Row(
                        children: [
                          Container(
                              width: 52.w,
                              child: Text('证件',style: TextStyle(color: const Color(0xFF999999),fontSize: 16.sp),)
                          ),
                          Container(
                            width: 250.w,
                            height: 43.h,
                            child: TextField(
                              controller: cerController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: '请输入姓名',
                                hintStyle: TextStyle(color: const Color(0xFF333333),fontSize: 16.sp),
                              ),
                            ),
                          ),
                        ],
                      )
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
                          child: Text('住院号',style: TextStyle(color: const Color(0xFF999999),fontSize: 16.sp),)
                      ),
                      SizedBox(
                        width: 250.w,
                        height: 43.h,
                        child: TextField(
                          controller: zhuController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: '12345356',
                            hintStyle: TextStyle(color: const Color(0xFF333333),fontSize: 16.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    // color: Colors.green,
                      child: Row(
                        children: [
                          Container(
                              width: 52.w,
                              child: Text('床号',style: TextStyle(color: const Color(0xFF999999),fontSize: 16.sp),)
                          ),
                          Container(
                            width: 250.w,
                            height: 43.h,
                            child: TextField(
                              controller: bedController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: '请输入姓名',
                                hintStyle: TextStyle(color: const Color(0xFF333333),fontSize: 16.sp),
                              ),
                            ),
                          ),
                        ],
                      )
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
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(
                        width: 0.5,
                        color: const Color(0xFF00A8E7),
                      )
                    ),
                    child: TextButton(
                        onPressed: (){

                        },
                        child: Text('取消',style: TextStyle(color: const Color(0xFF00A8E7),fontSize: 18.sp),),
                    ),
                  ),
                  Container(
                    width: 110.w,
                    height: 43.h,
                    decoration: const BoxDecoration(
                      color: Color(0xFF00A8E7),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                    ),
                    child: TextButton(
                      onPressed: (){

                      },
                      child: Text('保存',style: TextStyle(color: const Color(0xFFFFFFFF),fontSize: 18.sp),),
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
