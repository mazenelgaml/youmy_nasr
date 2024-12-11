import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:merchant/services/app_translation.dart';
import 'package:merchant/services/localization_services.dart';
import 'package:merchant/services/memory.dart';
import 'package:merchant/ui/splash/splash_screen.dart';
import 'package:merchant/util/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => CacheHelper.init(), permanent: true);
  Get.put(LocalizationService.init(), permanent: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: 'Yomy Merchant',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: routes,
      translations: AppTranslations(),
      locale: Get.find<LocalizationService>().activeLocale,
      supportedLocales: SupportedLocales.all,
      fallbackLocale: SupportedLocales.english,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );

  }
}
