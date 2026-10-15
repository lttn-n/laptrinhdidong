class Task {
  final int id;
  String title;
  int? hour; // giờ nhắc (null = chưa đặt)
  int? minute;
  bool done;

  Task({required this.id, required this.title, this.hour, this.minute, this.done = false});

  String get reminderText => hour == null
      ? 'Chưa đặt giờ nhắc'
      : 'Nhắc lúc ${hour!.toString().padLeft(2, '0')}:${minute!.toString().padLeft(2, '0')}';

  // id|title|hour|minute|done  (hour/minute = -1 nếu chưa đặt)
  String toFileString() =>
      '$id|${title.replaceAll('|', ' ')}|${hour ?? -1}|${minute ?? -1}|${done ? 1 : 0}';

  static Task fromString(String line) {
    final p = line.split('|');
    final h = int.parse(p[2]), m = int.parse(p[3]);
    return Task(
      id: int.parse(p[0]),
      title: p[1],
      hour: h < 0 ? null : h,
      minute: m < 0 ? null : m,
      done: p[4] == '1',
    );
  }
}