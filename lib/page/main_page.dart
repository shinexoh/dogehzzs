import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';
import '../util/util.dart';
import 'home_page.dart';
import 'device_page.dart';
import 'user_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final mainController = Get.put(MainController());

  int pageIndex = 0;
  bool isHomePage = true;

  final List<Widget> pageBody = [
    const HomePage(),
    const DevicePage(),
    UserPage(),
  ];

  final List<CustomNavigationBarItem> items = [
    CustomNavigationBarItem(icon: const Icon(Icons.home)),
    CustomNavigationBarItem(icon: const Icon(Icons.build_circle)),
    CustomNavigationBarItem(icon: const Icon(Icons.account_circle))
  ];

  void onTap(int index) {
    setState(() {
      pageIndex = index;
      isHomePage = index == 0;

      index == 1 ? BaseUtil.setStatusBarDark() : BaseUtil.setStatusBarLight();
    });
  }

  @override
  void initState() {
    super.initState();
    BaseUtil.setStatusBarLight();
    mainController.checkTask();
    mainController.checkStorage();
    mainController.checkDirectory();
    mainController.checkAppUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: pageIndex,
        items: items,
        iconSize: 28,
        selectedColor: Colors.green,
        strokeColor: Colors.green.shade100,
        onTap: (index) => onTap(index),
      ),
      body: IndexedStack(
        index: pageIndex,
        children: pageBody,
      ),
      floatingActionButton: isHomePage
          ? FloatingActionButton(
              onPressed: mainController.onOpenGame,
              tooltip: '启动游戏',
              child: const Icon(Icons.play_arrow),
            )
          : null,
    );
  }
}
