/*
 * @Descripttion: 
 * @version: 
 * @Author: TT
 * @Date: 2022-08-15 14:17:57
 * @LastEditors: TT
 * @LastEditTime: 2022-08-16 10:02:30
 */

import 'package:hzy_normal_widget/hzy_normal_widget.dart';
import 'package:zhwlzlxt_project/page/guide_page.dart';
import 'package:zhwlzlxt_project/page/login_page.dart';
import 'package:zhwlzlxt_project/user/user_manage_page.dart';

class RouterPageId {
  static String login = '/login';
  static String guide = '/guide';
  static String userManage = '/userManage';
}

class RouterS {
  static List<GetPage> getAllRouteS() {
    return [
      GetPage(name: RouterPageId.guide, page: () => const GuidePage()),
      GetPage(name: RouterPageId.login, page: () => const LoginPage()),
      GetPage(name: RouterPageId.userManage, page: () => UserManagePage()),
    ];
  }
}
