import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/splash/splash_page.dart';
import 'package:loto/page_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget  {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // Get.put(HomeController());
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
      getPages: PageConfig.listPage(),
    );
  }
}
