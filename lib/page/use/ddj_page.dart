import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../widgets/widgets.dart';

class DdjPage extends StatelessWidget {
  const DdjPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('低端机'),
        backgroundColor: const Color.fromRGBO(237, 78, 75, 1),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: List.generate(FunConfig.useDdjData.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: OnButton(
                title: FunConfig.useDdjData[index],
                color: const Color.fromRGBO(237, 78, 75, 0.2),
                textColor: const Color.fromRGBO(237, 78, 75, 1),
                onTap: () => onUse(index),
              ),
            );
          }),
        ),
      ),
    );
  }

  void onUse(int index) {
    UseDialog.usePqDialog(filePath: FileConfig.ddjFile[index]);
  }
}
