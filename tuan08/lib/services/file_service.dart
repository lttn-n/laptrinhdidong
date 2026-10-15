import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// Đọc/ghi file text theo từng dòng trong thư mục Documents của app.
class FileService {
  final String fileName;
  FileService(this.fileName);

  Future<String> get _path async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get _file async => File('${await _path}/$fileName');

  Future<void> writeLines(List<String> lines) async {
    final file = await _file;
    await file.writeAsString(lines.join('\n'));
  }

  Future<List<String>> readLines() async {
    try {
      final file = await _file;
      if (!await file.exists()) return [];
      final content = await file.readAsString();
      return content.split('\n').where((e) => e.trim().isNotEmpty).toList();
    } catch (e) {
      return [];
    }
  }
}