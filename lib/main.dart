import 'package:cdic_2022/login/commons/login_page.dart';
import 'package:cdic_2022/menu/menu_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Raleway'
        ),
        home: LoginPage()
    );
  }
}