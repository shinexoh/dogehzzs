import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';
import '../config/config.dart';
import '../util/util.dart';

class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  final baseController = Get.put(BaseController());

  late final dynamic arguments;
  late final WebViewController webViewController;
  final RxString webTitle = '正在加载中...'.obs;
  final RxBool showView = false.obs;

  @override
  void initState() {
    super.initState();
    arguments = Get.arguments;
    initWebView();
  }

  void initWebView() {
    webViewController = WebViewController()
      ..loadRequest(Uri.parse(arguments?['url'] ?? BaseConfig.webErrorUrl))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(false)
      ..setNavigationDelegate(NavigationDelegate(
          onPageStarted: (url) => showView.value = false,
          onPageFinished: (url) async {
            showView.value = true;

            final title = await webViewController.getTitle() ?? '';
            webTitle.value = title;

            if (title == '任务完成') {
              SpUtil.addString(BaseConfig.taskKey, '');
              baseController.setTaskState(true);
              Get.back();
              Get.back();
              showToast('恭喜你，任务完成！');
            }
          }));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text(webTitle.value),
          actions: [optionBar()],
        ),
        body: Center(
          child: !showView.value
              ? const CircularProgressIndicator()
              : WebViewWidget(controller: webViewController),
        ),
      );
    });
  }

  Widget optionBar() {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tooltip: '更多选项',
      itemBuilder: (context) {
        return [
          if (arguments?['tgurl'] != null)
            const PopupMenuItem(
              value: 0,
              child: Text('打开链接', style: TextStyle(color: Colors.green)),
            ),
          const PopupMenuItem(value: 1, child: Text('刷新网页'))
        ];
      },
      onSelected: (value) {
        value == 0
            ? BaseUtil.openUrl(arguments['tgurl'])
            : webViewController.reload();
      },
    );
  }
}
