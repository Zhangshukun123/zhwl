import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:zhwlzlxt_project/entity/ultrasonic_sound.dart';
import 'package:zhwlzlxt_project/utils/event_bus.dart';

// import 'package:screen_brightness/screen_brightness.dart';
import 'package:zhwlzlxt_project/utils/language_value.dart';
import 'package:zhwlzlxt_project/widget/switch_value.dart';

import '../base/globalization.dart';
import '../utils/sp_utils.dart';
import '../widget/setting_dialog.dart';

class SetPage extends StatefulWidget {
  const SetPage({Key? key}) : super(key: key);

  @override
  State<SetPage> createState() => _SetPageState();
}

class _SetPageState extends State<SetPage> {
  bool languageBtnSelected = false;
  bool blueBtnSelected = true;
  double sliderValue = 100;
  int textValue = 100;
  String sliderText = "还没操作";
  SettingDialog? dialog;

  void updateSlider(value, text) {
    sliderValue = value;
    textValue = sliderValue.round();
    sliderText = text;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    languageBtnSelected = SpUtils.getBool(Globalization.languageSelected)!;
    sliderValue = SpUtils.getDouble('sliderValue', defaultValue: 100)!;
    print("sliderValue----------------$sliderValue");
    if(sliderValue<5){
      setBrightness(5 / 100);
    }else{
      setBrightness(sliderValue / 100);
    }
    textValue = sliderValue.round();
    dialog = SettingDialog();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(35.h),
          child: AppBar(
            automaticallyImplyLeading : false,
              title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 80.w,
                      height: 35.h,
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
                          Globalization.back.tr,
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
                      child: Text(Globalization.setting.tr,style: TextStyle(fontSize: 18.sp, color: Colors.white),)
                  ),
                )
              ],
              ),
            centerTitle: true,
          ),
        ),

    body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 180.w),
                    child: Row(
                      children: [
                        Text(
                          Globalization.language.tr,
                          style: TextStyle(
                              fontSize: 18.sp, color: const Color(0xFF999999)),
                        ),
                        SizedBox(
                          width: 14.w,
                        ),
                        HomeSwitchButton(
                            onString: "中文",
                            offString: "EN",
                            pressed: Get.locale?.countryCode == "CN",
                            onTap: (obj) {
                              languageBtnSelected = !languageBtnSelected;
                              SpUtils.setBool(Globalization.languageSelected,
                                  languageBtnSelected);
                              if (languageBtnSelected) {
                                var locale = const Locale('zh', 'CN');
                                Get.updateLocale(locale);
                              } else {
                                var locale = const Locale('en', 'US');
                                Get.updateLocale(locale);
                              }
                              debugPrint(
                                  '当前的语言为: ${Get.locale?.countryCode == "CN"}');
                              Language l = Language(Get.locale?.countryCode == "CN"?1:2);
                              eventBus.fire(l);

                              setState(() {
                                print(obj);
                              });
                            }),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 200.w),
                    child: Row(
                      children: [
                        Text(
                          Globalization.setting.tr,
                          style: TextStyle(
                              fontSize: 18.sp, color: const Color(0xFF999999)),
                        ),
                        SizedBox(
                          width: 14.w,
                        ),
                        Container(
                          width: 150.w,
                          height: 43.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00A8E7),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.w),
                            ),
                          ),
                          child: TextButton(
                              onPressed: (){
                                dialog?.showSettingDialog(context);
                              },
                              child:Text(Globalization.factory.tr,
                                style: TextStyle(color: const Color(0xFFFFFFFF),fontSize: 18.sp),)
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Visibility(
                  //   visible: false,
                  //   child: Container(
                  //     margin: EdgeInsets.only(left: 200.w),
                  //     child: Row(
                  //       children: [
                  //         Text(
                  //           Globalization.bluetooth.tr,
                  //           style: TextStyle(
                  //               fontSize: 18.sp,
                  //               color: const Color(0xFF999999)),
                  //         ),
                  //         SizedBox(
                  //           width: 14.w,
                  //         ),
                  //         HomeSwitchButton(
                  //             onString: Globalization.open.tr,
                  //             offString: Globalization.close.tr,
                  //             pressed: blueBtnSelected,
                  //             onTap: (obj) {
                  //               setState(() {
                  //                 blueBtnSelected = !blueBtnSelected;
                  //                 print(obj);
                  //               });
                  //             }),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 180.w),
                      child: Text(
                        Globalization.brightness.tr,
                        style: TextStyle(
                            color: const Color(0xFF999999), fontSize: 18.sp),
                      )),
                  Column(
                    children: [
                      Text(
                        '$textValue%',
                        style: TextStyle(color: Colors.black, fontSize: 18.sp),
                      ),
                      Container(
                        width: 430.w,
                        child: Slider(
                          value: sliderValue,
                          min: 0,
                          max: 100,
                          //滑块颜色
                          activeColor: const Color(0xFF00A8E7),
                          //轨道颜色
                          inactiveColor: const Color(0xFFF0F0F0),
                          //正在滑动或者点击，未松手
                          onChanged: (value) {
                            sliderValue = value;
                            setState(() {});
                            if(value==0){
                              value = 1;
                            }
                            if(value<5){
                              setBrightness(5 / 100);
                            }else{
                              setBrightness(value / 100);
                            }
                            // print("onChanged : $value");
                            updateSlider(value, "onChangeEnd : $value");
                          },
                          //刚开始点击
                          onChangeStart: (value) {
                            print("onChangeStart : $value");
                            updateSlider(value, "onChangeStart : $value");
                          },
                          //滑动或者点击结束，已松手
                          onChangeEnd: (value) {
                            print("onChangeEnd : $value");
                            updateSlider(value, "onChangeEnd : $value");
                            SpUtils.setDouble('sliderValue', value);
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> setBrightness(double brightness) async {
    try {
      await ScreenBrightness().setScreenBrightness(brightness);
    } catch (e) {
      print(e);
      throw 'Failed to set brightness';
    }
  }
}
