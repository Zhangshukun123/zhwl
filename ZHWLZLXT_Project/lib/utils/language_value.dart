import 'package:get/get_navigation/src/root/internacionalization.dart';

import '../base/globalization.dart';

class LanguageValue extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": {
          Globalization.login: "login",
          Globalization.setting: "setting",
        },
        "zh_CN": {
          Globalization.login: "登录",
          Globalization.setting: "设置",
        }
      };
}
