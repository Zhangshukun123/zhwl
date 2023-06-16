import 'package:flutter/material.dart';
import 'package:zhwlzlxt_project/login_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
    var stack = new Stack(
      children: [
        Positioned.fill(
            child: Image.asset('assets/images/2.0x/welcome_bg.png',fit: BoxFit.cover,)
        ),
        // Image.asset('assets/images/2.0x/welcome_bg.png',fit: BoxFit.fitHeight,),
        Container(
          margin: EdgeInsets.only(left: 80,top: 100),
            child: Image.asset('assets/images/2.0x/logon.png',width: 300,height: 100,)
        ),
        Container(
          margin: EdgeInsets.only(bottom: 100),
            child: Center(child: Text('欢迎使用',style: TextStyle(color: Colors.white,fontSize: 60,fontWeight: FontWeight.w500),))
        ),
        Container(
            margin: EdgeInsets.only(top: 50,),
            child: Center(
                child: Text('综合物理治疗系统',style: TextStyle(color: Colors.white,fontSize: 60,fontWeight: FontWeight.w500),)
            )
        ),
        Container(
            margin: EdgeInsets.only(top: 400,),
            child: Center(child: Text('正在加载中...',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w300),))
        )
      ],
    );

    return Scaffold(
      body: InkWell(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => login()
              ));
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
