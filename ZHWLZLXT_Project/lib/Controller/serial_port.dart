import '../entity/port_data.dart';

class SerialPort {
  factory SerialPort() => _instance;

  SerialPort._internal();

  static final SerialPort _instance = SerialPort._internal();

  void send(String data) {
    String buffer = '${PortData.FH} $data ${PortData.FE}';
    print('-------send------------$buffer;');


    //android 串口  、

  }
}
