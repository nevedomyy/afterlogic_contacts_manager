import 'package:flutter/material.dart';
import 'login_page.dart';
import 'color.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      theme: ThemeData(
        accentColor: AppColor.text
      ),
      home: LoginPage(),
    );
  }
}