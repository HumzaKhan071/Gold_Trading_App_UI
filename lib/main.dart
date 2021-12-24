import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goldapp/home.dart';
import 'package:goldapp/sizeconfig.dart';
import 'package:goldapp/style.dart';
import 'package:goldapp/transactions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController? _controller;
  int currentPage = 0;
  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  void changePage(int id) {
    setState(() {
      _controller!.jumpToPage(id);
      currentPage = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Style();
    return Scaffold(
      backgroundColor: Style.backgroundColor,
      bottomNavigationBar: Container(
        color: currentPage == 0 ? Style.secondaryColor : Colors.transparent,
        child: Container(
          width: SizeConfig.width,
          height: 80,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  changePage(0);
                },
                child: navItem(0, "assets/home.svg"),
              ),
              GestureDetector(
                onTap: () {
                  changePage(1);
                },
                child: navItem(1, "assets/transaction.svg"),
              ),
              GestureDetector(
               onTap: () {
                  changePage(2);
                },
                child: navItem(2, "assets/message.svg"),
              ),
              GestureDetector(
                onTap: () {
                  changePage(3);
                },
                child: navItem(3, "assets/user.svg"),
              )
            ],
          ),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: [
          HomePage(),
          TransactionPage(),
          HomePage(),
          TransactionPage(),
        ],
      ),
    );
  }

  Widget navItem(int id, String asset) {
    return SvgPicture.asset(
      asset,
      height: 20,
      width: 20,
      color: currentPage == id ? Style.primaryColor : Style.backgroundColor,
    );
  }
}
