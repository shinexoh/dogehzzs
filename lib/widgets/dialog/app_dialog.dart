import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';
import '../../config/config.dart';
import '../../util/util.dart';

class AppDialog {
  ///SAF授权弹窗
  static void safDialog() async {
    Get.dialog(
      AlertDialog(
        title: const Text('温馨提示'),
        content: const Text(
            '从安卓11开始，你需要授予【游戏目录】权限才能修改画质。点击【立即授予】跳转到授予界面，然后直接点击底部【使用此文件夹】即可完成授予！'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('取消')),
          TextButton(
              onPressed: () async {
                final uriState = await SharedStorage.grantUriDirectory();
                if (uriState == GrantUriState.success) {
                  Get
                    ..back()
                    ..put(BaseController()).setDirectoryState(true);
                  showToast('授予成功');
                } else if (uriState == GrantUriState.wrong) {
                  showToast('授予文件夹错误，请重新授予。');
                } else {
                  showToast('未选择授予文件夹，请重新授予。');
                }
              },
              child: const Text('立即授予')),
        ],
      ),
    );
  }

  ///任务未完成弹窗
  static void taskDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('未激活'),
        content: const Text('请点击【去做任务】前往任务大厅完成任意一项任务，即可使用画质助手所有功能！'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('取消')),
          TextButton(
              onPressed: () {
                Get
                  ..back()
                  ..toNamed('/task');
              },
              child: const Text('去做任务')),
        ],
      ),
    );
  }

  ///网络错误弹窗
  static void netErrorDialog() {
    Get.dialog(
      WillPopScope(
          onWillPop: () async {
            SystemNavigator.pop();
            return true;
          },
          child: AlertDialog(
              title: const Text('网络错误'),
              content: const Text('你的网络连接错误，请检查网络连接后重试！'),
              actions: [
                TextButton(
                    onPressed: () => SystemNavigator.pop(),
                    child: const Text('退出'))
              ])),
      barrierDismissible: false,
    );
  }

  ///永久拒绝权限弹窗
  static void permissionDialog() {
    final androidVersion = double.parse(DeviceInfo.androidVersion);

    const textData =
        '由于画质助手需要【存储权限】才能修改画质，为保证你的正常使用，请点击【手动授予】跳转到设置，手动给画质助手授予【存储权限】';
    const textDataFor13 =
        '由于画质助手需要【存储权限】才能修改画质，为保证你的正常使用，请点击【手动授予】跳转到设置，手动给画质助手授予【存储权限】！\n\n注意：部分安卓13+机型可能在应用权限管理中不显示【存储权限】，那就需要授予【音乐和音频】、【照片和视频】或【文件】，这并不会窃取你的隐私，只是安卓13的新政策，实际上授予的还是【存储权限】';

    Get.dialog(AlertDialog(
      title: const Text('你已拒绝权限'),
      content: Text(androidVersion != 13 ? textData : textDataFor13),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('取消')),
        TextButton(
            onPressed: () async {
              Get.back();
              BaseUtil.openAppSettings();
            },
            child: const Text('手动授予')),
      ],
    ));
  }
}
