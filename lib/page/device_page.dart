import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';
import '../widgets/widgets.dart';
import '../util/util.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  final baseController = Get.put(BaseController());

  late String model;
  late String androidVersion;
  late String sdkVersion;
  late String res;
  late String cpu;
  late int battery;

  @override
  void initState() {
    super.initState();
    initDeviceInfo();
  }

  void initDeviceInfo() {
    model = DeviceInfo.model;
    androidVersion = DeviceInfo.androidVersion;
    sdkVersion = DeviceInfo.sdkVersion;
    res = '1920×1080';
    cpu = DeviceInfo.cpu;
    battery = DeviceInfo.batteryLevel;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            sdBar(),
            const SizedBox(height: 10),
            maBar(),
            const SizedBox(height: 10),
            srBar(),
            const SizedBox(height: 10),
            cbBar(),
            tipsBar(),
          ],
        ),
      )),
    );
  }

  Widget sdBar() {
    return Obx(() => Row(
          children: [
            Expanded(
                child: DeviceBar(
              icon: const Icon(Icons.save_as, color: Colors.white),
              margin: const EdgeInsets.only(left: 10),
              color: const Color(0xFF5D5F61),
              title: '存储权限',
              subTitle: baseController.storageState.value ? '已授予' : '未授予',
            )),
            const SizedBox(width: 10),
            Expanded(
                child: DeviceBar(
              icon: const Icon(Icons.folder, color: Colors.white),
              margin: const EdgeInsets.only(right: 10),
              color: const Color(0xFF6388E2),
              title: '游戏目录权限',
              subTitle: baseController.directoryState.value ? '已授予' : '未授予',
            )),
          ],
        ));
  }

  Widget maBar() {
    return Row(
      children: [
        Expanded(
            child: DeviceBar(
          icon: const Icon(Icons.phone_android, color: Colors.white),
          margin: const EdgeInsets.only(left: 10),
          color: Colors.blue,
          title: '手机型号',
          subTitle: model,
        )),
        const SizedBox(width: 10),
        Expanded(
            child: DeviceBar(
          icon: const Icon(Icons.android, color: Colors.white),
          margin: const EdgeInsets.only(right: 10),
          color: Colors.green,
          title: '安卓版本',
          subTitle: androidVersion,
        )),
      ],
    );
  }

  Widget srBar() {
    return Row(
      children: [
        Expanded(
            child: DeviceBar(
          icon: const Icon(Icons.adb, color: Colors.white),
          margin: const EdgeInsets.only(left: 10),
          color: Colors.cyan,
          title: 'SDK版本',
          subTitle: sdkVersion,
        )),
        const SizedBox(width: 10),
        Expanded(
            child: DeviceBar(
          icon: const Icon(Icons.smartphone, color: Colors.white),
          margin: const EdgeInsets.only(right: 10),
          color: Colors.orange,
          title: '分辨率',
          subTitle: res,
        )),
      ],
    );
  }

  Widget cbBar() {
    return Row(
      children: [
        Expanded(
            child: DeviceBar(
          icon: const Icon(Icons.memory, color: Colors.white),
          margin: const EdgeInsets.only(left: 10),
          color: Colors.red,
          title: '处理器',
          subTitle: cpu,
        )),
        const SizedBox(width: 10),
        Expanded(
            child: DeviceBar(
          icon: const Icon(Icons.battery_charging_full, color: Colors.white),
          margin: const EdgeInsets.only(right: 10),
          color: Colors.purple,
          title: '当前电量',
          subTitle: battery == 100 ? '已充满' : '$battery%',
        )),
      ],
    );
  }

  Widget tipsBar() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
      child: const Text(
        '虽然画质助手可以提高游戏流畅度以及画质，但仅仅只是起到辅助作用，如果设备本不支持高画质，那么使用画质助手来提升可能会消耗太多的资源，也可能会使设备变得缓慢或不稳定。提高设备的配置才是提升流畅度以及高画质的主要因素。',
      ),
    );
  }
}
