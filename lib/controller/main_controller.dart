import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:oktoast/oktoast.dart';
import 'package:get/get.dart';

import '../http/api.dart';
import '../http/http_client.dart';
import '../config/config.dart';
import '../controller/controller.dart';
import '../util/util.dart';

class MainController extends GetxController {
  final _baseController = Get.put(BaseController());

  void onOpenGame() async {
    if (!await DeviceApps.openApp('com.tencent.tmgp.pubgmhd')) {
      showToast('启动游戏失败，请手动启动！');
    }
  }

  //检查任务激活
  void checkTask() {
    SpUtil.containsKey(BaseConfig.taskKey)
        ? _baseController.setTaskState(true)
        : _baseController.setTaskState(false);
  }

  //检查存储权限授予
  void checkStorage() async {
    await Permission.storage.status == PermissionStatus.granted
        ? _baseController.setStorageState(true)
        : _baseController.setStorageState(false);
  }

  //检查游戏目录授予
  void checkDirectory() async {
    await SharedStorage.checkMainUri()
        ? _baseController.setDirectoryState(true)
        : _baseController.setDirectoryState(false);
  }

  //检查应用更新
  void checkAppUpdate() async {
    final update = await HttpClient.getInstance().get(Api.appUpdate);

    if (update.isOk && update.data['version'] > BaseConfig.updateVersion) {
      Get.dialog(
        barrierDismissible: false,
        WillPopScope(
          onWillPop: () async {
            SystemNavigator.pop();
            return true;
          },
          child: AlertDialog(
            title: Text(update.data['title']),
            content: Text(update.data['subtitle']),
            actions: [
              TextButton(
                  onPressed: () => SystemNavigator.pop(),
                  child: const Text('退出')),
              TextButton(
                  onPressed: () => BaseUtil.openUrl(update.data['downloadurl']),
                  child: const Text('前往更新'))
            ],
          ),
        ),
      );
    }
  }
}
