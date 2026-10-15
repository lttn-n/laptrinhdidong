import 'dart:math';
import 'package:flutter/material.dart';
import '../models/word.dart';
import '../services/vocab_service.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  static const total = 10;
  final rnd = Random();
  List<Word> words = [];
  bool loading = true;
  Word? cur;
  String shown = '';
  bool isTrue = true;
  int q = 0, right = 0, wrong = 0;

  @override
  void initState() {
    super.initState();
    VocabService().load().then((list) {
      words = list;
      if (words.isNotEmpty) _next();
      if (mounted) setState(() => loading = false);
    });
  }

  void _next() {
    cur = words[rnd.nextInt(words.length)];
    isTrue = rnd.nextBool();
    final others = words.where((w) => w.meaning != cur!.meaning).toList();
    if (isTrue || others.isEmpty) {
      isTrue = true;
      shown = cur!.meaning;
    } else {
      shown = others[rnd.nextInt(others.length)].meaning;
    }
  }

  void answer(bool userSaysTrue) {
    setState(() {
      userSaysTrue == isTrue ? right++ : wrong++;
      q++;
    });
    if (q >= total) {
      _finish();
    } else {
      setState(_next);
    }
  }

  void _finish() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Kết thúc bài kiểm tra'),
        content: Text('Tổng số câu: $total\n✔ Đúng: $right\n✘ Sai: $wrong\n'
            'Tỷ lệ chính xác: ${(right * 100 / total).toStringAsFixed(1)}%'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                q = 0;
                right = 0;
                wrong = 0;
                _next();
              });
            },
            child: const Text('Làm lại'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Thoát'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trắc nghiệm Đúng / Sai')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : words.isEmpty
              ? const Center(child: Text('Chưa có từ nào. Hãy thêm từ ở trang chính.'))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Chip(label: Text('Đúng: $right'), backgroundColor: Colors.green),
                          Text('Câu ${q + 1}/$total'),
                          Chip(label: Text('Sai: $wrong'), backgroundColor: Colors.orange),
                        ],
                      ),
                      const Spacer(),
                      Text(cur!.word,
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      Chip(label: Text(shown, style: const TextStyle(fontSize: 18))),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => answer(true),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green, foregroundColor: Colors.white),
                            icon: const Icon(Icons.check),
                            label: const Text('Đúng'),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => answer(false),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red, foregroundColor: Colors.white),
                            icon: const Icon(Icons.close),
                            label: const Text('Sai'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
    );
  }
}
