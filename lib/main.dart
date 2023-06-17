import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './page/splash_page.dart';
import './page/main_page.dart';
import './page/task_page.dart';
import './page/web_page.dart';
import './page/storage_page.dart';
import './page/use/zsxg_page.dart';
import './page/use/yjxg_page.dart';
import './page/use/ddj_page.dart';
import './page/use/zdj_page.dart';
import './page/use/gdj_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      position: ToastPosition.bottom,
      duration: const Duration(seconds: 3),
      child: GetMaterialApp(
          title: 'Doge画质助手',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.green,
              scaffoldBackgroundColor: Colors.grey.shade100,
              appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.light,
                  ),
                  centerTitle: true,
                  elevation: 0)),
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: () => const SplashPage()),
            GetPage(name: '/main', page: () => const MainPage()),
            GetPage(name: '/task', page: () => const TaskPage()),
            GetPage(name: '/web', page: () => const WebPage()),
            GetPage(name: '/storage', page: () => const StoragePage()),
            GetPage(name: '/zsxg', page: () => const ZsxgPage()),
            GetPage(name: '/yjxg', page: () => const YjxgPage()),
            GetPage(name: '/ddj', page: () => const DdjPage()),
            GetPage(name: '/zdj', page: () => const ZdjPage()),
            GetPage(name: '/gdj', page: () => const GdjPage()),
          ],
          defaultTransition: Transition.cupertino,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: const [Locale('zh', 'CN')],
          //限制字体大小跟随系统变化
          builder: (context, child) {
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!);
          }),
    );
  }
}
