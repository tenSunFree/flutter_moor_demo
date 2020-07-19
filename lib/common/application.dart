import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttermoordemo/model/repository.dart';
import 'package:fluttermoordemo/view/home_screen.dart';
import 'package:fluttermoordemo/view/login_screen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Application extends StatelessWidget {
  static const String login = '/login';
  static const String home = '/home';

  var routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomeScreen()
  };

  @override
  Widget build(BuildContext context) => Provider<Repository>(
      create: (_) => Repository(),
      dispose: (_, bloc) => bloc.close(),
      child: MaterialApp(
          title: 'flutter_moor_demo',
          theme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.orange,
              typography: Typography.material2018()),
          home: LoginScreen(),
          routes: routes));
}
