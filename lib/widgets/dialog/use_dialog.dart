import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:get/get.dart';

import 'app_dialog.dart';
import '../../config/config.dart';
import '../../util/util.dart';

class UseDialog {
  ///修改画质弹窗
  static void usePqDialog({
    required String filePath,
    String title = '温馨提示',
    String subTitle = '是否要修改此画质？若出现问题请到首页还原画质！',
    String buttonText = '修改',
  }) {
    Get.dialog(AlertDialog(
      title: Text(title),
      content: Text(subTitle),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('取消')),
        TextButton(
          onPressed: () async {
            Get.back();
            final androidVersion = double.parse(DeviceInfo.androidVersion);
            if (SpUtil.containsKey(BaseConfig.taskKey)) {
              if (androidVersion < 11) {
                await UseFor10.usePq(filePath)
                    ? showToast('修改成功')
                    : showToast('修改失败');
              } else if (await SharedStorage.checkMainUri()) {
                await UseFor11.usePq(filePath)
                    ? showToast('修改成功')
                    : showToast('修改失败');
              } else {
                AppDialog.safDialog();
              }
            } else {
              AppDialog.taskDialog();
            }
          },
          child: Text(buttonText),
        ),
      ],
    ));
  }

  ///解锁画质帧率弹窗
  static void useDlDialog({required title, required subTitle}) {
    Get.dialog(AlertDialog(
      title: Text(title),
      content: Text(subTitle),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('取消')),
        TextButton(
          onPressed: () async {
            Get.back();
            final androidVersion = double.parse(DeviceInfo.androidVersion);
            if (SpUtil.containsKey(BaseConfig.taskKey)) {
              if (androidVersion < 11) {
                await UseFor10.useDl()
                    ? showToast('解锁画质成功')
                    : showToast('解锁画质失败');
              } else if (await SharedStorage.checkMainUri()) {
                await UseFor11.useDl()
                    ? showToast('解锁画质成功')
                    : showToast('解锁画质失败');
              } else {
                AppDialog.safDialog();
              }
            } else {
              AppDialog.taskDialog();
            }
          },
          child: const Text('解锁'),
        ),
      ],
    ));
  }

  ///解锁音质弹窗
  static void useTqDialog({required title, required subTitle}) {
    Get.dialog(AlertDialog(
      title: Text(title),
      content: Text(subTitle),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('取消')),
        TextButton(
          onPressed: () async {
            Get.back();
            final androidVersion = double.parse(DeviceInfo.androidVersion);
            if (SpUtil.containsKey(BaseConfig.taskKey)) {
              if (androidVersion < 11) {
                await UseFor10.useTq()
                    ? showToast('解锁音质成功')
                    : showToast('解锁音质失败');
              } else if (await SharedStorage.checkMainUri()) {
                await UseFor11.useTq()
                    ? showToast('解锁音质成功')
                    : showToast('解锁音质失败');
              } else {
                AppDialog.safDialog();
              }
            } else {
              AppDialog.taskDialog();
            }
          },
          child: const Text('解锁'),
        ),
      ],
    ));
  }

  ///还原功能弹窗
  static void restoreDialog({required title, required subTitle}) {
    Get.dialog(AlertDialog(
      title: Text(title),
      content: Text(subTitle),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('取消')),
        TextButton(
          onPressed: () async {
            Get.back();
            final androidVersion = double.parse(DeviceInfo.androidVersion);
            if (SpUtil.containsKey(BaseConfig.taskKey)) {
              if (androidVersion < 11) {
                await UseFor10.restoreTq()
                    ? showToast('还原音质成功')
                    : showToast('还原音质失败');
              } else if (await SharedStorage.checkMainUri()) {
                await UseFor11.restoreTq()
                    ? showToast('还原音质成功')
                    : showToast('还原音质失败');
              } else {
                AppDialog.safDialog();
              }
            } else {
              AppDialog.taskDialog();
            }
          },
          child: const Text('还原音质'),
        ),
        TextButton(
          onPressed: () async {
            Get.back();
            final androidVersion = double.parse(DeviceInfo.androidVersion);
            if (SpUtil.containsKey(BaseConfig.taskKey)) {
              if (androidVersion < 11) {
                await UseFor10.restorePq() && await UseFor10.restoreDl()
                    ? showToast('还原画质成功，重启游戏后生效')
                    : showToast('还原画质失败');
              } else if (await SharedStorage.checkMainUri()) {
                await UseFor11.restorePq() && await UseFor11.restoreDl()
                    ? showToast('还原画质成功，重启游戏后生效')
                    : showToast('还原画质失败');
              } else {
                AppDialog.safDialog();
              }
            } else {
              AppDialog.taskDialog();
            }
          },
          child: const Text('还原画质'),
        ),
      ],
    ));
  }

  ///陀螺仪弹窗
  static void useGyroDialog({required String title, required String subTitle}) {
    Get.dialog(AlertDialog(
      title: Text(title),
      content: Text(subTitle),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('取消')),
        TextButton(
            onPressed: () {
              Get.back();
              if (SpUtil.containsKey(BaseConfig.taskKey)) {
                Clipboard.setData(
                    const ClipboardData(text: '3044-2867-9345-7278'));
                showToast('复制成功');
              } else {
                AppDialog.taskDialog();
              }
            },
            child: const Text('1K陀螺仪')),
        TextButton(
            onPressed: () {
              Get.back();
              SpUtil.containsKey(BaseConfig.taskKey)
                  ? showToast('优化成功')
                  : AppDialog.taskDialog();
            },
            child: const Text('优化陀螺仪')),
      ],
    ));
  }

  ///下载超频软件弹窗
  static void useOcDialog({required String title, required String subTitle}) {
    Get.dialog(AlertDialog(
      title: Text(title),
      content: Text(subTitle),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('取消')),
        TextButton(
            onPressed: () async {
              Get.back();
              SpUtil.containsKey(BaseConfig.taskKey)
                  ? BaseUtil.openUrl(BaseConfig.ocDownloadUrl)
                  : AppDialog.taskDialog();
            },
            child: const Text('下载')),
      ],
    ));
  }

  ///花里胡哨功能弹窗
  static void useOtherDialog(
      {required String title,
      required String subTitle,
      required String buttonText}) {
    Get.dialog(AlertDialog(
      title: Text(title),
      content: Text(subTitle),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('取消')),
        TextButton(
          onPressed: () {
            Get.back();
            SpUtil.containsKey(BaseConfig.taskKey)
                ? showToast('$buttonText成功')
                : AppDialog.taskDialog();
          },
          child: Text(buttonText),
        ),
      ],
    ));
  }
}
