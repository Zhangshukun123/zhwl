import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zhwlzlxt_project/page/login_page.dart';
import 'package:zhwlzlxt_project/utils/language_value.dart';
import 'package:zhwlzlxt_project/utils/sp_utils.dart';

import 'base/globalization.dart';
import 'cofig/routes.dart';
import 'dataResource/tables_init.dart';

var languageSelected = true;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initThirdParty();
  await SpUtils.getInstance();

  languageSelected =
      SpUtils.getBool(Globalization.languageSelected, defaultValue: true)!;

  runApp(const MyApp());
}

initThirdParty() async {
  await TablesInit().init();
  EasyLoading.instance.displayDuration = const Duration(
    milliseconds: 1500,
  );
}

// ignore: must_be_immutable
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
            locale: languageSelected
                ? const Locale('zh', 'CN')
                : const Locale('en', 'US'),
            fallbackLocale: languageSelected
                ? const Locale('en', 'US')
                : const Locale('zh', 'CN'),
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
