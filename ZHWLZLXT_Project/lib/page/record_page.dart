import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:date_format/date_format.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zhwlzlxt_project/dataResource/record_sql_dao.dart';
import 'package:zhwlzlxt_project/page/table_calender.dart';

import '../base/globalization.dart';
import '../entity/record_entity.dart';

// ignore: must_be_immutable
class RecordPage extends StatefulWidget {
  int? userId;
  String? userName;

  RecordPage(this.userId, this.userName, {Key? key}) : super(key: key);

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  TextEditingController searchController = TextEditingController();

  List<Record> records = [];
  List<Record> recordsList = [];

  String startTimeDate = '开始时间';
  String endTimeDate = '结束时间';
  var excel = Excel.createExcel();

  @override
  void initState() {
    super.initState();
    if (widget.userId == null || widget.userId == 0) {
      Fluttertoast.showToast(msg: '获取用户信息错误，请退出重新登录！');
      Get.back();
      return;
    }

    RecordSqlDao.instance()
        .queryRecordForUserId(userId: widget.userId!)
        .then((value) => {RecordForJson(value)});

    searchController.addListener(() {
      if (TextUtil.isEmpty(searchController.text)) {
        recordsList.clear();
        recordsList.addAll(records.reversed.toList());
      } else {
        recordsList.clear();
        for (var element in records) {
          if (element.recordType.toString().startsWith(searchController.text)) {
            recordsList.add(element);
          }
        }
      }
      setState(() {});
    });
  }

  // ignore: non_constant_identifier_names
  void RecordForJson(value) {
    if (!mounted) {
      return;
    }
    records.clear();
    for (var map in value) {
      records.add(Record.fromMap(map));
    }
    print("-----------${records[records.length-1].toMap().toString()}");
    recordsList.addAll(records.reversed.toList());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      // appBar: AppBar(
      //   title: Text(
      //     '治疗记录',
      //     style: TextStyle(fontSize: 18.sp, color: Colors.white),
      //   ),
      // ),
      appBar: AppBar(
        automaticallyImplyLeading : false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 80.w,
              height: 30.h,
              decoration: BoxDecoration(
                  color: const Color(0xFF19B1E9),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.w),
                  )
              ),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 10.w,),
                    Image.asset('assets/images/2.0x/btn_fanhui.png',width: 14.w,height: 14.h,fit: BoxFit.fitWidth,),
                    Text(
                      '返回',
                      style: TextStyle(fontSize: 18.sp),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                  child: Text(Globalization.treatmentRecords.tr,style: TextStyle(fontSize: 18.sp, color: Colors.white),)
              ),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
              width: 930.w,
              height: 55.h,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
              child: Row(
                children: [
                  Container(
                    width: 230.w,
                    height: 37.h,
                    margin: EdgeInsets.only(left: 18.w),
                    padding: EdgeInsets.only(left: 10.w),
                    decoration: BoxDecoration(
                        color: const Color(0xFFF5F7F9),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.5.w),
                        )),
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: '请输入治疗方式',
                        border: InputBorder.none,
                        icon: Icon(Icons.search),
                      ),
                      style: TextStyle(fontSize: 15.sp),
                    ),
                  ),
                  Container(
                    width: 280.w,
                    height: 37.h,
                    margin: EdgeInsets.only(left: 21.w),
                    decoration: BoxDecoration(
                        color: const Color(0xFFF5F7F9),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.5.w),
                        )),
                    child: TextButton(
                      onPressed: () {
                        _showDialog(this.context);
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/2.0x/icon_riqi.png',
                              fit: BoxFit.fill,
                              width: 14.w,
                              height: 14.h,
                            ),
                            Text(
                              ' $startTimeDate - $endTimeDate',
                              style: TextStyle(
                                  color: const Color(0xFF999999),
                                  fontSize: 16.sp),
                            )
                          ]),
                    ),
                  ),
                  Container(
                    width: 100.w,
                    height: 34.h,
                    margin: EdgeInsets.only(left: 21.w),
                    decoration: BoxDecoration(
                        color: const Color(0xFF1875F0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.w),
                        )),
                    child: TextButton(
                        onPressed: () async {
                          var status = await requestCalendarPermission();
                          if (status) {
                            Sheet sheetObject = excel['Sheet1'];
                            exportXlm(1, sheetObject);
                            var fileBytes = excel.save();
                            // var directory = await getExternalStorageDirectory();
                            String path =
                                "/storage/emulated/0/用户记录/${widget.userName}/${formatDate(DateTime.now(), [
                                  yyyy,
                                  '-',
                                  mm,
                                  '-',
                                  dd
                                ])}/${formatDate(DateTime.now(), [
                                  HH,
                                  nn,
                                  ss
                                ])}.xlsx";
                            File(join(path))
                              ..createSync(recursive: true)
                              ..writeAsBytesSync(fileBytes!);
                            EasyLoading.dismiss();
                            Fluttertoast.showToast(
                                msg: '导出成功，导出文件$path',
                                toastLength: Toast.LENGTH_LONG);
                          } else {
                            Fluttertoast.showToast(msg: '获取权限失败，请打开内部存储权限');
                          }
                        },
                        child: Text(
                          '导出当月',
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp),
                        )),
                  ),
                  Container(
                    width: 100.w,
                    height: 34.h,
                    margin: EdgeInsets.only(left: 21.w),
                    decoration: BoxDecoration(
                        color: const Color(0xFF1875F0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.w),
                        )),
                    child: TextButton(
                        onPressed: () async {
                          var status = await requestCalendarPermission();
                          if (status) {
                            Sheet sheetObject = excel['Sheet1'];
                            exportXlm(2, sheetObject);
                            var fileBytes = excel.save();
                            var directory = await getExternalStorageDirectory();
                            // print('-------${directory?.path}');
                            String path =
                                "/storage/emulated/0/用户记录/${widget.userName}/${formatDate(DateTime.now(), [
                                  yyyy,
                                  '-',
                                  mm,
                                  '-',
                                  dd
                                ])}/${formatDate(DateTime.now(), [
                                  HH,
                                  nn,
                                  ss
                                ])}.xlsx";
                            File(join(path))
                              ..createSync(recursive: true)
                              ..writeAsBytesSync(fileBytes!);
                            EasyLoading.dismiss();
                            Fluttertoast.showToast(
                                msg: '导出成功，导出文件$path',
                                toastLength: Toast.LENGTH_LONG);
                          } else {
                            Fluttertoast.showToast(msg: '获取权限失败，请打开内部存储权限');
                          }
                        },
                        child: Text(
                          '导出当年',
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp),
                        )),
                  ),
                  Container(
                    width: 100.w,
                    height: 34.h,
                    margin: EdgeInsets.only(left: 21.w),
                    decoration: BoxDecoration(
                        color: const Color(0xFF00C290),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.w),
                        )),
                    child: TextButton(
                        onPressed: () async {
                          var status = await requestCalendarPermission();
                          if (status) {
                            Sheet sheetObject = excel['Sheet1'];
                            exportXlm(3, sheetObject);
                            var fileBytes = excel.save();
                            // var directory = await getExternalStorageDirectory();
                            String path =
                                "/storage/emulated/0/用户记录/${widget.userName}/${formatDate(DateTime.now(), [
                                  yyyy,
                                  '-',
                                  mm,
                                  '-',
                                  dd
                                ])}/${formatDate(DateTime.now(), [
                                  HH,
                                  nn,
                                  ss
                                ])}.xlsx";
                            File(join(path))
                              ..createSync(recursive: true)
                              ..writeAsBytesSync(fileBytes!);
                            EasyLoading.dismiss();
                            Fluttertoast.showToast(
                                msg: '导出成功，导出文件$path',
                                toastLength: Toast.LENGTH_LONG);
                          } else {
                            Fluttertoast.showToast(msg: '获取权限失败，请打开内部存储权限');
                          }
                        },
                        child: Text(
                          '全部导出',
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp),
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10.h),
                child: ListView.builder(
                    itemCount: recordsList.length,
                    itemBuilder: (context, i) {
                      return Container(
                        // height: 114.h,
                        margin:
                            EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.w),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                                width: double.infinity,
                                height: 50.5.h,
                                child: Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 27.5.w),
                                        child: Text(
                                          recordsList[i].dataTime ?? '',
                                          style: TextStyle(
                                              color: const Color(0xFF333333),
                                              fontSize: 17.sp),
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(left: 42.w),
                                        child: Text(
                                          '治疗方式：${recordsList[i].recordType}',
                                          style: TextStyle(
                                              color: const Color(0xFF333333),
                                              fontSize: 17.sp),
                                        )),
                                    const Expanded(child: SizedBox()),
                                    Container(
                                      margin: EdgeInsets.only(right: 18.w),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF00A8E7),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.w),
                                        ),
                                      ),
                                      child: TextButton(
                                          onPressed: () async {
                                            var status =
                                                await Permission.storage.status;
                                            if (status.isGranted) {
                                              Sheet sheetObject =
                                                  excel['Sheet1'];
                                              var record = recordsList[i];
                                              indexRecord(
                                                  record, 1, sheetObject);
                                              var fileBytes = excel.save();
                                              var directory =
                                                  await getExternalStorageDirectory();
                                              String path =
                                                  "/storage/emulated/0/用户记录/${widget.userName}/${formatDate(DateTime.now(), [
                                                    yyyy,
                                                    '-',
                                                    mm,
                                                    '-',
                                                    dd
                                                  ])}/${formatDate(DateTime.now(), [
                                                    HH,
                                                    nn,
                                                    ss
                                                  ])}.xlsx";
                                              File(join(path))
                                                ..createSync(recursive: true)
                                                ..writeAsBytesSync(fileBytes!);
                                              Fluttertoast.showToast(
                                                  msg: '导出成功，导出文件$path',
                                                  toastLength:
                                                      Toast.LENGTH_LONG);
                                            }
                                          },
                                          child: Text(
                                            '导出记录',
                                            style: TextStyle(
                                                color: const Color(0xFFFFFFFF),
                                                fontSize: 16.sp),
                                          )),
                                    )
                                  ],
                                )),
                            Container(
                                color: const Color(0xFFDFDFDF),
                                height: 0.5.h,
                                child: const Text('')),
                            SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0,
                                      right: 30,
                                      top: 20,
                                      bottom: 20),
                                  child: Wrap(
                                    spacing: 60,
                                    runSpacing: 20.0,
                                    children: recordsList[i]
                                        .getInfoList()!
                                        .map((e) => Text(
                                              e,
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  color:
                                                      const Color(0xff666666)),
                                            ))
                                        .toList(),
                                  ),
                                )),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> k = [
    '0',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M'
  ];

  void indexRecord(Record record, int index, Sheet sheetObject) {
    int kI = 1;
    record.getListTitle().forEach((key, value) {
      sheetObject.cell(CellIndex.indexByString('${k[kI]}$index')).value = key;
      sheetObject.cell(CellIndex.indexByString('${k[kI]}${index + 1}')).value =
          value;
      kI++;
    });
    sheetObject.cell(CellIndex.indexByString('${k[kI]}$index')).value = '日期';
    sheetObject.cell(CellIndex.indexByString('${k[kI]}${index + 1}')).value =
        record.dataTime;
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return TCalender(
            cDateTime: (data) {
              List<DateTime?> listDate = data;
              if (listDate.length != 2) {
                Fluttertoast.showToast(msg: '请选择时间段');
                return;
              }
              DateTime endTime = DateTime(
                  listDate[1]!.year, listDate[1]!.month, listDate[1]!.day + 1);


              DateTime startTime = DateTime(
                  listDate[0]!.year, listDate[0]!.month, listDate[0]!.day);

              List<Record> rdsList = [];
              for (var element in recordsList) {
                var dateCur = DateTime.parse(element.dataTime!);
                if (!dateCur.isBefore(startTime) && !dateCur.isAfter(endTime)) {
                  rdsList.add(element);
                }
              }
              if (rdsList.isNotEmpty) {
                recordsList.clear();
                recordsList.addAll(rdsList);
                startTimeDate = formatDate(listDate[0]!, [yy, '-', mm, '-', dd]);
                endTimeDate = formatDate(listDate[1]!, [yy, '-', mm, '-', dd]);
                setState(() {});
              } else {
                Fluttertoast.showToast(msg: "未找到数据");
              }
            },
          );
        });
  }

  Future<bool> requestCalendarPermission() async {
    //获取当前的权限
    var status = await Permission.storage.status;
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.storage.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  void exportXlm(int dateType, Sheet sheetObject) {
    List<String> mapKey = [];
    EasyLoading.show(status: 'loading...');
    DateTime time = DateTime.now();
    for (var element in recordsList) {
      DateTime parse = DateTime.parse(element.dataTime!);
      if (dateType == 1) {
        if (parse.month == time.month) {
          Map<String, String> mapVa = element.getListTitle();
          mapVa.forEach((key, value) {
            if (!mapKey.contains(key)) {
              mapKey.add(key);
            }
          });
        }
      }
      if (dateType == 2) {
        if (parse.year == time.year) {
          Map<String, String> mapVa = element.getListTitle();
          mapVa.forEach((key, value) {
            if (!mapKey.contains(key)) {
              mapKey.add(key);
            }
          });
        }
      }
      if (dateType == 3) {
        Map<String, String> mapVa = element.getListTitle();
        mapVa.forEach((key, value) {
          if (!mapKey.contains(key)) {
            if (mapKey.isNotEmpty && mapKey[mapKey.length - 1] == "时间") {
              mapKey.removeAt(mapKey.length - 1);
            }
            mapKey.add(key);
            mapKey.add('时间');
          }
        });
      }
    }
    int kI = 1;
    for (var element in mapKey) {
      sheetObject.cell(CellIndex.indexByString('${k[kI]}1')).value = element;
      int index = 2;
      for (var record in recordsList) {
        String? value = record.getValueForKey(element);
        if (TextUtil.isEmpty(value)) {
          value = '-';
        }
        sheetObject.cell(CellIndex.indexByString('${k[kI]}$index')).value =
            value;
        index++;
      }
      kI++;
    }
  }
}
