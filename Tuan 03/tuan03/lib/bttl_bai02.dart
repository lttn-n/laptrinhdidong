import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bài tập 02 - Đề tài đồ án',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const DeTaiScreen(),
    );
  }
}

class DeTaiScreen extends StatelessWidget {
  const DeTaiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin đề tài đồ án'),
        backgroundColor: Colors.teal[900],
        leading: const Icon(Icons.school),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('Mã đề tài: DT2026-CNTT-015',
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text(
                    'Tên đề tài: Xây dựng ứng dụng quản lý học tập trên nền tảng Flutter',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('Số lượng sinh viên tối đa: 2 sinh viên',
                    style: TextStyle(color: Colors.red, fontSize: 16)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('Chuyên ngành: Công nghệ phần mềm',
                    style: TextStyle(color: Colors.red, fontSize: 16)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('Giảng viên hướng dẫn: ThS. Vũ Văn Vinh',
                    style: TextStyle(color: Colors.blue, fontSize: 16)),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('Yêu cầu đề tài:',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                    '- Sinh viên nắm vững kiến thức lập trình Flutter/Dart.\n'
                    '- Có khả năng thiết kế cơ sở dữ liệu và xây dựng API.\n'
                    '- Hoàn thành sản phẩm chạy được trên Android và iOS.',
                    style: TextStyle(fontSize: 15)),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Trở về'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
