import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/set_value_horizontal.dart';

class JingLuanPage extends StatefulWidget {
  const JingLuanPage({Key? key}) : super(key: key);

  @override
  State<JingLuanPage> createState() => _JingLuanPageState();
}

class _JingLuanPageState extends State<JingLuanPage> {
  bool jingStartSelected = true;

  @override
  Widget build(BuildContext context) {
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: Color(0xFFF0FAFE),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 35.w, right: 35.w),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SetValueHorizontal(
                    enabled: true,
                    title: '时间',
                    assets: 'assets/images/2.0x/icon_shijian.png',
                    initialValue: 12,
                    unit: 'min',
                    valueListener: (value) {},
                  ),
                  SetValueHorizontal(
                    enabled: true,
                    isInt: false,
                    title: '脉宽 (A)',
                    assets: 'assets/images/2.0x/icon_maikuan.png',
                    initialValue: 0.1,
                    appreciation: 0.1,
                    unit: 'ms',
                    valueListener: (value) {},
                  ),
                  SetValueHorizontal(
                    enabled: true,
                    isInt: false,
                    title: '脉宽 (B)',
                    assets: 'assets/images/2.0x/icon_maikuan.png',
                    initialValue: 0.1,
                    appreciation: 0.1,
                    unit: 'ms',
                    valueListener: (value) {},
                  ),
                  SetValueHorizontal(
                    enabled: true,
                    isInt: false,
                    title: '延时时间',
                    assets: 'assets/images/2.0x/icon_yanshi.png',
                    initialValue: 0.1,
                    appreciation: 0.1,
                    unit: 's',
                    valueListener: (value) {},
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 30.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SetValueHorizontal(
                      enabled: true,
                      isInt: false,
                      title: '脉冲周期',
                      assets: 'assets/images/2.0x/icon_maichong.png',
                      initialValue: 1.0,
                      appreciation: 1.0,
                      unit: 's',
                      valueListener: (value) {},
                    ),
                    SetValueHorizontal(
                      enabled: true,
                      isInt: true,
                      title: '强度 (A)',
                      assets: 'assets/images/2.0x/icon_qiangdu.png',
                      initialValue: 1,
                      valueListener: (value) {},
                    ),
                    SetValueHorizontal(
                      enabled: true,
                      isInt: false,
                      title: '强度 (B)',
                      assets: 'assets/images/2.0x/icon_qiangdu.png',
                      initialValue: 0.1,
                      appreciation: 0.1,
                      unit: 's',
                      valueListener: (value) {},
                    ),
                    Container(
                        width: 340.w,
                        height: 100.h,
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
                        child: Container(
                          child: TextButton(
                            onPressed: () {
                              jingStartSelected = !jingStartSelected;
                              setState(() {});
                            },
                            child: Image.asset(
                              jingStartSelected
                                  ? 'assets/images/2.0x/btn_kaishi_nor.png'
                                  : 'assets/images/2.0x/btn_tingzhi_nor.png',
                              fit: BoxFit.fill,
                              width: 120.w,
                              height: 55.h,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
