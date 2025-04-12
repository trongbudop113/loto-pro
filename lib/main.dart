import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loto/language/localization_service.dart';
import 'package:loto/page/shopping/home_main/home_main_controller.dart';
import 'package:loto/page/shopping/home_main/home_main_page.dart';
import 'package:loto/page_config.dart';
import 'package:loto/src/theme_resource.dart';
import 'package:provider/provider.dart';

import 'theme/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  initializeDateFormatting("vi_VN", "");
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget  {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
          builder: (ctx, themeObject, _) => GetMaterialApp(
            title: 'Bug Cake',
            themeMode: themeObject.mode,
            debugShowCheckedModeBanner: false,
            theme: ThemeResource.lightTheme(),
            darkTheme: ThemeResource.darkTheme(),
            home: const HomeMainPage(),
            initialBinding: HomeMainBinding(),
            getPages: PageConfig.listPage(),
            smartManagement: SmartManagement.keepFactory,
            locale: LocalizationService.locale,
            fallbackLocale: LocalizationService.fallbackLocale,
            translations: LocalizationService(),
          )
      )
    );
  }
}
