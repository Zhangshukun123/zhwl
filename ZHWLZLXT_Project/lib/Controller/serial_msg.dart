import 'package:flutter/services.dart';

class SerialMsg {
  // _channel 是通道的实例，package_manager 是自定义的通道名称
  // ignore: unnecessary_const
  static const MethodChannel _channel = const MethodChannel("serialMsg_manager");

  // 根据传入的包名安装 App
  // 注：方法名install和invokeMethod中的参数install不是要一定相同，这里相同是为了方便一眼看出函数的功能
  Future<bool> sendData() async {
    // sendData 调用方法的名称，com.example.zhwlzlxt_project 应用包名
    bool res = await _channel.invokeMethod("sendData", "com.example.zhwlzlxt_project");
    return res;
  }
}

