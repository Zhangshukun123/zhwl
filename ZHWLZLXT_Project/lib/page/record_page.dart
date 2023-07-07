import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      appBar: AppBar(
        title: Text('治疗记录',style: TextStyle(fontSize: 18.sp,color: Colors.white),),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 15.w,right: 15.w,top: 10.h),
              width: 930.w,
              height: 55.h,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )
              ),
              child: Row(
                children: [
                  Container(
                    width: 230.w,
                    height: 37.h,
                    margin: EdgeInsets.only(left: 18.w),
                    padding: EdgeInsets.only(left: 10.w),
                    decoration: BoxDecoration(
                        color: const Color(0xFFF5F7F9),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.5.w),
                        )
                    ),
                    child: TextField(
                      controller: searchController,
                      decoration:
                      const InputDecoration(
                          hintText: '请输入',
                          border: InputBorder.none,
                        icon: Icon(Icons.search),
                      ),
                      style:
                      TextStyle(fontSize: 15.sp),
                    ),
                  ),
                  Container(
                    width: 280.w,
                    height: 37.h,
                    margin: EdgeInsets.only(left: 21.w),
                    decoration: BoxDecoration(
                        color: const Color(0xFFF5F7F9),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.5.w),
                        )
                    ),
                    child: TextButton(
                        onPressed: (){},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Image.asset('assets/images/2.0x/icon_riqi.png',fit: BoxFit.fill,width: 14.w,height: 14.h,),
                            Text(' 开始时间 - 结束时间',style: TextStyle(color: const Color(0xFF999999),fontSize: 16.sp),)
                          ]
                        ),
                    ),
                  ),
                  Container(
                    width: 100.w,
                    height: 34.h,
                    margin: EdgeInsets.only(left: 21.w),
                    decoration: BoxDecoration(
                        color: const Color(0xFF1875F0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.w),
                        )
                    ),
                    child: TextButton(
                        onPressed: (){},
                        child: Text('导出当月',style: TextStyle(color: Colors.white,fontSize: 16.sp),)
                    ),
                  ),
                  Container(
                    width: 100.w,
                    height: 34.h,
                    margin: EdgeInsets.only(left: 21.w),
                    decoration: BoxDecoration(
                        color: Color(0xFF1875F0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.w),
                        )
                    ),
                    child: TextButton(
                        onPressed: (){},
                        child: Text('导出当年',style: TextStyle(color: Colors.white,fontSize: 16.sp),)
                    ),
                  ),
                  Container(
                    width: 100.w,
                    height: 34.h,
                    margin: EdgeInsets.only(left: 21.w),
                    decoration: BoxDecoration(
                        color: const Color(0xFF00C290),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.w),
                        )
                    ),
                    child: TextButton(
                        onPressed: (){},
                        child: Text('全部导出',style: TextStyle(color: Colors.white,fontSize: 16.sp),)
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10.h),
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, i){
                      return Container(
                        height: 114.h,
                        margin: EdgeInsets.only(left: 15.w,right: 15.w,top: 10.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.w),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 930.w,
                              height: 50.5.h,
                                child: Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 27.5.w),
                                        child: Text('2022/09/06  12:12:34',style: TextStyle(color: const Color(0xFF333333),fontSize: 17.sp),)
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 42.w),
                                        child: Text('治疗方式：超声疗法',style: TextStyle(color: const Color(0xFF333333),fontSize: 17.sp),)
                                    ),
                                    const Expanded(child: SizedBox()),
                                    Container(
                                      margin: EdgeInsets.only(right: 18.w),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF00A8E7),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.w),
                                        ),
                                      ),
                                      child: TextButton(
                                          onPressed: (){

                                          },
                                          child: Text('导出记录',style: TextStyle(color: const Color(0xFFFFFFFF),fontSize: 16.sp),)
                                      ),
                                    )
                                  ],
                                )
                            ),
                            Container(
                              color: const Color(0xFFDFDFDF),
                                height: 0.5.h,
                                width: 930.w,
                                child: const Text('')
                            ),
                            Container(
                              width: 930.w,
                              height: 53.h,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 27.5.w),
                                        child: Text('模式：断续1',style: TextStyle(color: const Color(0xFF999999),fontSize: 18.sp),)
                                    ),
                                    Text('时间：20min',style: TextStyle(color: const Color(0xFF999999),fontSize: 18.sp),),
                                    Text('功率：1w',style: TextStyle(color: const Color(0xFF999999),fontSize: 18.sp),),
                                    Text('声强：0.3w/c㎡',style: TextStyle(color: const Color(0xFF999999),fontSize: 18.sp),),
                                    Container(
                                        margin: EdgeInsets.only(right: 27.5.w),
                                        child: Text('频率：1MHz',style: TextStyle(color: const Color(0xFF999999),fontSize: 18.sp),)
                                    ),
                                  ],
                                )
                            ),
                          ],
                        ),
                      );
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
