import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteDialog{
  void showDeleteDialog(BuildContext context){
    showDialog(
        barrierDismissible: true, //表示点击灰色背景的时候是否消失弹出框
        context: context,
        builder: (BuildContext context){
          return Dialog(
            child: Container(
              width: 400.w,
              height: 280.h,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  )),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 43.5.h),
                      child: Image.asset('assets/images/2.0x/img_tishi.png',fit: BoxFit.fitWidth,width: 54.w,height: 48.h,)
                  ),
                  Container(
                    height: 20.h,
                    margin: EdgeInsets.only(top: 34.h),
                      child: Text('确定删除当前用户吗？',style: TextStyle(fontSize: 18.sp,color: const Color(0xFF000000)),)
                  ),
                  Container(
                    height: 15.h,
                    margin: EdgeInsets.only(top: 18.h),
                      child: Text('删除后无法恢复当前用户的信息',style: TextStyle(fontSize: 13.sp,color: const Color(0xFF999999)),)
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
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                            child: Text('取消',style: TextStyle(color: const Color(0xFF00A8E7),fontSize: 18.sp),),
                          )
                      ),
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
                              onPressed: (){

                              },
                              child: Text('确定',style: TextStyle(color: const Color(0xFFFFFFFF),fontSize: 18.sp),))
                      ),
                    ],
                  ),

                ],
              ),
            ),
          );
        },
    );
  }
}