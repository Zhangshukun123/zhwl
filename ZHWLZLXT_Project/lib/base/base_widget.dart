import 'package:flutter/cupertino.dart';

import 'base_widget_state.dart';

abstract class BaseWidget extends StatefulWidget {
  const BaseWidget({super.key});

  @override
  // ignore: no_logic_in_create_state
  BaseWidgetState createState() => getState();

  ///子类实现
  BaseWidgetState getState();
}
