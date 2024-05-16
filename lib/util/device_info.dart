import 'package:device_info_plus/device_info_plus.dart';
import 'package:battery_plus/battery_plus.dart';

class DeviceInfo {
  static DeviceInfo? _instance;

  DeviceInfo._();

  static late AndroidDeviceInfo _androidDeviceInfo;
  static late int _batteryLevel;

  static Future<DeviceInfo> getInstance() async {
    if (_instance == null) {
      _instance = DeviceInfo._();

      _androidDeviceInfo = await DeviceInfoPlugin().androidInfo;
      _batteryLevel = await Battery().batteryLevel;
    }
    return _instance!;
  }

  ///手机型号
  static String get model => _androidDeviceInfo.model;

  ///CPU信息
  static String get cpu => _androidDeviceInfo.board;

  ///安卓版本号
  static String get androidVersion => _androidDeviceInfo.version.release;

  ///安卓SDK版本号
  static String get sdkVersion => _androidDeviceInfo.version.sdkInt.toString();

  ///屏幕高度
  // static String get screenHeight =>
  //     _androidDeviceInfo.displayMetrics.heightPx.toInt().toString();

  // ///屏幕宽度
  // static String get screenWidth =>
  //     _androidDeviceInfo.displayMetrics.widthPx.toInt().toString();

  ///获取当前电量值
  static int get batteryLevel => _batteryLevel;
}
