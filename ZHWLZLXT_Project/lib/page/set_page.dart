import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetPage extends StatefulWidget {
  const SetPage({Key? key}) : super(key: key);

  @override
  State<SetPage> createState() => _SetPageState();
}

class _SetPageState extends State<SetPage> {
  @override
  Widget build(BuildContext context) {
    bool languageBtnSelected = true;
    bool blueBtnSelected = true;
    double sliderValue = 50;
    String sliderText = "还没操作";
    void updateSlider(value, text){
      sliderValue = value;
      sliderText = text;
      setState(() {

      });
    }
    ScreenUtil().orientation;
    ScreenUtil.init(context, designSize: const Size(960, 600));
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text('设置',style: TextStyle(fontSize: 18.sp,color: Colors.white),),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 15.w,right: 15.w,top: 10.h),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 180.w),
                    child: TextButton(
                        onPressed: (){
                          languageBtnSelected = !languageBtnSelected;
                          setState(() {

                          });
                        },
                        child: Row(
                          children: [
                            Text('语言',style: TextStyle(color: const Color(0xFF999999),fontSize: 18.sp),),
                            SizedBox(width: 18.w,),
                            Image.asset( languageBtnSelected ? 'assets/images/2.0x/btn_yuyan_zhongwen.png' : 'assets/images/2.ox/btn_yuyan_yingwen.png',fit: BoxFit.cover,width: 140.w,height: 45.h,),
                          ],
                        )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 200.w),
                    child: TextButton(
                        onPressed: (){
                          blueBtnSelected = !blueBtnSelected;
                          setState(() {

                          });

                        },
                        child: Row(
                          children: [
                            Text('蓝牙',style: TextStyle(color: const Color(0xFF999999),fontSize: 18.sp),),
                            SizedBox(width: 18.w,),
                            Image.asset(blueBtnSelected ? 'assets/images/2.0x/btn_lanya_dakai.png' : 'assets/images/2.ox/btn_lanya_guanbi.png',fit: BoxFit.cover,width: 140.w,height: 45.h,),
                          ],
                        )
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 180.w),
                      child: Text('亮度调节',style: TextStyle(color: const Color(0xFF999999),fontSize: 18.sp),)
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
                      onChanged: (value){
                        sliderValue = value;
                        setState(() {

                        });
                        print("onChanged : $value");
                      },
                      //刚开始点击
                      onChangeStart: (value){
                        print("onChangeStart : $value");
                        updateSlider(value, "onChangeStart : $value");
                      },
                      //滑动或者点击结束，已松手
                      onChangeEnd: (value){
                        print("onChangeEnd : $value");
                        updateSlider(value, "onChangeEnd : $value");
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
