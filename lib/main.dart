import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loto/language/localization_service.dart';
import 'package:loto/page/splash/splash_page.dart';
import 'package:loto/page_config.dart';
import 'package:loto/src/theme_resource.dart';
import 'package:provider/provider.dart';

import 'theme/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
            title: 'SS App',
            themeMode: themeObject.mode,
            debugShowCheckedModeBanner: false,
            theme: ThemeResource.lightTheme(),
            darkTheme: ThemeResource.darkTheme(),
            home: const SplashPage(),
            getPages: PageConfig.listPage(),
            locale: LocalizationService.locale,
            fallbackLocale: LocalizationService.fallbackLocale,
            translations: LocalizationService(),
          )
      )
    );
  }
}
