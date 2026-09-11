import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bài tập 01 - Thông tin sinh viên',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ThongTinScreen(),
    );
  }
}

//Main srceen
class ThongTinScreen extends StatelessWidget {
  const ThongTinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin sinh viên - giảng viên'),
        backgroundColor: Colors.blue[900],
        leading: const Icon(Icons.home),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  THÔNG TIN SINH VIÊN
              const Center(
                child: Text(
                  'THÔNG TIN SINH VIÊN',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: ClipOval(
                  child: Image.network(
                    'https://picsum.photos/seed/sinhvien/150',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,

                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.person, size: 150),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text('Họ và tên: Nguyễn Văn A',
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text('MSSV: 2001221234',
                    style: TextStyle(color: Colors.red, fontSize: 16)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text('Lớp: 13DHTH02',
                    style: TextStyle(color: Colors.red, fontSize: 16)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text('Khóa: 13 Đại học',
                    style: TextStyle(color: Colors.red, fontSize: 16)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text('Ngành: Công nghệ thông tin',
                    style: TextStyle(color: Colors.red, fontSize: 16)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                    'Trường: Đại học Công Thương Thành phố Hồ Chí Minh',
                    style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 12),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Trở về'),
                ),
              ),

              const SizedBox(height: 24),
              const Divider(thickness: 2),

              //THÔNG TIN GIẢNG VIÊN
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'THÔNG TIN GIẢNG VIÊN',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: ClipOval(
                  child: Image.network(
                    'https://picsum.photos/seed/giangvien/150',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.person, size: 150),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text('Giảng viên: Trần Thị A',
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text('Khoa: Công nghệ Thông tin',
                    style: TextStyle(color: Colors.red, fontSize: 16)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text('Học hàm: Thạc sỹ',
                    style: TextStyle(color: Colors.red, fontSize: 16)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text('Chuyên ngành: Công nghệ phần mềm',
                    style: TextStyle(color: Colors.green, fontSize: 16)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                    'Giảng dạy: Nhập môn lập trình, Lập trình Windows, Lập trình web...',
                    style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 12),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Trở về'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
