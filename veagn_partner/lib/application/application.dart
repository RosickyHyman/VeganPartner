import 'package:flutter/material.dart' hide Action;
import 'package:partner/utils/common/common_colors.dart';
import 'package:partner/utils/other/hex_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    var defaultPage = Routers.router.buildPage('splash_page', null);

//    bool isLogin = true;
//    if (isLogin == false) {
//      defaultPage = Routers.router.buildPage('login_page', null);
//    }

    return MaterialApp(
      title: 'VeganPartner',
      navigatorKey: Routers.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: HexColor(CommonColors.defaultColors),
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
