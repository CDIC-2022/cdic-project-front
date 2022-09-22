import 'package:cdic_2022/commons/profile_info_card.dart';
import 'package:cdic_2022/login/login_page.dart';
import 'package:cdic_2022/menu/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( //for navigation dont forget to use GetMaterialApp
        title: 'Scrooge Project',
        theme: ThemeData(
        primarySwatch: Colors.blue,
    ),
    initialRoute: '/',

    getPages: [
      GetPage(name: '/', page: ()=>LoginPage(), transition: Transition.fadeIn),
      GetPage(name: '/main_menu', page: ()=>ProfileInfoCard(), transition: Transition.leftToRight)
    ],
    );
  }
}