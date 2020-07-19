import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttermoordemo/common/application.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart' as f show Column;
import '../model/database/database.dart';
import '../model/repository.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Repository get repository => Provider.of<Repository>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 1440, height: 2560, allowFontScaling: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<LoginEntity>(
        stream: repository.loginEntityObservable,
        builder: (context, snapshot) {
          if (snapshot.hasData) return pushHomeScreen(context);
          return Stack(children: <Widget>[
            Image.asset('assets/icon_login.png'),
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(width: 1440.w, height: 650.h),
                  buildEmailContainer(),
                  Container(width: 1440.w, height: 265.h),
                  buildPasswordContainer(),
                  Container(width: 1440.w, height: 180.h),
                  Container(
                      width: 1440.w,
                      height: 140.h,
                      child: GestureDetector(onTap: () => _login())),
                  Container(width: 1440.w, height: 1085.h)
                ])
          ]);
        },
      ),
    );
  }

  Align pushHomeScreen(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pop();
      Navigator.pushNamed(context, Application.home);
    });
    return const Align(
        alignment: Alignment.center, child: CircularProgressIndicator());
  }

  Container buildEmailContainer() => Container(
        width: 1440.w,
        height: 120.h,
        child: Row(
          children: <Widget>[
            Container(width: 100.w),
            Container(
                width: 1200.w,
                child: TextField(
                    style: TextStyle(
                        color: Colors.black, fontSize: ScreenUtil().setSp(55)),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(border: InputBorder.none),
                    controller: emailController)),
            Container(width: 140.w),
          ],
        ),
      );

  Container buildPasswordContainer() => Container(
        width: 1440.w,
        height: 120.h,
        child: Row(
          children: <Widget>[
            Container(width: 100.w),
            Container(
                width: 1200.w,
                child: TextField(
                    style: TextStyle(
                        color: Colors.black, fontSize: ScreenUtil().setSp(55)),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(border: InputBorder.none),
                    controller: passwordController)),
            Container(width: 140.w),
          ],
        ),
      );

  void _login() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      repository.insertLoginEntity(
          emailController.text, passwordController.text);
      emailController.clear();
      passwordController.clear();
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(Application.home);
    }
  }
}
