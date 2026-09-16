import 'package:flutter/material.dart';

void main() {
  runApp(const MoodApp());
}

class MoodApp extends StatelessWidget {
  const MoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Tracker Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
      ),
      home: const MoodScreen(),
    );
  }
}

class ExerciseItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  ExerciseItem(this.title, this.subtitle, this.icon, this.color);
}

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  int _selectedMood = -1;
  int _navIndex = 0;

  // Sửa lại các emoji chuẩn để hiển thị không bị lỗi font
  final List<Map<String, dynamic>> _moods = [
    {'emoji': '😩', 'label': 'Bad'},
    {'emoji': '🙂', 'label': 'Fine'},
    {'emoji': '😊', 'label': 'Well'},
    {'emoji': '🤩', 'label': 'Excellent'},
  ];

  final List<ExerciseItem> _exercises = [
    ExerciseItem('Speaking Skillz', '16 Exercises', Icons.favorite, Colors.orange),
    ExerciseItem('Reading Skills', '8 Exercises', Icons.person, Colors.green),
    ExerciseItem('Writing Skills', '20 Exercises', Icons.star, Colors.pink),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Header: Hi, Jared! + notification
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hi, Jared!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Text('23 Jan, 2021', style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.notifications, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Search bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(12)),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Search', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // How do you feel?
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('How do you feel?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Icon(Icons.more_horiz),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_moods.length, (index) {
                final selected = _selectedMood == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedMood = index),
                  child: Column(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                       
                          color: selected ? Colors.blue.withValues(alpha: 0.2) : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(16),
                          border: selected ? Border.all(color: Colors.blue, width: 2) : null,
                        ),
                        child: Text(_moods[index]['emoji'], style: const TextStyle(fontSize: 26)),
                      ),
                      const SizedBox(height: 6),
                      Text(_moods[index]['label']),
                    ],
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            // Exercises
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Exercises', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Icon(Icons.more_horiz),
              ],
            ),
            const SizedBox(height: 12),
            ..._exercises.map((e) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: e.color, borderRadius: BorderRadius.circular(10)),
                        child: Icon(e.icon, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text(e.subtitle, style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      const Icon(Icons.more_horiz),
                    ],
                  ),
                )),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }
}