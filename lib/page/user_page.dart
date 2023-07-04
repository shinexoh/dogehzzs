import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';
import '../widgets/widgets.dart';
import '../config/config.dart';
import '../util/util.dart';

class UserPage extends StatelessWidget {
  UserPage({super.key});

  final baseController = Get.put(BaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userInfoBar(),
          taskBar(),
          helpBar(),
          qqBar(),
          groupBar(),
          aboutBar(),
          exitBar(),
        ],
      ),
    );
  }

  Widget userInfoBar() {
    return ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
        width: double.infinity,
        color: Colors.green,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30),
              GestureDetector(
                onLongPress: onUserInfo,
                child: Image.asset(AppAssets.appIcon, height: 80, width: 80),
              ),
              const SizedBox(height: 3),
              const Text(
                'Doge画质助手',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Obx(() => Text(
                  '当前状态：${baseController.taskState.value ? '会员用户' : '普通用户'}',
                  style: TextStyle(color: Colors.white.withOpacity(0.7)))),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget taskBar() {
    return OnInk(
      width: double.infinity,
      height: 55,
      margin: const EdgeInsets.only(top: 10),
      onTap: onTask,
      child: const Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.token_outlined, color: Colors.green, size: 30),
                SizedBox(width: 20),
                Text('任务大厅', style: TextStyle(fontSize: 16)),
              ],
            ),
            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget helpBar() {
    return OnInk(
      width: double.infinity,
      height: 55,
      onTap: onHelp,
      child: const Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.help_outline, color: Colors.green, size: 30),
                SizedBox(width: 20),
                Text('使用帮助', style: TextStyle(fontSize: 16)),
              ],
            ),
            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget qqBar() {
    return OnInk(
      width: double.infinity,
      height: 55,
      onTap: onQQ,
      child: const Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.person_outline, color: Colors.green, size: 30),
                SizedBox(width: 20),
                Text('联系作者', style: TextStyle(fontSize: 16)),
              ],
            ),
            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget groupBar() {
    return OnInk(
      width: double.infinity,
      height: 55,
      onTap: onGroup,
      child: const Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.supervised_user_circle_outlined,
                    color: Colors.green, size: 30),
                SizedBox(width: 20),
                Text('加入群聊', style: TextStyle(fontSize: 16)),
              ],
            ),
            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget aboutBar() {
    return OnInk(
      width: double.infinity,
      height: 55,
      onTap: onAbout,
      child: const Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Colors.green, size: 30),
                SizedBox(width: 20),
                Text('关于应用', style: TextStyle(fontSize: 16)),
              ],
            ),
            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget exitBar() {
    return OnInk(
      width: double.infinity,
      height: 55,
      onTap: onExit,
      child: const Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.exit_to_app_outlined, color: Colors.green, size: 30),
                SizedBox(width: 20),
                Text('退出应用', style: TextStyle(fontSize: 16)),
              ],
            ),
            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void onUserInfo() {
    SpUtil.clear();
    baseController.setTaskState(false);
    Get.dialog(AlertDialog(
        content: Image.asset(AppAssets.mySecret, fit: BoxFit.cover)));
  }

  void onTask() => Get.toNamed('/task');

  void onHelp() => Get.toNamed('/web', arguments: {'url': BaseConfig.helpUrl});

  void onQQ() => BaseUtil.openQQ(653143454);

  void onGroup() => BaseUtil.openQQGroup(739559380);

  void onAbout() {
    Get.dialog(AboutDialog(
        applicationName: 'Doge画质助手',
        applicationIcon: Image.asset(AppAssets.appIcon, height: 55, width: 55),
        applicationVersion: BaseConfig.appMainVersion,
        applicationLegalese: BaseConfig.aboutAppIntro));
  }

  void onExit() => SystemNavigator.pop();
}
