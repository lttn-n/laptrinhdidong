class Todo {
  final int id; // dùng làm id notification
  String title;
  DateTime time;

  Todo({required this.id, required this.title, required this.time});

  String toFileString() =>
      '$id|${title.replaceAll('|', ' ')}|${time.toIso8601String()}';

  static Todo fromString(String line) {
    final p = line.split('|');
    return Todo(id: int.parse(p[0]), title: p[1], time: DateTime.parse(p[2]));
  }
}