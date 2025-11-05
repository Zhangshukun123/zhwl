import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/page/function_page.dart';
import 'package:zhwlzlxt_project/utils/sp_utils.dart';
import 'package:zhwlzlxt_project/utils/utils_tool.dart';

import '../base/globalization.dart';
import '../cofig/AnpConfig.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController acController = TextEditingController(text: 'admin');
  final TextEditingController pwdController = TextEditingController(text: '688626');
  bool rememberAccount = SpUtils.getBool('setSelected', defaultValue: false)!;
  bool showDebugVersion = false;

  @override
  void initState() {
    super.initState();
    _initSystemUI();
    _restoreSavedCredentials();
  }

  Future<void> _initSystemUI() async {
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  void _restoreSavedCredentials() {
    if (rememberAccount) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        acController.text = SpUtils.getString('account', defaultValue: '')!;
        pwdController.text = SpUtils.getString('password', defaultValue: '')!;
        setState(() {});
      });
    }
  }

  void _handleLogin() {
    if (AccList.contains(acController.text) && PswLIst.contains(pwdController.text)) {
      if (rememberAccount) {
        SpUtils.setString('account', acController.text);
        SpUtils.setString('password', pwdController.text);
        SpUtils.setBool('setSelected', rememberAccount);
      }
      Get.off(const FunctionPage());
    } else {
      showToastMsg(msg: Globalization.hint_018.tr);
    }
  }

  Widget _buildInputField({
    required String hintText,
    required String iconPath,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 33.w),
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
        color: const Color(0xffF4F4F4),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          SizedBox(width: 32.w),
          Image.asset(iconPath, height: 18.w, fit: BoxFit.fitHeight),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              style: TextStyle(fontSize: 15.sp),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.w),
      padding: EdgeInsets.all(5.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF403B5B),
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextButton(
        onPressed: _handleLogin,
        child: Text(
          Globalization.confirm.tr,
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0XFFF4F4F4),
      body: Container(
        width: 960.w,
        height: 600.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/img_denglu.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Container(
                  width: 850.w,
                  height: 500.h,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 44.h, left: 27.w),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Image.asset(
                                  'assets/images/2.0x/login_logo.png',
                                  height: 22.h,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              const Spacer(),
                              Image.asset(
                                'assets/images/img_shebei.png',
                                height: 321.h,
                              ),
                              SizedBox(height: 17.h),
                              Text(
                                Globalization.theme.tr,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: const Color(0xFF666666),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                      // 右侧登录表单区
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height: 79.h),
                            Text(
                              Globalization.login.tr,
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: const Color(0xFF242021),
                              ),
                            ),
                            SizedBox(height: 60.h),
                            _buildInputField(
                              hintText: Globalization.userName.tr,
                              iconPath: 'assets/images/2.0x/login_account.png',
                              controller: acController,
                            ),
                            SizedBox(height: 60.h),
                            _buildInputField(
                              hintText: Globalization.password.tr,
                              iconPath: 'assets/images/2.0x/login_pwd.png',
                              controller: pwdController,
                              obscureText: true,
                            ),
                            SizedBox(height: 70.h),
                            _buildLoginButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 底部版本信息
            Padding(
              padding: EdgeInsets.only(left: showDebugVersion ? 280.w : 340.w, top: 0.h, bottom: 10.h),
              child: InkWell(
                onTap: () => setState(() => showDebugVersion = !showDebugVersion),
                child: Row(
                  children: [
                    Text(
                      showDebugVersion
                          ? '${Globalization.version.tr}:V1.0.0,20251030_alpha01'
                          : '${Globalization.version.tr}:V1.0.0.1',
                      style: TextStyle(fontSize: 11.sp, color: const Color(0xFF999999)),
                    ),
                    const SizedBox(width: 100),
                    Text(
                      showDebugVersion
                          ? '${Globalization.version_1.tr}:V1.0.0,20251030_alpha01'
                          : '${Globalization.version_1.tr}:V1.0.0.1',
                      style: TextStyle(fontSize: 11.sp, color: const Color(0xFF999999)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
