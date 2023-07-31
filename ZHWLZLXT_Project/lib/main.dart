import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:zhwlzlxt_project/page/login_page.dart';
import 'package:zhwlzlxt_project/utils/language_value.dart';

import 'cofig/routes.dart';
import 'dataResource/tables_init.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initThirdParty();
  runApp(const MyApp());
}

initThirdParty() async {
  await TablesInit().init();
  EasyLoading.instance.displayDuration = const Duration(
    milliseconds: 1500,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(960, 600),
      scaleByHeight: false,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GestureDetector(
          child: GetMaterialApp(
            initialRoute: RouterPageId.login,
            translations: LanguageValue(),
            locale: const Locale('zh', 'CN'),
            fallbackLocale: const Locale('en', 'US'),
            getPages: RouterS.getAllRouteS(),
            defaultTransition: Transition.noTransition,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            builder: (context, child) => MediaQuery(
              //设置文字大小不随系统设置改变
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: EasyLoading.init()(context, child),
            ),
          ),
        );
      },
    );
  }
}
