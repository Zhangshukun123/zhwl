import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhwlzlxt_project/page/add_page.dart';
import 'package:zhwlzlxt_project/page/record_page.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text('用户管理',style: TextStyle(fontSize: 18.sp,color: Colors.white),),
        actions: <Widget>[
          InkWell(
            onTap: (){
              debugPrint('点击新增用户');
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => const AddPage())
              );
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10,bottom: 10,right: 10),
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
                  SizedBox(width: 5.w,),
                  Image.asset('assets/images/2.0x/icon_xinzeng.png',width: 24.w,height: 24.h,),
                  SizedBox(width: 5.w,),
                  Text('新增用户',style: TextStyle(color: Colors.white,fontSize: 24.sp),),
                  SizedBox(width: 15.w,),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 15.w,right: 10.w,top: 10.h,bottom: 10.h),
          child: Row(
            children: [
              Container(
                width: 295.w,
                  height: 550.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.white,
                        width: 0.5
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.w),
                    ),
                  ),
                  margin: EdgeInsets.only(right: 10.w),
                  child: Column(
                    children: [
                      Container(
                        margin:  EdgeInsets.only(left: 6.w,right: 6.w,top: 10.h,bottom: 10.h),
                        padding:  EdgeInsets.only(left: 60.w,right: 10.w),
                        height: 55.h,
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
                            Image.asset('assets/images/2.0x/icon_sousuo.png',fit:BoxFit.cover,width: 22.w,height: 22.h,),
                            SizedBox(width: 6.w,),
                            SizedBox(
                              width: 180.w,
                              child: TextField(
                                controller: searchController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '请输入姓名、手机号',
                                  hintStyle: TextStyle(color: const Color(0xFF999999),fontSize: 13.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 6.w,right: 6.w),
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
                                margin: EdgeInsets.only(left: 51.w),
                                width: 60.w,
                                child: Text('姓名',style: TextStyle(color: const Color(0xFF999999),fontSize: 16.sp),)
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 20.w),
                                child: Text('电话',style: TextStyle(color: const Color(0xFF999999),fontSize: 16.sp),)
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, i){
                                return Container(
                                  height: 43.h,
                                  margin: EdgeInsets.only(left: 6.w,right: 6.w,top: 10.h),
                                  padding: EdgeInsets.only(left: 0,right: 10.h),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF5F7F9),
                                    border: Border.all(
                                      color: const Color(0xFFF5F7F9),
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.w),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(left: 15.w),
                                          child: InkWell(
                                              onTap: (){
                                                print('$i');
                                              },
                                              child: Image.asset('assets/images/2.0x/icon_xuanzhong.png',fit: BoxFit.cover,width: 18.w,height: 18.h,)
                                          )
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(left: 18.w),
                                          width: 60.w,
                                          child: Text('张三四',style: TextStyle(color: const Color(0xFF333333),fontSize: 16.sp),)
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20.w),
                                          width: 110.w,
                                          child: Text('13212345678',style: TextStyle(color: const Color(0xFF333333),fontSize: 16.sp),)
                                      ),
                                      SizedBox(width: 10.w,),
                                      InkWell(
                                          onTap: (){
                                            print('$i');
                                          },
                                          child: Image.asset('assets/images/2.0x/icon_shanchu.png',fit: BoxFit.cover,width: 14.w,height: 14.h,))
                                      ,
                                    ],
                                  ),
                                );
                              }
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              Container(
                width: 610.w,
                  height: 550.h,
                  margin: EdgeInsets.only(left: 10.w,right: 10.w),
                  padding: EdgeInsets.only(top: 40.h,left: 20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.white,
                        width: 0.5
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15.w)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  width: 60.w,
                                  child: Text('编号',style: TextStyle(color: const Color(0xFF999999),fontSize: 16.sp),)
                              ),
                              Container(
                                  width: 220.w,
                                  height: 43.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.5,
                                      color: const Color(0xFFDBDBDB),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(7.w)),
                                  ),
                                  child: TextField(
                                    controller: numController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '12345355',
                                      hintStyle: TextStyle(color: const Color(0xFF333333),fontSize: 18.sp),
                                      enabled: isEdit ? false : true,
                                    ),
                                  )
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width: 40.w,
                                  child: Text('姓名',style: TextStyle(color: const Color(0xFF999999),fontSize: 16.sp),)
                              ),
                              Container(
                                  width: 220.w,
                                  height: 43.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.5,
                                      color: const Color(0xFFDBDBDB),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(7.w)),
                                  ),
                                  child: TextField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '张三四',
                                      hintStyle: TextStyle(color: const Color(0xFF333333),fontSize: 18.sp),
                                      enabled: isEdit ? false : true,
                                    ),
                                  )
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
                                  width: 60.w,
                                  child: Text('年龄',style: TextStyle(color: const Color(0xFF999999),fontSize: 16.sp),)
                              ),
                              Container(
                                  width: 220.w,
                                  height: 43.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.5,
                                      color: const Color(0xFFDBDBDB),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(7.w)),
                                  ),
                                  child: TextField(
                                    controller: ageController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '20',
                                      hintStyle: TextStyle(color: const Color(0xFF333333),fontSize: 18.sp),
                                      enabled: isEdit ? false : true,
                                    ),
                                  )
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width: 60.w,
                                  child: Text('性别',style: TextStyle(color: const Color(0xFF999999),fontSize: 16.sp),)
                              ),
                              Container(
                                  width: 220.w,
                                  height: 43.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.5,
                                      color: const Color(0xFFDBDBDB),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(7.w)),
                                  ),
                                  child: TextField(
                                    controller: ageController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '男',
                                      hintStyle: TextStyle(color: const Color(0xFF333333),fontSize: 18.sp),
                                      enabled: isEdit ? false : true,
                                    ),
                                  )
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
                                  width: 60.w,
                                  child: Text('电话',style: TextStyle(color: const Color(0xFF999999),fontSize: 16.sp),)
                              ),
                              Container(
                                  width: 220.w,
                                  height: 43.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.5,
                                      color: const Color(0xFFDBDBDB),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(7.w)),
                                  ),
                                  child: TextField(
                                    controller: ageController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '13212345678',
                                      hintStyle: TextStyle(color: const Color(0xFF333333),fontSize: 18.sp),
                                      enabled: isEdit ? false : true,
                                    ),
                                  )
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width: 40.w,
                                  child: Text('证件',style: TextStyle(color: const Color(0xFF999999),fontSize: 16.sp),)
                              ),
                              Container(
                                  width: 220.w,
                                  height: 43.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.5,
                                      color: const Color(0xFFDBDBDB),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(7.w)),
                                  ),
                                  child: TextField(
                                    controller: ageController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '13212345678',
                                      hintStyle: TextStyle(color: const Color(0xFF333333),fontSize: 18.sp),
                                      enabled: isEdit ? false : true,
                                    ),
                                  )
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
                                  width: 60.w,
                                  child: Text('住院号',style: TextStyle(color: const Color(0xFF999999),fontSize: 16.sp),)
                              ),
                              Container(
                                  width: 220.w,
                                  height: 43.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.5,
                                      color: const Color(0xFFDBDBDB),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(7.w)),
                                  ),
                                  child: TextField(
                                    controller: ageController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '13212345678',
                                      hintStyle: TextStyle(color: const Color(0xFF333333),fontSize: 18.sp),
                                      enabled: isEdit ? false : true,
                                    ),
                                  )
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width: 40.w,
                                  child: Text('床号',style: TextStyle(color: const Color(0xFF999999),fontSize: 16.sp),)
                              ),
                              Container(
                                  width: 220.w,
                                  height: 43.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.5,
                                      color: const Color(0xFFDBDBDB),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(7.w)),
                                  ),
                                  child: TextField(
                                    controller: ageController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '13212345678',
                                      hintStyle: TextStyle(color: const Color(0xFF333333),fontSize: 18.sp),
                                      enabled: isEdit ? false : true,
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 40.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                height: 43.h,
                                width: 110.w,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5,
                                    color: const Color(0xFF00A8E7),
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(7.w)),
                                ),
                                child: TextButton(
                                    onPressed: (){
                                      isEdit = !isEdit;
                                      setState(() {

                                      });

                                    },
                                    child: Text(isEdit ? '编辑信息' : '取消',style: TextStyle(color: const Color(0xFF00A8E7),fontSize: 18.sp),),
                                )
                            ),
                            Visibility(
                              visible: isEdit ? true : false,
                              /// 隐藏时是否保持占位
                              maintainState: false,
                              /// 隐藏时是否保存动态状态
                              maintainAnimation: false,
                              /// 隐藏时是否保存子组件所占空间的大小，不会消耗过多的性能
                              maintainSize: false,
                              child: Container(
                                  height: 43.h,
                                  width: 110.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF00A8E7),
                                    border: Border.all(
                                      width: 0.5,
                                      color: const Color(0xFF00A8E7),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(7.w)),
                                  ),
                                  child: TextButton(
                                      onPressed: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (BuildContext context) => const RecordPage())
                                        );
                                      },
                                      child: Text('治疗记录',style: TextStyle(color: const Color(0xFFFFFFFF),fontSize: 18.sp),))
                              ),
                            ),
                            Container(
                                height: 43.h,
                                width: 110.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF00C290),
                                  border: Border.all(
                                    width: 0.5,
                                    color: const Color(0xFF00C290),
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(7.w)),
                                ),
                                child: TextButton(
                                    onPressed: (){

                                    },
                                    child: Text(isEdit ?'开始治疗' : '保存',style: TextStyle(color: const Color(0xFFFFFFFF),fontSize: 18.sp),))
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
