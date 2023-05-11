import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../config/config.dart';
import '../util/util.dart';
import '../widgets/widgets.dart';

class HomeController extends GetxController {
  //副标题
  RxString subTitle = ''.obs;

  //初始化副标题
  void initSubTitle() {
    final nowDate = DateTime.now().hour;

    if (nowDate >= 6 && nowDate < 11) {
      subTitle.value = '一日之计在于晨，一年之计在于春。';
    } else if (nowDate >= 11 && nowDate < 13) {
      subTitle.value = '享受中午的阳光，感受生命的活力！';
    } else if (nowDate >= 13 && nowDate < 19) {
      subTitle.value = '下午时分，加强学习，充实自己！';
    } else if (nowDate >= 19 && nowDate < 24) {
      subTitle.value = '每个宁静的夜晚都是思考的好时机。';
    } else {
      subTitle.value = '夜深了，放下手机，早点休息。';
    }
  }

  //banner图片说明
  final List bannerData = const [
    {'image': AppAssets.useHelpBanner, 'title': '画质助手使用帮助'},
    {'image': AppAssets.officialWebBanner, 'title': '画质助手永久下载地址'},
    {'image': AppAssets.joinGroupBanner, 'title': '画质助手官方群聊'}
  ];

  //banner点击
  void onBanner(int index) async {
    switch (index) {
      case 0:
        Get.toNamed('/web', arguments: {'url': BaseConfig.helpUrl});
        break;
      case 1:
        BaseUtil.openUrl(BaseConfig.appDownloadUrl);
        break;
      case 2:
        BaseUtil.openQQGroup(739559380);
        break;
    }
  }

  //点击分享
  void onShare() => Share.share(BaseConfig.shareText);

  //点击重启应用
  void onRefresh() => Get.offAllNamed('/');

  //使用帮助
  void onHelp() => Get.toNamed('/web', arguments: {'url': BaseConfig.helpUrl});

  //学生福利
  void onBox() => BaseUtil.openUrl(BaseConfig.jdmUrl);

  //官方网址
  void onWeb() => BaseUtil.openUrl(BaseConfig.appDownloadUrl);

  //应用反馈
  void onFeedBack() => BaseUtil.openQQGroup(739559380);

  //快捷修改
  void onStarts(int index) {
    UseDialog.usePqDialog(
        filePath: FileConfig.kjxgFile[index],
        title: FunConfig.startData[index]);
  }

  //多样化修改
  void onDiversify(int index) =>
      index == 0 ? Get.toNamed('/zsxg') : Get.toNamed('/yjxg');

  //机型修改
  void onModel(int index) {
    switch (index) {
      case 0:
        Get.toNamed('/ddj');
        break;
      case 1:
        Get.toNamed('/zdj');
        break;
      case 2:
        Get.toNamed('/gdj');
        break;
    }
  }

  //性能优化
  void onOpen(int index) {
    switch (index) {
      case 0:
        UseDialog.useOtherDialog(
            title: FunConfig.openData[index]['title'],
            subTitle: FunConfig.openData[index]['subtitle'],
            buttonText: '修复');
        break;
      case 1:
        UseDialog.useOtherDialog(
            title: FunConfig.openData[index]['title'],
            subTitle: FunConfig.openData[index]['subtitle'],
            buttonText: '注入');
        break;
      case 2:
        UseDialog.useOcDialog(
            title: FunConfig.openData[index]['title'],
            subTitle: FunConfig.openData[index]['subtitle']);
        break;
    }
  }

  //其他功能
  void onOther(int index) {
    switch (index) {
      case 0:
        UseDialog.useDlDialog(
            title: FunConfig.otherData[index]['title'],
            subTitle: FunConfig.otherData[index]['subtitle']);
        break;
      case 1:
        UseDialog.useTqDialog(
            title: FunConfig.otherData[index]['title'],
            subTitle: FunConfig.otherData[index]['subtitle']);
        break;
      case 2:
        UseDialog.restoreDialog(
            title: FunConfig.otherData[index]['title'],
            subTitle: FunConfig.otherData[index]['subtitle']);
        break;
      case 3:
        UseDialog.useGyroDialog(
            title: FunConfig.otherData[index]['title'],
            subTitle: FunConfig.otherData[index]['subtitle']);
    }
  }
}
