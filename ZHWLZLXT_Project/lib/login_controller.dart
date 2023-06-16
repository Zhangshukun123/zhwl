import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zhwlzlxt_project/function_controller.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  bool setSelected = true;
  TextEditingController acController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )
                ),
                margin: EdgeInsets.only(left: 30,right: 30,top: 30,bottom: 30),

                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin:EdgeInsets.only(top: 90,left: 50),
                                child: Image.asset('assets/images/2.0x/login_logo.png',fit: BoxFit.cover,width: 275,height: 90,)
                            ),
                            Expanded(
                              child: Center(
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/2.0x/login_shebei.png',fit: BoxFit.cover,height: 350,),
                                    Text('综合物理治疗系统',style: TextStyle(fontSize: 36,color: Color(0xFF999999)),),
                                  ],
                                ),
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFF5F7F9),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            )
                        ),

                        child: Column(
                          children: [
                            Container(
                              margin:EdgeInsets.only(top:130),
                                child: Text('登录',style: TextStyle(fontSize: 40,color: Color(0xFF242021)),)
                            ),
                            SizedBox(height: 50,),
                            Container(
                              height: 70,
                              margin: EdgeInsets.only(left: 65,right: 65),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7),
                                  )
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 20),
                                  Image.asset('assets/images/2.0x/login_account.png',fit: BoxFit.cover,width: 36,height: 36,),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: TextField(
                                      controller: acController,
                                      decoration: InputDecoration(
                                        hintText: '请输入用户名',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 50,),
                            Container(
                              height: 70,
                              margin: EdgeInsets.only(left: 65,right: 65),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7),
                                  )
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 20),
                                  Image.asset('assets/images/2.0x/login_pwd.png',fit: BoxFit.cover,width: 36,height: 36,),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: TextField(
                                      controller: pwdController,
                                      decoration: InputDecoration(
                                        hintText: '请输入密码',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // color: Colors.green,
                              margin: EdgeInsets.only(left:30,right: 100),
                              child: //自定义button
                              TextButton(
                                  onPressed: () {
                                    setSelected = !setSelected;
                                    setState(() {
                                      //刷新状态
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.asset(setSelected?'assets/images/2.0x/icon_btn_nor.png':'assets/images/2.0x/icon_btn_sel.png',width: 20,height: 20,),
                                      Text("记住密码",style: TextStyle(color: Color(0xFF999999),fontSize: 20),)
                                    ],
                                  )
                              ),
                            ),
                            SizedBox(height: 50,),
                            Container(
                              margin: EdgeInsets.only(left: 65,right: 65,),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFF00A8E7),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )
                              ),
                              child: TextButton(
                                  onPressed: (){
                                    print('点击确定按钮');
                                    print(acController.text);
                                    print(pwdController.text);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) => function()
                                        )
                                    );
                                  },
                                  child: Text('确定',style: TextStyle(color: Colors.white,fontSize: 36),)),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),


            Text('当前版本号：v1.0',style: TextStyle(fontSize: 36,color: Colors.white),),

          ],
        ),
      ),
    );
  }
}
