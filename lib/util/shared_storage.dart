import 'package:shared_storage/shared_storage.dart';

import '../config/config.dart';

class SharedStorage {
  ///检查MainUri目录是否已经授予
  static Future<bool> checkMainUri() async {
    return await isPersistedUri(UriConfig.mainUri);
  }

  ///拉起SAF授予MainUri目录权限
  static Future<GrantUriState> grantUriDirectory() async {
    final grantUri = await openDocumentTree(initialUri: UriConfig.mainUri);

    if (grantUri != null) {
      return grantUri == UriConfig.mainUri
          ? GrantUriState.success
          : GrantUriState.wrong;
    }
    return GrantUriState.notSelected;
  }

  ///查看目录下的文件是否存在
  static Future<bool> fileExist(String fileName) async {
    final file = await findFile(UriConfig.mainUri, fileName);

    return file != null ? true : false;
  }

  ///读取指定文件的内容（需要先判断文件是否存在，防止崩溃）
  static Future<String?> readFileContent(Uri fileUri) async {
    final fileContent = await getDocumentContentAsString(fileUri);
    if (fileContent != null) {
      return fileContent;
    }
    return null;
  }

  ///写入内容到指定文件内（需要先判断文件是否存在，防止崩溃）
  static Future<bool> writeFileContent(Uri fileUri, String content) async {
    final fileWrite = await writeToFileAsString(fileUri, content: content);
    if (fileWrite != null && fileWrite == true) {
      return true;
    }
    return false;
  }

  ///创建文件（需要先判断文件是否存在，防止多生成几份备份文件）
  static Future<bool> createFile(String fileName, String content) async {
    final fileCreate = await createFileAsString(
      UriConfig.mainUri,
      mimeType: '',
      displayName: fileName,
      content: content,
    );
    if (fileCreate != null) {
      return true;
    }
    return false;
  }

  ///删除文件（需要先判断文件是否存在，防止崩溃）
  static Future<bool> deleteFile(Uri fileUri) async {
    final fileDelete = await delete(fileUri);
    if (fileDelete != null && fileDelete == true) {
      return true;
    }
    return false;
  }
}
