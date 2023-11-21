import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:zhwlzlxt_project/utils/language_value.dart';
import 'package:zhwlzlxt_project/utils/sp_utils.dart';

import 'base/globalization.dart';
import 'cofig/AnpConfig.dart';
import 'cofig/routes.dart';
import 'dataResource/tables_init.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

var languageSelected = true;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initThirdParty();
  await SpUtils.getInstance();

  languageSelected =
      SpUtils.getBool(Globalization.languageSelected, defaultValue: true)!;
  //原生的启动图页面方法
  WidgetsFlutterBinding.ensureInitialized();

  initialization(null);
  AnpConfig.init();
  setBrightness(SpUtils.getDouble('sliderValue', defaultValue: 100)! / 100);
  runApp(const MyApp());
}

Future<void> setBrightness(double brightness) async {
  try {
    await ScreenBrightness().setScreenBrightness(brightness);
  } catch (e) {
    print(e);
    throw 'Failed to set brightness';
  }
}
//启动图延时移除方法
void initialization(BuildContext? context) async {
  //延迟3秒
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
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
                ? const Locale('en', '')
                : const Locale('zh', ''),
            getPages: RouterS.getAllRouteS(),
            defaultTransition: Transition.noTransition,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('zh', 'CN'),
              Locale('en', 'US'),
            ],
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
