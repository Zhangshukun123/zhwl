

import 'package:flutter/material.dart';
import 'package:hzy_normal_widget/hzy_normal_widget.dart';
import 'common_getx_controller.dart';

abstract class CommonGetXWidget<T extends CommonGetXController>
    extends NormaGetxView<T> {
  CommonGetXWidget({Key? key}) : super(key: key);

  @override
  PageState get pageState => controller.pageState.value;

  /// 创建失败 界面
  @override
  Widget? createErrorWidget() {
    return null;
  }

  @override
  Color? createLeadingIconColor() {
    return CommentColorS.col000000;
  }

  @override
  Color? createAppBarTextColor() {
    return CommentColorS.col000000;
  }
}
