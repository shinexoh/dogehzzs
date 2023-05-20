import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:get/get.dart';

import '../http/api.dart';
import '../http/http_client.dart';
import '../widgets/widgets.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final List taskList = [].obs;

  @override
  void initState() {
    super.initState();
    getTaskList();
  }

  void getTaskList() async {
    final taskListData = await HttpClient.get(Api.main);

    if (taskListData.isOk) {
      for (var element in taskListData.data['tasklist']) {
        taskList.add(element);
      }
    }
  }

  void onTaskList(int index) {
    Get.toNamed('/web', arguments: {
      'url': taskList[index]['taskurl'],
      'tgurl': taskList[index]['tgurl'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('任务大厅')),
      body: Obx(() => Center(
            child: taskList.isEmpty
                ? const CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                        children: List.generate(taskList.length, (index) {
                      return taskListBar(index);
                    })),
                  ),
          )),
    );
  }

  Widget taskListBar(int index) {
    return OnInk(
      width: double.infinity,
      color: Colors.white,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      borderRadius: BorderRadius.circular(10),
      onTap: () => onTaskList(index),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10)),
              child: FadeInImage(
                  fadeInDuration: const Duration(milliseconds: 120),
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(taskList[index]['image'])),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskList[index]['title'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 3),
                Text(
                  taskList[index]['subtitle'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
