import 'package:zhwlzlxt_project/Controller/serial_msg.dart';

import '../entity/port_data.dart';

class SerialPort {
  factory SerialPort() => _instance;

  SerialPort._internal();

  static final SerialPort _instance = SerialPort._internal();

  void send(String data) {
    SerialMsg().sendData(data);
    //android 串口  、
  }
}
