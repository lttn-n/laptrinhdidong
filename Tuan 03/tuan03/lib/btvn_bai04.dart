import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bài tập 04 - Thông tin nhóm',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const NhomScreen(),
    );
  }
}

class NhomScreen extends StatelessWidget {
  const NhomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin nhóm'),
        backgroundColor: Colors.indigo[900],
        leading: const Icon(Icons.groups),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //tt nhóm
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('Mã nhóm: N05',
                    style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('Tên nhóm: FlutterMasters',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('Số lượng thành viên: 3',
                    style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 12),
              const Divider(thickness: 2),
              const SizedBox(height: 12),
              const Text('DANH SÁCH THÀNH VIÊN',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              //TV1
              _theThanhVien(
                maSV: 'SV001',
                tenSV: 'Nguyễn Văn A',
                vaiTro: 'Nhóm trưởng',
                mauVaiTro: Colors.red,
              ),
              const SizedBox(height: 10),

              //tv2
              _theThanhVien(
                maSV: 'SV002',
                tenSV: 'Trần Thị B',
                vaiTro: 'Thành viên',
                mauVaiTro: Colors.blue,
              ),
              const SizedBox(height: 10),

              // tv3
              _theThanhVien(
                maSV: 'SV003',
                tenSV: 'Lê Văn C',
                vaiTro: 'Thành viên',
                mauVaiTro: Colors.blue,
              ),

              const SizedBox(height: 24),
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

  Widget _theThanhVien({
    required String maSV,
    required String tenSV,
    required String vaiTro,
    required Color mauVaiTro,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.indigo[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.indigo[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mã sinh viên: $maSV', style: const TextStyle(fontSize: 15)),
          Text('Tên sinh viên: $tenSV',
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold)),
          Text('Vai trò: $vaiTro',
              style: TextStyle(
                  color: mauVaiTro,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
