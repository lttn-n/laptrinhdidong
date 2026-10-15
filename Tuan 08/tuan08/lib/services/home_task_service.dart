import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/home_task.dart';
class HomeTaskService {
  Future<File> get _file async {
    final dir=await getApplicationDocumentsDirectory();
    return File('${dir.path}/tasks.txt');
  }
  Future<void> saveTasks(List<HomeTask> tasks) async => (await _file).writeAsString(jsonEncode(tasks.map((e)=>e.toJson()).toList()));
  Future<List<HomeTask>> loadTasks() async {
    try {
      final content=await (await _file).readAsString();
      final List data=jsonDecode(content);
      return data.map((e)=>HomeTask.fromJson(Map<String,dynamic>.from(e))).toList();
    } catch(e) {return [];}
  }
}
