import 'package:flutter/material.dart';
import '../models/word.dart';
import '../services/notification_service.dart';
import '../services/vocab_service.dart';

/// Menu "Học từ": nhập nghĩa + Check
class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});
  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  final ctrl = TextEditingController();
  List<Word> words = [];
  bool loading = true;
  int index = 0, right = 0, wrong = 0;

  @override
  void initState() {
    super.initState();
    VocabService().load().then((list) {
      list.shuffle();
      if (mounted) setState(() {
        words = list;
        loading = false;
      });
    });
  }

  void check() {
    if (words.isEmpty) return;
    final w = words[index];
    final ok = ctrl.text.trim().toLowerCase() == w.meaning.trim().toLowerCase();
    setState(() {
      ok ? right++ : wrong++;
      index = (index + 1) % words.length;
      ctrl.clear();
    });
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(ok ? 'Chính xác!' : 'Sai rồi'),
        backgroundColor: ok ? Colors.green : Colors.red,
      ));
    // số từ sai là bội số của 3 -> notification
    if (!ok && wrong % 3 == 0) {
      NotificationService.instance.show(
        id: 3,
        title: 'Cần ôn tập thêm',
        body: 'Bạn đã trả lời sai $wrong từ. Hãy ôn lại nhé!',
        channelId: 'vocab_channel',
        channelName: 'Từ vựng',
      );
    }
  }

  Widget badge(Color c, IconData icon, String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(8)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 18),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ôn tập từ mới')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : words.isEmpty
              ? const Center(child: Text('Chưa có từ nào. Hãy thêm từ ở trang chính.'))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          badge(Colors.green, Icons.check, '$right từ'),
                          const SizedBox(width: 24),
                          badge(Colors.orange, Icons.close, '$wrong từ'),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade100,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Text(words[index].word,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 12),
                            TextField(
                              controller: ctrl,
                              decoration: const InputDecoration(
                                hintText: 'Nhập nghĩa tiếng Việt',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                              ),
                              onSubmitted: (_) => check(),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: check,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[800],
                                  foregroundColor: Colors.white),
                              child: const Text('Check'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
