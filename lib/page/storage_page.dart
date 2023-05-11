import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

import '../config/config.dart';
import '../util/util.dart';
import '../widgets/widgets.dart';

class StoragePage extends StatefulWidget {
  const StoragePage({super.key});

  @override
  State<StoragePage> createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> with WidgetsBindingObserver {
  final RxBool permissionGranted = false.obs;
  final RxBool canSkip = false.obs;

  @override
  void initState() {
    super.initState();
    checkAndroid11();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      final permissionState = await Permission.storage.status;
      if (permissionState.isGranted) {
        permissionGranted.value = true;
        canSkip.value = false;
      }
    }
  }

  //检查是否安卓11可跳过
  void checkAndroid11() {
    final androidVersion = double.parse(DeviceInfo.androidVersion);
    if (androidVersion >= 11) canSkip.value = true;
  }

  //点击授予按钮
  void onPermission() {
    permissionGranted.value ? Get.offNamed('/main') : requestPermission();
  }

  //点击跳过
  void onSkip() => Get.offNamed('/main');

  //请求权限
  void requestPermission() async {
    final newPermissionState = await Permission.storage.request();

    if (newPermissionState.isGranted) {
      permissionGranted.value = true;
      canSkip.value = false;
    } else if (newPermissionState.isDenied) {
      final finalStatus = await Permission.storage.request();

      if (finalStatus.isGranted) {
        permissionGranted.value = true;
        canSkip.value = false;
      } else {
        AppDialog.permissionDialog();
      }
    } else {
      AppDialog.permissionDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Obx(() {
        return Column(
          children: [
            const SizedBox(height: 30),
            Image.asset(
              AppAssets.storage,
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
            ),
            const SizedBox(height: 10),
            Text(
              permissionGranted.value ? '授予成功' : '温馨提示',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: permissionGranted.value ? Colors.green : null),
            ),
            const SizedBox(height: 10),
            Text(
              permissionGranted.value
                  ? '请点击下方进入软件开启你的旅程吧！'
                  : '你需要为画质助手授予存储权限\n请点击下方申请授予来获得权限',
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const Spacer(),
            OnInk(
              width: double.infinity,
              color: permissionGranted.value ? Colors.green : Colors.black,
              margin: EdgeInsets.only(
                left: 90,
                right: 90,
                bottom: canSkip.value ? 0 : 30,
              ),
              borderRadius: BorderRadius.circular(15),
              splashFactory: true,
              onTap: onPermission,
              child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    permissionGranted.value ? '进入软件' : '申请授予',
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  )),
            ),
            if (canSkip.value)
              OnInk(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  top: 10,
                  left: 90,
                  right: 90,
                  bottom: 30,
                ),
                borderRadius: BorderRadius.circular(15),
                splashFactory: true,
                onTap: onSkip,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade200)),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: const Text('跳过', style: TextStyle(fontSize: 15)),
                ),
              ),
          ],
        );
      })),
    );
  }
}
