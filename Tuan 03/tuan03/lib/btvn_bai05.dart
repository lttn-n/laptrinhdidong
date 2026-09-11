import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bài tập 05 - Giới thiệu ngành học',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const GioiThieuNganhScreen(),
    );
  }
}

class GioiThieuNganhScreen extends StatelessWidget {
  const GioiThieuNganhScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ngành học - Khoa CNTT'),
        backgroundColor: Colors.deepPurple[900],
        leading: const Icon(Icons.menu_book),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'KHOA CÔNG NGHỆ THÔNG TIN\nTrường ĐH Công Thương TP.HCM',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              _khoiNganh(
                anhUrl: 'https://picsum.photos/seed/cntt/300/160',
                tenNganh: 'Ngành Công nghệ Thông tin (CNTT)',
                mauTen: Colors.deepPurple,
                moTa:
                    'Đào tạo kiến thức và kỹ năng về lập trình, phát triển '
                    'phần mềm, cơ sở dữ liệu, mạng máy tính và trí tuệ nhân '
                    'tạo. Sinh viên tốt nghiệp có thể làm lập trình viên, '
                    'kỹ sư phần mềm, quản trị hệ thống, phân tích dữ liệu...',
              ),
              const SizedBox(height: 24),
              const Divider(thickness: 2),
              const SizedBox(height: 24),

              _khoiNganh(
                anhUrl: 'https://picsum.photos/seed/attt/300/160',
                tenNganh: 'Ngành An toàn Thông tin (ATTT)',
                mauTen: Colors.red,
                moTa:
                    'Đào tạo chuyên sâu về bảo mật hệ thống, mạng máy tính, '
                    'phòng chống tấn công mạng, mã hóa dữ liệu và ứng cứu '
                    'sự cố an ninh mạng. Sinh viên tốt nghiệp có thể làm '
                    'chuyên viên bảo mật, kiểm thử xâm nhập (pentester)...',
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

  Widget _khoiNganh({
    required String anhUrl,
    required String tenNganh,
    required Color mauTen,
    required String moTa,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              anhUrl,
              width: 300,
              height: 160,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported, size: 100),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(tenNganh,
            style: TextStyle(
                color: mauTen, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text(moTa, style: const TextStyle(fontSize: 15)),
      ],
    );
  }
}
