import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:zhwlzlxt_project/page/function_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool setSelected = true;
  TextEditingController acController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: Container(
        width: 960.w,
        height: 600.h,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/2.0x/welcome_bg.png'),
          fit: BoxFit.fill, // 完全填充
        )),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  width: 850.w,
                  height: 500.h,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      )),
                  // margin: EdgeInsets.only(
                  //     left: 55.w, right: 55.w, top: 50.h, bottom: 2.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 44.h, left: 27.w),
                                child: Image.asset(
                                  'assets/images/2.0x/login_logo.png',
                                  fit: BoxFit.fitHeight,
                                  height: 45.h,
                                )),
                            Expanded(
                              child: Container(
                                transform:
                                    Matrix4.translationValues(0, -30.h, 0),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/img_shebei.png',
                                        fit: BoxFit.fitHeight,
                                        height: 321.h,
                                      ),
                                      SizedBox(
                                        height: 17.h,
                                      ),
                                      Text(
                                        '综合物理治疗系统',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            color: const Color(0xFF999999)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color(0xFFF5F7F9),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              )),
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 79.h),
                                  child: Text(
                                    '登录',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        color: const Color(0xFF242021)),
                                  )),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 33.w, right: 33.w),
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(7),
                                              )),
                                          padding: EdgeInsets.all(5.h),
                                          child: Row(
                                            children: [
                                              SizedBox(width: 32.w),
                                              Image.asset(
                                                'assets/images/2.0x/login_account.png',
                                                fit: BoxFit.fitHeight,
                                                height: 18.w,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Expanded(
                                                child: TextField(
                                                  controller: acController,
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText: '请输入用户名',
                                                          border:
                                                              InputBorder.none),
                                                  style: TextStyle(
                                                      fontSize: 15.sp),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30.h,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 33.w, right: 33.w),
                                          padding: EdgeInsets.all(5.h),
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(7),
                                              )),
                                          child: Row(
                                            children: [
                                              SizedBox(width: 32.w),
                                              Image.asset(
                                                'assets/images/2.0x/login_pwd.png',
                                                fit: BoxFit.fitHeight,
                                                height: 18.w,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Expanded(
                                                child: TextField(
                                                  controller: pwdController,
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: '请输入密码',
                                                    border: InputBorder.none,
                                                  ),
                                                  style: TextStyle(
                                                      fontSize: 15.sp),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 48.w),
                                          child: //自定义button
                                              TextButton(
                                                  onPressed: () {
                                                    setSelected = !setSelected;
                                                    setState(() {
                                                      //刷新状态
                                                    });
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Image.asset(
                                                        setSelected
                                                            ? 'assets/images/2.0x/icon_btn_nor.png'
                                                            : 'assets/images/2.0x/icon_btn_sel.png',
                                                        height: 18.h,
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                      SizedBox(
                                                        width: 3.w,
                                                      ),
                                                      Text(
                                                        "记住密码",
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xFF999999),
                                                            fontSize: 18.sp),
                                                      )
                                                    ],
                                                  )),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 32.w,
                                        right: 32.w,
                                      ),
                                      padding: EdgeInsets.all(5.h),
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                          color: Color(0xFF00A8E7),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          )),
                                      child: TextButton(
                                          onPressed: () {
                                            print('点击确定按钮');
                                            print(acController.text);
                                            print(pwdController.text);
                                            Get.to(const FunctionPage());

                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder:
                                            //             (BuildContext context) =>
                                            //                 ));
                                          },
                                          child: Text(
                                            '确定',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.sp),
                                          )),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
              child: Text(
                '当前版本号：v1.0',
                style: TextStyle(fontSize: 18.sp, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
