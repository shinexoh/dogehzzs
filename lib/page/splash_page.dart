import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../http/http_client.dart';
import '../config/config.dart';
import '../widgets/widgets.dart';
import '../util/util.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    loading();
  }

  void loading() async {
    //设置黑色状态栏
    BaseUtil.setStatusBarDark();
    //实例化网络请求
    HttpClient.getInstance();
    //实例化Sp键值对
    await SpUtil.getInstance();
    //实例化设备信息
    await DeviceInfo.getInstance();
    //预先加载图片资源
    await loadingImage();
    //检查网络状态
    await checkNet();
  }

  Future<void> loadingImage() async {
    const List loadingList = [
      AppAssets.appIcon,
      AppAssets.storage,
      AppAssets.emoji1,
      AppAssets.emoji2,
      AppAssets.emoji3,
      AppAssets.emoji4,
      AppAssets.emoji5,
      AppAssets.homeHelp,
      AppAssets.homeBox,
      AppAssets.homeWeb,
      AppAssets.homeFeedback,
      AppAssets.lightning,
      AppAssets.useHelpBanner,
      AppAssets.officialWebBanner,
      AppAssets.joinGroupBanner,
    ];

    for (var element in loadingList) {
      await precacheImage(AssetImage(element), context);
    }
  }

  Future<void> checkNet() async {
    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity != ConnectivityResult.none) {
      final http = await HttpClient.getInstance().get('https://www.baidu.com/');

      if (http.isOk) {
        await Future.delayed(const Duration(seconds: 1));

        final permissionState = await Permission.storage.status;
        permissionState.isGranted
            ? Get.offNamed('/main')
            : Get.offNamed('/storage');
      } else {
        AppDialog.netErrorDialog();
      }
    } else {
      AppDialog.netErrorDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset(
          AppAssets.appIcon,
          height: 150,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
