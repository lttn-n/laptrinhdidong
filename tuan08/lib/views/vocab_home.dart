import 'package:flutter/material.dart';
import '../models/word.dart';
import '../services/notification_service.dart';
import '../services/vocab_service.dart';
import 'learn_screen.dart';
import 'quiz_screen.dart';
import 'reminders_screen.dart';

class VocabHome extends StatefulWidget {
  const VocabHome({super.key});
  @override
  State<VocabHome> createState() => _VocabHomeState();
}

class _VocabHomeState extends State<VocabHome> {
  final wordCtrl = TextEditingController();
  final meaningCtrl = TextEditingController();
  final vocab = VocabService();
  final noti = NotificationService.instance;

  Future<void> saveAndRemind() async {
    final w = wordCtrl.text.trim();
    final m = meaningCtrl.text.trim();
    if (w.isEmpty || m.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Hãy nhập từ và nghĩa')));
      return;
    }
    await vocab.add(Word(w, m));
    final id = DateTime.now().millisecondsSinceEpoch % 2000000000;

    // notification báo đã lưu
    await noti.show(
      id: id + 1,
      title: 'Đã lưu từ mới',
      body: '$w · $m - hãy ôn tập sau 10 phút',
      channelId: 'vocab_channel',
      channelName: 'Từ vựng',
    );
    // lên lịch nhắc ôn sau 10 phút (title này dùng để lọc ở màn Lịch nhắc)
    await noti.scheduleAfter(
      const Duration(minutes: 10),
      id: id,
      title: 'Ôn từ vựng mới!',
      body: '$w · $m',
      channelId: 'vocab_channel',
      channelName: 'Từ vựng',
    );

    wordCtrl.clear();
    meaningCtrl.clear();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã lưu và lên lịch nhắc học từ sau 10 phút')),
    );
  }

  void go(Widget page) {
    Navigator.pop(context); // đóng drawer
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ứng dụng học từ vựng')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text('Trợ lý học từ vựng',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Trang chính'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Học từ'),
              onTap: () => go(const LearnScreen()),
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Kiểm tra từ'),
              onTap: () => go(const QuizScreen()),
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Lịch nhắc'),
              onTap: () => go(const RemindersScreen()),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: wordCtrl, decoration: const InputDecoration(labelText: 'Từ')),
            const SizedBox(height: 8),
            TextField(controller: meaningCtrl, decoration: const InputDecoration(labelText: 'Nghĩa')),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: saveAndRemind,
              child: const Text('Lưu & Nhắc học sau 10 phút'),
            ),
          ],
        ),
      ),
    );
  }
}
