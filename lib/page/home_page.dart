import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';
import '../config/config.dart';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.initSubTitle();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          appBar(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bannerBar(),
                  extraBar(),
                  textBar('快捷修改'),
                  startBar(),
                  textBar('多样化修改'),
                  diversifyBar(),
                  textBar('机型修改'),
                  modelBar(),
                  textBar('性能优化'),
                  openBar(),
                  textBar('其他功能'),
                  otherBar(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget appBar() {
    return Material(
        color: Colors.green,
        elevation: 1,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '首页',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Obx(() => Text(homeController.subTitle.value,
                      style: const TextStyle(color: Colors.white))),
                ],
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black.withOpacity(0.1),
                    ),
                    child: IconButton(
                      onPressed: homeController.onShare,
                      tooltip: '分享',
                      icon: const Icon(Icons.share, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black.withOpacity(0.1),
                    ),
                    child: IconButton(
                      onPressed: homeController.onRefresh,
                      tooltip: '重启',
                      icon: const Icon(Icons.refresh, color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        )));
  }

  Widget bannerBar() {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.18,
          width: double.infinity,
          child: Swiper(
            itemCount: homeController.bannerData.length,
            autoplay: true,
            viewportFraction: 0.85,
            scale: 0.92,
            onTap: (index) => homeController.onBanner(index),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          AssetImage(homeController.bannerData[index]['image']),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.3),
                    padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10),
                    child: Text(homeController.bannerData[index]['title'],
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
              );
            },
          ),
        ));
  }

  Widget extraBar() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          OnInk(
            onTap: homeController.onHelp,
            child: Column(children: [
              Image.asset(AppAssets.homeHelp, height: 30, width: 30),
              const Text('使用帮助', style: TextStyle(fontSize: 13))
            ]),
          ),
          OnInk(
            onTap: homeController.onBox,
            child: Column(children: [
              Image.asset(AppAssets.homeBox, height: 30, width: 30),
              const Text('学生福利', style: TextStyle(fontSize: 13))
            ]),
          ),
          OnInk(
            onTap: homeController.onWeb,
            child: Column(children: [
              Image.asset(AppAssets.homeWeb, height: 30, width: 30),
              const Text('官方网址', style: TextStyle(fontSize: 13))
            ]),
          ),
          OnInk(
            onTap: homeController.onFeedBack,
            child: Column(children: [
              Image.asset(AppAssets.homeFeedback, height: 30, width: 30),
              const Text('应用反馈', style: TextStyle(fontSize: 13))
            ]),
          ),
        ],
      ),
    );
  }

  Widget startBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        children: List.generate(FunConfig.startData.length, (index) {
          return OnInk(
            width: double.infinity,
            height: 60,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            margin: EdgeInsets.only(bottom: index == 5 ? 0 : 10),
            onTap: () => homeController.onStarts(index),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Image.asset(AppAssets.emoji1, width: 32, height: 32),
                    const SizedBox(width: 10),
                    Text(FunConfig.startData[index])
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text('点击修改',
                      style: TextStyle(fontSize: 13, color: Colors.green)),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget diversifyBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        children: List.generate(FunConfig.diversifyData.length, (index) {
          return OnInk(
            width: double.infinity,
            height: 60,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            margin: EdgeInsets.only(bottom: index == 1 ? 0 : 10),
            onTap: () => homeController.onDiversify(index),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Image.asset(AppAssets.emoji2, width: 32, height: 32),
                    const SizedBox(width: 10),
                    Text(FunConfig.diversifyData[index]),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    '点击进入',
                    style: TextStyle(fontSize: 13, color: Colors.orange),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget modelBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        children: List.generate(FunConfig.modelData.length, (index) {
          return OnInk(
            width: double.infinity,
            height: 60,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            margin: EdgeInsets.only(bottom: index == 2 ? 0 : 10),
            onTap: () => homeController.onModel(index),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Image.asset(AppAssets.emoji3, width: 32, height: 32),
                    const SizedBox(width: 10),
                    Text(FunConfig.modelData[index]),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(237, 78, 75, 0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    '点击进入',
                    style: TextStyle(
                        fontSize: 13, color: Color.fromRGBO(237, 78, 75, 1)),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget openBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        children: List.generate(FunConfig.openData.length, (index) {
          return OnInk(
            width: double.infinity,
            height: 60,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            margin: EdgeInsets.only(bottom: index == 2 ? 0 : 10),
            onTap: () => homeController.onOpen(index),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Image.asset(AppAssets.emoji4, width: 32, height: 32),
                    const SizedBox(width: 10),
                    Text(FunConfig.openData[index]['title']),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(145, 88, 175, 0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    index == 0
                        ? '点击修复'
                        : index == 1
                            ? '点击注入'
                            : '点击下载',
                    style: const TextStyle(
                        fontSize: 13, color: Color.fromRGBO(145, 88, 175, 1)),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget otherBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        children: List.generate(FunConfig.otherData.length, (index) {
          return OnInk(
            width: double.infinity,
            height: 60,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            margin: const EdgeInsets.only(bottom: 10),
            onTap: () => homeController.onOther(index),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Image.asset(AppAssets.emoji5, width: 32, height: 32),
                    const SizedBox(width: 10),
                    Text(FunConfig.otherData[index]['title']),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(242, 122, 65, 0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    index <= 1
                        ? '点击解锁'
                        : index == 2
                            ? '点击还原'
                            : '点击优化',
                    style: const TextStyle(
                        fontSize: 13, color: Color.fromRGBO(242, 122, 65, 1)),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget textBar(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: Row(
        children: [
          Image.asset(AppAssets.lightning, height: 22, width: 22),
          Text(text),
        ],
      ),
    );
  }
}
