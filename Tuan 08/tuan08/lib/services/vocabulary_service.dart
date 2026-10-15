import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/vocabulary.dart';
class VocabularyService {
  Future<File> get _file async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/vocabulary.txt');
  }
  Future<void> saveWords(List<Vocabulary> words) async {
    await (await _file).writeAsString(words.map((e)=>e.toFileString()).join('\n'));
  }
  Future<List<Vocabulary>> loadWords() async {
    try {
      final content = await (await _file).readAsString();
      return content.split('\n').where((e)=>e.isNotEmpty).map(Vocabulary.fromString).toList();
    } catch (e) { return []; }
  }
}
