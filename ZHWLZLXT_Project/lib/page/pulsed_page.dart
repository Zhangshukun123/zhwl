import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zhwlzlxt_project/entity/pulsed_entity.dart';
import 'package:zhwlzlxt_project/page/operate_page.dart';
import 'package:zhwlzlxt_project/page/user_head_view.dart';
import 'package:zhwlzlxt_project/utils/treatment_type.dart';
import 'package:zhwlzlxt_project/widget/container_bg.dart';
import 'package:zhwlzlxt_project/widget/set_value.dart';

import '../utils/event_bus.dart';
import '../utils/sp_utils.dart';
import '../utils/treatment_type.dart';
import '../widget/details_dialog.dart';
import 'attention_page.dart';
import 'control_page.dart';

class PulsedPage extends StatefulWidget {
  const PulsedPage({Key? key}) : super(key: key);

  @override
  State<PulsedPage> createState() => _PulsedPageState();
}

class _PulsedPageState extends State<PulsedPage>
    with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {
  //定义四个页面
  late TabController _tabController;

  DetailsDialog? dialog;

  //初始化字段存储
  Pulsed? pulsed;

  StreamController<String> cTime = StreamController<String>();
  StreamController<String> cPower = StreamController<String>();
  StreamController<String> cFrequency = StreamController<String>();

  @override
  void initState() {
    super.initState();
    dialog = DetailsDialog(index: 2);//1:超声疗法；2：脉冲磁疗法；3：红外偏光；4：痉挛肌；5：经皮神经电刺激；6：神经肌肉点刺激；7：中频/干扰电治疗；

    //数据的更改与保存，是否是新建或者从已知json中读取
    if (TextUtil.isEmpty(SpUtils.getString(PulsedField.PulsedKey))) {
      pulsed = Pulsed();
    } else {
      pulsed =
          Pulsed.fromJson(SpUtils.getString(PulsedField.PulsedKey)!);
    }

    // pulsed = Pulsed();

    _tabController =
        TabController(length: dialog?.tabs.length ?? 0, vsync: this);
    _tabController.addListener(() {});

    dialog?.setTabController(_tabController);

    // 一定时间内 返回一个数据
    cTime.stream.debounceTime(const Duration(seconds: 1)).listen((time) {
      pulsed?.time = time;
      save();
    });
    cPower.stream.debounceTime(const Duration(seconds: 1)).listen((power) {
      pulsed?.power = power;
      save();
    });
    cFrequency.stream.debounceTime(const Duration(seconds: 1)).listen((frequency) {
      pulsed?.frequency = frequency;
      save();
    });

    eventBus.on<UserEvent>().listen((event) {
      if (event.type == TreatmentType.pulsed) {
        pulsed?.userId = event.user?.userId;
        save();
      }
    });
  }

  void save() {
    SpUtils.set(PulsedField.PulsedKey, pulsed?.toJson());
  }

  @override
  void dispose() {
    super.dispose();
    cTime.close();
    cPower.close();
    cFrequency.close();
  }

  @override
  bool startSelected = true;
  bool switchSelected = true;

  Widget build(BuildContext context) {
    super.build(context);
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: const Color(0xFFF0FAFE),
      body: SafeArea(
        child: Column(
          children: [
             UserHeadView(type: TreatmentType.pulsed,),
            Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 35.w, right: 35.w, top: 17.5.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ContainerBg(
                          width: 416.w,
                          height: 150.h,
                          child: SetValue(
                            enabled: true,
                            title: '强度',
                            assets: 'assets/images/2.0x/icon_qiangdu.png',
                            initialValue: double.tryParse(
                                pulsed?.power ?? '0'),
                            maxValue: 5,
                            minValue: 0,
                            valueListener: (value) {
                              print("------强度-----$value");
                              cPower.add(value.toString());
                            },
                          )),
                      ContainerBg(
                          width: 416.w,
                          height: 150.h,
                          margin: EdgeInsets.only(top: 25.h),
                          child: SetValue(
                            enabled: true,
                            title: '频率',
                            assets: 'assets/images/2.0x/icon_pinlv.png',
                            initialValue: double.tryParse(
                                pulsed?.frequency ?? '20'),
                            appreciation: 10,
                            maxValue: 80,
                            minValue: 20,
                            unit: '次/min',
                            valueListener: (value) {
                              print("------频率-----$value");
                              cFrequency.add(value.toString());
                            },
                          )),
                      ContainerBg(
                          width: 416.w,
                          height: 150.h,
                          margin: EdgeInsets.only(top: 25.h),
                          child: SetValue(
                            enabled: true,
                            title: '时间',
                            assets: 'assets/images/2.0x/icon_shijian.png',
                            initialValue: double.tryParse(
                                pulsed?.time ?? '12'),
                            maxValue: 99,
                            minValue: 1,
                            unit: 'min',
                            valueListener: (value) {
                              print("------时间-----$value");
                              cTime.add(value.toString());
                            },
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 17.5.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          width: 260.w,
                          height: 235.h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 15.w,
                                    offset: const Offset(0, 2),
                                    spreadRadius: 0)
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.w),
                              )),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 60.h),
                                child: TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/2.0x/icon_zhendong.png',
                                          fit: BoxFit.cover,
                                        ),
                                        Text(
                                          '振动',
                                          style: TextStyle(
                                              color: const Color(0xFF999999),
                                              fontSize: 18.sp),
                                        ),
                                      ],
                                    )),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 15.h),
                                  width: 120.w,
                                  height: 70.h,
                                  child: Transform.scale(
                                    scale: 2,
                                    child: CupertinoSwitch(
                                        value: switchSelected,
                                        activeColor: const Color(0xFF00A8E7),
                                        trackColor: const Color(0xFFF9F9F9),
                                        onChanged: (value) {
                                          switchSelected = !switchSelected;
                                          print(value);
                                          setState(() {});
                                        }),
                                  )
                                  // TextButton(
                                  //     onPressed: (){
                                  //       switchSelected = !switchSelected;
                                  //       setState(() {
                                  //
                                  //       });
                                  //     },
                                  //     child: Image.asset(switchSelected ? 'assets/images/2.0x/img_kai.png' : 'assets/images/2.0x/img_guan.png',fit: BoxFit.fill,width: 120.w,height: 70.h,)
                                  // ),
                                  ),
                            ],
                          )),
                      Container(
                          width: 260.w,
                          height: 235.h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 15.w,
                                    offset: const Offset(0, 2),
                                    spreadRadius: 0)
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.w),
                              )),
                          margin: EdgeInsets.only(top: 30.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 78.w,
                                margin: EdgeInsets.only(top: 15.5.h),
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/2.0x/img_xiangqing.png'),
                                  fit: BoxFit.fill, // 完全填充
                                )),
                                child: TextButton(
                                    onPressed: () {
                                      dialog?.showCustomDialog(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                          'assets/images/2.0x/icon_xiangqing.png',
                                          fit: BoxFit.fill,
                                          width: 18.w,
                                          height: 18.h,
                                        ),
                                        Text(
                                          '详情',
                                          style: TextStyle(
                                              color: const Color(0xFF009CB4),
                                              fontSize: 18.sp),
                                        ),
                                      ],
                                    )),
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 50.5.h),
                                  child: TextButton(
                                    onPressed: () {
                                      startSelected = !startSelected;
                                      setState(() {});
                                    },
                                    child: Image.asset(
                                      startSelected
                                          ? 'assets/images/2.0x/btn_kaishi_nor.png'
                                          : 'assets/images/2.0x/btn_tingzhi_nor.png',
                                      width: 100.w,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
