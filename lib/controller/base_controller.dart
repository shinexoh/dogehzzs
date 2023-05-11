import 'package:get/get.dart';

class BaseController extends GetxController {
  ///任务状态
  RxBool taskState = false.obs;

  ///存储权限状态
  RxBool storageState = false.obs;

  ///目录授予状态
  RxBool directoryState = false.obs;

  void setTaskState(bool value) => taskState.value = value;

  void setStorageState(bool value) => storageState.value = value;

  void setDirectoryState(bool value) => directoryState.value = value;
}
