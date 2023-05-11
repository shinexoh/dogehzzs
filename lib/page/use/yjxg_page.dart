import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../widgets/widgets.dart';

class YjxgPage extends StatelessWidget {
  const YjxgPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('一键修改'), backgroundColor: Colors.orange),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: List.generate(FunConfig.useYjxgData.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: OnButton(
                title: FunConfig.useYjxgData[index],
                color: Colors.orange.withOpacity(0.15),
                textColor: Colors.orange,
                onTap: () => onUse(index),
              ),
            );
          }),
        ),
      ),
    );
  }

  void onUse(int index) {
    UseDialog.usePqDialog(filePath: FileConfig.yjxgFile[index]);
  }
}
