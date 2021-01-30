import 'package:flutter/material.dart' hide Action;

import 'routers.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var defaultPage = Routers.router.buildPage('home_page', null);

//    bool isLogin = true;
//    if (isLogin == false) {
//      defaultPage = Routers.router.buildPage('login_page', null);
//    }

    return MaterialApp(
      title: 'VeganPartner',
      navigatorKey: Routers.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pink,
      ),
      home: defaultPage,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<Object>(builder: (BuildContext context) {
          return Routers.router.buildPage(settings.name, settings.arguments);
        });
      },
    );
  }
}
