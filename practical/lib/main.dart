import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:practical/constant/get_page_constant.dart';
import 'package:practical/constant/route_constant.dart';
import 'package:practical/tab/home_controller.dart';
import 'package:practical/tab/home_view.dart';


Future<void> main() async {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      getPages: getPages,
      title: 'Rest API Using GetX Demo',
      initialRoute: RouteConstant.homeScreen,
     // home: const HomeView(),
    );
  }


}