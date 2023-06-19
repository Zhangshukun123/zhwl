import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zhwlzlxt_project/user/user_manage_controller.dart';
import '../common/common_getx_widget.dart';

class UserManagePage extends CommonGetXWidget<UserManageController> {
  UserManagePage({super.key});

  @override
  Widget createBody(BuildContext context) {
    // todo  用户界面
    return const Text("用户界面");
  }
}
