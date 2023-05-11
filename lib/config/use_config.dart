//安卓11+
class UriConfig {
  // static final mainUri = Uri.parse(
  //     'content://com.android.externalstorage.documents/tree/primary%3AAndroid%2Fdata%2Fmark.via%2Fdemo');

  // static final pqFileUri = Uri.parse(
  //     'content://com.android.externalstorage.documents/tree/primary%3AAndroid%2Fdata%2Fmark.via%2Fdemo/document/primary%3AAndroid%2Fdata%2Fmark.via%2Fdemo%2FUserCustom.ini');

  // static final dlFileUri = Uri.parse(
  //     'content://com.android.externalstorage.documents/tree/primary%3AAndroid%2Fdata%2Fmark.via%2Fdemo/document/primary%3AAndroid%2Fdata%2Fmark.via%2Fdemo%2FEnjoyCJZC.ini');

  // static final tqFileUri = Uri.parse(
  //     'content://com.android.externalstorage.documents/tree/primary%3AAndroid%2Fdata%2Fmark.via%2Fdemo/document/primary%3AAndroid%2Fdata%2Fmark.via%2Fdemo%2FUserSettings.ini');

  static final mainUri = Uri.parse(
      'content://com.android.externalstorage.documents/tree/primary%3AAndroid%2Fdata%2Fcom.tencent.tmgp.pubgmhd%2Ffiles%2FUE4Game%2FShadowTrackerExtra%2FShadowTrackerExtra%2FSaved%2FConfig%2FAndroid');

  static final pqFileUri = Uri.parse(
      '$mainUri/document/primary%3AAndroid%2Fdata%2Fcom.tencent.tmgp.pubgmhd%2Ffiles%2FUE4Game%2FShadowTrackerExtra%2FShadowTrackerExtra%2FSaved%2FConfig%2FAndroid%2FUserCustom.ini');

  static final dlFileUri = Uri.parse(
      '$mainUri/document/primary%3AAndroid%2Fdata%2Fcom.tencent.tmgp.pubgmhd%2Ffiles%2FUE4Game%2FShadowTrackerExtra%2FShadowTrackerExtra%2FSaved%2FConfig%2FAndroid%2FEnjoyCJZC.ini');

  static final tqFileUri = Uri.parse(
      '$mainUri/document/primary%3AAndroid%2Fdata%2Fcom.tencent.tmgp.pubgmhd%2Ffiles%2FUE4Game%2FShadowTrackerExtra%2FShadowTrackerExtra%2FSaved%2FConfig%2FAndroid%2FUserSettings.ini');
}

//安卓10-
class GameFilePath {
  static const String pqFilePath =
      '/storage/emulated/0/Android/data/com.tencent.tmgp.pubgmhd/files/UE4Game/ShadowTrackerExtra/ShadowTrackerExtra/Saved/Config/Android/${GameFileName.pqFileName}';
  static const String dlFilePath =
      '/storage/emulated/0/Android/data/com.tencent.tmgp.pubgmhd/files/UE4Game/ShadowTrackerExtra/ShadowTrackerExtra/Saved/Config/Android/${GameFileName.dlFileName}';
  static const String tqFilePath =
      '/storage/emulated/0/Android/data/com.tencent.tmgp.pubgmhd/files/UE4Game/ShadowTrackerExtra/ShadowTrackerExtra/Saved/Config/Android/${GameFileName.tqFileName}';
}

//游戏文件名
class GameFileName {
  static const String pqFileName = 'UserCustom.ini';
  static const String dlFileName = 'EnjoyCJZC.ini';
  static const String tqFileName = 'UserSettings.ini';

  //文件内容标签
  static const String userCustom = '[UserCustom DeviceProfile]';
  static const String backUp = '[BackUp DeviceProfile]';
}

//目录授权状态枚举
enum GrantUriState { success, wrong, notSelected }
