import 'dart:convert';
import 'dart:core';

import 'package:common_utils/common_utils.dart';
import 'package:date_format/date_format.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/entity/port_data.dart';
import 'package:zhwlzlxt_project/entity/record_entity.dart';
import 'package:zhwlzlxt_project/entity/user_entity.dart';

import '../Controller/serial_port.dart';
import '../Controller/treatment_controller.dart';
import '../base/globalization.dart';
import '../dataResource/record_sql_dao.dart';

class PulsedField {
  static String PulsedKey = "PulsedKey"; // 存储 -key
  static String userId = "userId";
  static String power = "power"; //强度
  static String frequency = "frequency"; //频率
  static String time = "time"; //时间
}

class Pulsed {
  int? userId;
  String? time;
  String? power;
  String? frequency;

  Pulsed({
    this.userId,
    this.time,
    this.power,
    this.frequency,
  });

  init(bool isSave) {
    if(isSave){
      save();
    }
    time = '20';
    power = '0';
    frequency = '20';
  }

  factory Pulsed.fromJson(String str) => Pulsed.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pulsed.fromMap(Map<String, dynamic> json) => Pulsed(
        userId: json[PulsedField.userId],
        time: json[PulsedField.time],
        power: json[PulsedField.power],
        frequency: json[PulsedField.frequency],
      );

  Map<String, dynamic> toMap() => {
        PulsedField.userId: userId,
        PulsedField.time: time,
        PulsedField.power: power,
        PulsedField.frequency: frequency,
      };

  DateTime? startTime;
  DateTime? endTime;

  num zdTime = 0;

  DateTime? zdStartTime;
  DateTime? zdEndTime;

  User? user;

  String? settIngTime;
  bool? isStart;

  bool start(bool isStart, bool isOpen) {
    this.isStart = isStart;
    if (isStart) {
      settIngTime = time;
      startTime = DateTime.now();
    }

    // final TreatmentController controller = Get.find();
    // if (controller.user.value.userId == 0 ||
    //     controller.user.value.userId == null) {
    //   Fluttertoast.showToast(
    //       msg: '请选择用户', fontSize: 22, backgroundColor: Colors.blue);
    //   return false;
    // }
    // AB BA 01 03(04) 03(04) 01 01 12 36 60 XX XX XX CRCH CRCL
    String data = BYTE00_RW.B01; // 00
    data = "$data ${BYTE01_MD.B02}"; // byt01 功能模块    01
    data = "$data 00"; //02

    //此处解决磁疗的开始和停止按钮命令反的问题 09。06李建成提出
    if (isStart) {
      // 03
      data = "$data ${BYTE03_STOP.B01}";
    } else {
      data = "$data ${BYTE03_STOP.B02}";
    }
    //04
    if (TextUtil.isEmpty(frequency)) {
      frequency = '20';
    }
    //频率发送的数据  需要将10进制的数据转换成16进制数据
    var value = double.tryParse(frequency!);
    //转成16进制数据
    var tmpS = value?.toInt().toRadixString(16);
    if (tmpS!.length > 1) {
      data = "$data $tmpS"; // 04
    } else {
      data = "$data 0$tmpS"; // 04
    }

    // // data = "$data $frequency";
    // data = "$data ${(double.tryParse(frequency!))?.toInt()}";

    if (TextUtil.isEmpty(time)) {
      time = '1';
    }
    // data = "$data $time"; // 05
    // data = "$data ${(double.tryParse(time!))?.toInt()}";
    //转成double类型数据
    var timeValue = double.tryParse(time!);
    //转成16进制数据
    var timeTmps = timeValue?.toInt().toRadixString(16);
    //以16进制数据发送
    if (timeTmps!.length > 1) {
      data = "$data $timeTmps";
    } else {
      data = "$data 0$timeTmps";
    }

    if (TextUtil.isEmpty(power)) {
      power = '0';
    }
    // data = "$data $power"; // 06
    // data = "$data ${(double.tryParse(power!))?.toInt()}";
    //转成double类型数据
    var powerValue = double.tryParse(power!);

    if (!isStart) {
      powerValue = 0;
    }

    //转成16进制数据
    var powerTmps = powerValue?.toInt().toRadixString(16);
    //以16进制数据发送
    if (powerTmps!.length > 1) {
      data = "$data $powerTmps";
    } else {
      data = "$data 0$powerTmps";
    }

    data = "$data ${isOpen ? '01' : '00'}";
    data = "$data 00"; // 08
    data = "$data 00"; // 09
    data = "$data 00"; // 10
    if (!isOpen) {
      if (zdStartTime != null) {
        zdEndTime = DateTime.now();
        Duration diff = zdEndTime!.difference(zdStartTime!);
        if (diff.inMinutes >= 1) {
          zdTime = diff.inMinutes + zdTime;
        }
      }
    } else {
      zdStartTime = DateTime.now();
      zdTime=1;
    }

    SerialPort().send(data);
    return isStart;
  }

  void save() {
    print("--------${(user != null && user?.userId != 0)}");
    print("--------${isStart}");
    if (user != null && user?.userId != 0) {
        endTime = DateTime.now();
        String min = '';
        Duration diff = endTime!.difference(startTime!);
        if (diff.inMinutes == 0) {
          min = '1';
        } else {
          min = '${diff.inMinutes}';
        }
        // 存储信息 结束
        Record record = Record(
          userId: user?.userId,
          dataTime: formatDate(DateTime.now(),
              [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]),
          utilityTime: settIngTime,
          recordType: Globalization.pulse.tr,
          strengthGrade: power,
          actionTime: min,
          frequency: frequency,
          zdTime: zdTime.toString(),
        );
        RecordSqlDao.instance().addData(record: record);
        zdTime = 0;
    }
  }
}
