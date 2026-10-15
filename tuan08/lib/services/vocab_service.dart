import '../models/word.dart';
import 'file_service.dart';

class VocabService {
  final _file = FileService('vocab.txt');

  Future<List<Word>> load() async =>
      (await _file.readLines()).map(Word.fromString).toList();

  Future<void> add(Word w) async {
    final lines = await _file.readLines();
    lines.add(w.toFileString());
    await _file.writeLines(lines);
  }
}