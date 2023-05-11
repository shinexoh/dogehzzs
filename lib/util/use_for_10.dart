import 'dart:io';
import 'package:flutter/services.dart';

import '../config/config.dart';

class UseFor10 {
  ///修改画质
  static Future<bool> usePq(String rootFilePath) async {
    final rootFileContent = await rootBundle.loadString(rootFilePath);
    final pqFile = File(GameFilePath.pqFilePath);

    if (await pqFile.exists()) {
      final fileContent = await pqFile.readAsString();

      if (fileContent.contains(GameFileName.backUp)) {
        final backUpContent = fileContent.substring(
          fileContent.indexOf(GameFileName.backUp),
        );

        await pqFile.writeAsString('$rootFileContent\n$backUpContent');

        return true;
      } else {
        await pqFile.writeAsString(rootFileContent);
        return true;
      }
    } else {
      await pqFile.create(recursive: true);
      await pqFile.writeAsString(rootFileContent);

      return true;
    }
  }

  ///解锁画质
  static Future<bool> useDl() async {
    final rootFileContent = await rootBundle.loadString(FileConfig.dlPq120Fps);
    final dlFile = File(GameFilePath.dlFilePath);

    if (await dlFile.exists()) {
      await dlFile.writeAsString(rootFileContent);
      return true;
    }

    await dlFile.create(recursive: true);
    await dlFile.writeAsString(rootFileContent);
    return true;
  }

  ///解锁音质
  static Future<bool> useTq() async {
    final rootFileContent =
        await rootBundle.loadString(FileConfig.tqFileSuperHigh);
    final tqFile = File(GameFilePath.tqFilePath);

    if (await tqFile.exists()) {
      await tqFile.writeAsString(rootFileContent);
      return true;
    }

    await tqFile.create(recursive: true);
    await tqFile.writeAsString(rootFileContent);
    return true;
  }

  ///还原画质
  static Future<bool> restorePq() async {
    final pqFile = File(GameFilePath.pqFilePath);
    if (await pqFile.exists()) {
      await pqFile.writeAsString('');
      return true;
    }
    return true;
  }

  ///还原解锁画质
  static Future<bool> restoreDl() async {
    final dlFile = File(GameFilePath.dlFilePath);
    if (await dlFile.exists()) {
      dlFile.delete();
      return true;
    }
    return true;
  }

  ///还原解锁音质
  static Future<bool> restoreTq() async {
    final tqFile = File(GameFilePath.tqFilePath);
    if (await tqFile.exists()) {
      await tqFile.writeAsString('');
      return true;
    }
    return true;
  }
}
