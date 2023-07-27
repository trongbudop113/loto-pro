import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loto/page/splash/splash_page.dart';
import 'package:loto/page_config.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBUsI48vfRjyTKehWwxv5DUpt1Sajiz1sE",
            authDomain: "loto-fb7ac.firebaseapp.com",
            projectId: "loto-fb7ac",
            storageBucket: "loto-fb7ac.appspot.com",
            messagingSenderId: "223090207254",
            appId: "1:223090207254:web:6359fe5d6c4127447ce337",
            measurementId: "G-GFQGZC5BQ1"
        )
    );
  }else{
    await Firebase.initializeApp();
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
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
