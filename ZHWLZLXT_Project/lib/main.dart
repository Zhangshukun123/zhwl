import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:zhwlzlxt_project/page/splash_screen.dart';

import 'Controller/serial_port.dart';
import 'base/globalization.dart';
import 'cofig/AnpConfig.dart';
import 'cofig/routes.dart';
import 'dataResource/tables_init.dart';
import 'utils/language_value.dart';
import 'utils/sp_utils.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
late final bool languageSelected;

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await _initThirdParty();
  await SpUtils.getInstance();

  languageSelected = SpUtils.getBool(Globalization.languageSelected, defaultValue: true)!;
   AnpConfig.init();
  await _setBrightness();
  runApp(const MyApp());
  await _initSplash();
}

/// 初始化第三方库
Future<void> _initThirdParty() async {
  await TablesInit().init();
  EasyLoading.instance.displayDuration = const Duration(milliseconds: 1500);
}

/// 延迟移除启动图
Future<void> _initSplash() async {
  // await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
}

/// 设置屏幕亮度
Future<void> _setBrightness() async {
  try {
    final brightness = SpUtils.getDouble('sliderValue', defaultValue: 100)! / 100;
    await ScreenBrightness().setScreenBrightness(brightness);
  } catch (e, s) {
    debugPrint('⚠️ Failed to set brightness: $e\n$s');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(960, 600),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          navigatorKey: navigatorKey,
          initialRoute: RouterPageId.guide,
          translations: LanguageValue(),
          locale: languageSelected ? const Locale('zh', 'CN') : const Locale('en', 'US'),
          fallbackLocale: languageSelected ? const Locale('en') : const Locale('zh'),
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
          theme: ThemeData(primarySwatch: Colors.blue),
          builder: EasyLoading.init(
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            ),
          ),
        );
      },
    );
  }
}
