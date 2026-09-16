import 'package:flutter/material.dart';

import 'bttl_bai01.dart'; 
import 'bttl_bai03.dart'; 
import 'btvn_bai04.dart'; 
import 'btvn_bai05.dart'; 
import 'btvn_bai06.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Danh Sách Bài Tập Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainMenuScreen(),
    );
  }
}

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> exercises = [
      {
        'title': 'Bài 01: Ứng dụng Máy Tính (Calculator)',
        'subtitle': 'Bài tập tại lớp 01 - Giao diện Calculator & Drawer[cite: 7]',
        'icon': Icons.calculate,
        'color': Colors.blue,
        'page': const CalculatorApp(),
      },
      {
        'title': 'Bài 03: Mood Tracker (Theo dõi tâm trạng)',
        'subtitle': 'Bài tập tại lớp 03 - Giao diện "How do you feel?"[cite: 3, 7]',
        'icon': Icons.mood,
        'color': Colors.orange,
        'page': const MoodApp(), 
      },
      {
        'title': 'Bài 04: Ví điện tử (E-Wallet)',
        'subtitle': 'Bài tập về nhà 04 - Quản lý thẻ và giao dịch[cite: 4, 7]',
        'icon': Icons.account_balance_wallet,
        'color': Colors.purple,
        'page': const EWalletApp(), 
      },
      {
        'title': 'Bài 05: Đặt lịch khám bệnh online',
        'subtitle': 'Bài tập về nhà 05 - Danh sách bác sĩ & y tế[cite: 5, 7]',
        'icon': Icons.medical_services,
        'color': Colors.pink,
        'page': const MedicalApp(), 
      },
      {
        'title': 'Bài 06: Trình phát nhạc (Music Player)',
        'subtitle': 'Bài tập về nhà 06 - Giao diện phát nhạc & Stack[cite: 6, 7]',
        'icon': Icons.music_note,
        'color': Colors.green,
        'page': const MusicPlayerApp(), 
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Bài Tập Lập Trình Di Động'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final item = exercises[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: item['color'],
                child: Icon(item['icon'], color: Colors.white),
              ),
              title: Text(
                item['title'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item['subtitle']),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => item['page']),
                );
              },
            ),
          );
        },
      ),
    );
  }
}