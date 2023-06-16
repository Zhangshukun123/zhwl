import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class function extends StatefulWidget {
  const function({Key? key}) : super(key: key);

  @override
  State<function> createState() => _functionState();
}

class _functionState extends State<function> {
  bool firstSelected = true;
  bool secondSelected = false;
  bool thirdSelected = false;
  bool fourthSelected = false;

  /// 初始化控制器
  late PageController pageController;

  //PageView当前显示页面索引
  int currentPage = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            width: 360,
            color: Color(0xFF00A8E7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 25,),
                    child: Image.asset('assets/images/2.0x/function_logo.png',fit: BoxFit.cover,width: 177,height: 59,)
                ),
                Container(
                  margin: EdgeInsets.only(top: 45),
                  width: 300,
                  height: 120,
                  decoration: BoxDecoration(
                      color: firstSelected ? Color(0XFFFFFFFF) : Color(0xFF19B1E9),
                    borderRadius: BorderRadius.all(
                      Radius.circular(60),
                    )
                  ),
                  child: TextButton(
                      onPressed: (){
                        print('超声疗法');
                        firstSelected = !firstSelected;
                        setState(() {

                        });
                      },
                      child: Text(
                        '超声疗法',
                        style: TextStyle(fontSize: 36,color: firstSelected ? Color(0xFF00A8E7) : Color(0xFFFFFFFF)),
                      )
                  ),
                ),
                Container(
                  width: 300,
                  height: 120,
                  margin: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: secondSelected ? Color(0XFFFFFFFF) : Color(0xFF19B1E9),
                      borderRadius: BorderRadius.all(
                        Radius.circular(60),
                      )
                  ),
                  child: TextButton(
                      onPressed: (){
                        print('脉冲磁疗法');
                        secondSelected = !secondSelected;
                        setState(() {

                        });
                      },
                      child: Text(
                        '脉冲磁疗法',
                        style: TextStyle(fontSize: 36,color: secondSelected ? Color(0xFF00A8E7) : Color(0xFFFFFFFF)),
                      )
                  ),
                ),
                Container(
                  width: 300,
                  height: 120,
                  margin: EdgeInsets.only(top: 0,left: 30,right: 30,bottom: 30),
                  decoration: BoxDecoration(
                      color: thirdSelected ? Color(0XFFFFFFFF) : Color(0xFF19B1E9),
                      borderRadius: BorderRadius.all(
                        Radius.circular(60),
                      )
                  ),
                  child: TextButton(
                      onPressed: (){
                        print('红外偏振光治疗');
                        thirdSelected = !thirdSelected;
                        setState(() {

                        });
                      },
                      child: Text(
                        '红外偏振光治疗',
                        style: TextStyle(fontSize: 36,color: thirdSelected ? Color(0xFF00A8E7) : Color(0xFFFFFFFF)),
                      )
                  ),
                ),
                Container(
                  // margin: EdgeInsets.only(bottom: 170),
                  width: 300,
                  height: 120,
                  margin: EdgeInsets.only(top: 0,left: 30,right: 30,bottom: 30),
                  decoration: BoxDecoration(
                      color: fourthSelected ? Color(0XFFFFFFFF) : Color(0xFF19B1E9),
                      borderRadius: BorderRadius.all(
                        Radius.circular(60),
                      )
                  ),
                  child: TextButton(
                      onPressed: (){
                        print('电疗');
                        fourthSelected = !fourthSelected;
                        setState(() {

                        });
                      },
                      child: Text(
                        '电疗',
                        style: TextStyle(fontSize: 36,color: fourthSelected ? Color(0xFF00A8E7) : Color(0xFFFFFFFF)),
                      )
                  ),
                ),
              ],
            ),
          ),
          Container(
            // height: 300,
            width: MediaQuery.of(context).size.width - 360,
            height: MediaQuery.of(context).size.height,
            child: PageView(
              controller: PageController(
                  initialPage: 0,//让初始页为第一个pageview的实例
                  viewportFraction: 1.0//让页面视图充满整个视图窗口 即充满400px高的视图窗口
              ),
              children: <Widget>[
                Container(
                  color: Colors.yellow,
                  child: Center(
                    child: Text('这是第一个pageView的实例',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                  ),
                ),
                Container(
                  color: Colors.red,
                  child: Center(
                    child: Text('这是第二个pageView的实例',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                  ),
                ),
                Container(
                  color: Colors.green,
                  child: Center(
                    child: Text('这是第三个pageView的实例',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                  ),
                ),
                Container(
                  color: Colors.blue,
                  child: Center(
                    child: Text('这是第四个pageView的实例',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                  ),
                ),
              ],
              scrollDirection: Axis.vertical,//上下滚动
              onPageChanged: (int index) {
                print('这是第${index}个页面');
              },
              reverse: false,//是否反转页面的顺序
            ),
          ),
          // Container(
          //   child: PageView.builder(
          //     //当页面选中后回调此方法
          //     //参数[index]是当前滑动到的页面角标索引 从0开始
          //     onPageChanged: (int index) {
          //       print("当前的页面是 $index");
          //       currentPage = index;
          //       },
          //     //值为flase时 显示第一个页面 然后从左向右开始滑动
          //     //值为true时 显示最后一个页面 然后从右向左开始滑动
          //     reverse: false,
          //     //滑动到页面底部无回弹效果
          //     physics: BouncingScrollPhysics(),
          //     //纵向滑动切换
          //     scrollDirection: Axis.vertical,
          //     //页面控制器
          //     controller: pageController,
          //     itemCount: 4,
          //     //所有的子Widget
          //     itemBuilder: (BuildContext context,int index){
          //       },
          //   ),
          // ),

        ],
      ),
    );
  }
}
