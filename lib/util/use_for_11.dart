import 'package:flutter/services.dart';

import '../util/util.dart';
import '../config/config.dart';

class UseFor11 {
  ///修改画质
  static Future<bool> usePq(String rootFilePath) async {
    final rootFileContent = await rootBundle.loadString(rootFilePath);

    if (await SharedStorage.fileExist(GameFileName.pqFileName)) {
      final fileContent =
          await SharedStorage.readFileContent(UriConfig.pqFileUri);

      if (fileContent != null && fileContent.contains(GameFileName.backUp)) {
        final backUpContent = fileContent.substring(
          fileContent.indexOf(GameFileName.backUp),
        );

        await SharedStorage.writeFileContent(
          UriConfig.pqFileUri,
          '$rootFileContent\n$backUpContent',
        );

        return true;
      } else {
        await SharedStorage.writeFileContent(
          UriConfig.pqFileUri,
          rootFileContent,
        );

        return true;
      }
    } else {
      await SharedStorage.createFile(GameFileName.pqFileName, rootFileContent);
      return true;
    }
  }

  ///解锁画质帧率
  static Future<bool> useDl() async {
    final rootFileContent = await rootBundle.loadString(FileConfig.dlPq120Fps);

    if (await SharedStorage.fileExist(GameFileName.dlFileName)) {
      return await SharedStorage.writeFileContent(
        UriConfig.dlFileUri,
        rootFileContent,
      );
    }

    return await SharedStorage.createFile(
      GameFileName.dlFileName,
      rootFileContent,
    );
  }

  ///解锁音质
  static Future<bool> useTq() async {
    final rootFileContent =
        await rootBundle.loadString(FileConfig.tqFileSuperHigh);

    if (await SharedStorage.fileExist(GameFileName.tqFileName)) {
      return await SharedStorage.writeFileContent(
        UriConfig.tqFileUri,
        rootFileContent,
      );
    }

    return await SharedStorage.createFile(
      GameFileName.tqFileName,
      rootFileContent,
    );
  }

  ///还原画质
  static Future<bool> restorePq() async {
    if (await SharedStorage.fileExist(GameFileName.pqFileName)) {
      return await SharedStorage.writeFileContent(UriConfig.pqFileUri, '');
    }

    return true;
  }

  ///还原解锁画质
  static Future<bool> restoreDl() async {
    if (await SharedStorage.fileExist(GameFileName.dlFileName)) {
      SharedStorage.deleteFile(UriConfig.dlFileUri);
      return true;
    }
    return true;
  }

  ///还原解锁音质
  static Future<bool> restoreTq() async {
    if (await SharedStorage.fileExist(GameFileName.tqFileName)) {
      return await SharedStorage.writeFileContent(UriConfig.tqFileUri, '');
    }
    return true;
  }
}
