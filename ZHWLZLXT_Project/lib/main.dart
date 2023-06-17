import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:zhwlzlxt_project/page/guide_page.dart';
import 'package:zhwlzlxt_project/page/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(960, 600),
      scaleByHeight: false,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const GuidePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var stack =  Stack(
      children: [
        Positioned.fill(
            child: Image.asset(
          'assets/images/2.0x/welcome_bg.png',
          fit: BoxFit.cover,
        )),
        // Image.asset('assets/images/2.0x/welcome_bg.png',fit: BoxFit.fitHeight,),
        Container(
            margin: const EdgeInsets.only(left: 80, top: 100),
            child: Image.asset(
              'assets/images/2.0x/logon.png',
              width: 300,
              height: 100,
            )),
        Container(
            margin: const EdgeInsets.only(bottom: 100),
            child: const Center(
                child: Text(
              '欢迎使用',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.w500),
            ))),
        Container(
            margin: EdgeInsets.only(
              top: 50,
            ),
            child: Center(
                child: Text(
              '综合物理治疗系统',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.w500),
            ))),
        Container(
            margin: EdgeInsets.only(
              top: 400,
            ),
            child: Center(
                child: Text(
              '正在加载中...',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w300),
            )))
      ],
    );

    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
        },
        child: SafeArea(
          child: stack,
        ),
      ),
    );

    // return MaterialApp(
    //   home: Scaffold(
    //     body: SafeArea(
    //       child: stack,
    //     ),
    //   ),
    // );

    // return Scaffold(
    //   // appBar: AppBar(
    //   //   // TRY THIS: Try changing the color here to a specific color (to
    //   //   // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
    //   //   // change color while the other colors stay the same.
    //   //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    //   //   // Here we take the value from the MyHomePage object that was created by
    //   //   // the App.build method, and use it to set our appbar title.
    //   //   title: Text(widget.title),
    //   // ),
    //   body: Center(
    //     // Center is a layout widget. It takes a single child and positions it
    //     // in the middle of the parent.
    //     child: Column(
    //       children: <Widget>[
    //         Image.asset('assets/images/2.0x/welcome_bg.png',fit: BoxFit.fill,),
    //         Image.asset('assets/images/2.0x/logon.png',width: 300,height: 100,),
    //         // const Text(
    //         //   'You have pushed the button this many times:',
    //         // ),
    //         // Text(
    //         //   '$_counter',
    //         //   style: Theme.of(context).textTheme.headlineMedium,
    //         // ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
