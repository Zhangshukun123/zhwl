import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhwlzlxt_project/base/base_widget.dart';
import 'package:zhwlzlxt_project/base/base_widget_state.dart';

class UserManagePage extends BaseWidget {
  const UserManagePage({Key? key}) : super(key: key);

  @override
  BaseWidgetState getState() {
    return _UserManagePageState();
  }
}

class _UserManagePageState extends BaseWidgetState<UserManagePage> {
  @override
  Widget buildView() {
    return Column(
      children: [titleWidget(), homeWidget()],
    );
  }

  Widget titleWidget() {
    return Container(
      height: 20.h,
      color: Colors.red,
    );
  }

  Widget homeWidget() {
    return Container();
  }
}
