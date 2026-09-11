import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bài tập 03 - Sản phẩm',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const SanPhamScreen(),
    );
  }
}

class SanPhamScreen extends StatelessWidget {
  const SanPhamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin sản phẩm'),
        backgroundColor: Colors.orange[900],
        leading: const Icon(Icons.shopping_bag),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // sp
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _anhSanPham('https://picsum.photos/seed/sp1/120'),
                  _anhSanPham('https://picsum.photos/seed/sp2/120'),
                  _anhSanPham('https://picsum.photos/seed/sp3/120'),
                ],
              ),
              const SizedBox(height: 16),

              // tt sp
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('Mã sản phẩm: SP00125',
                    style: TextStyle(color: Colors.grey, fontSize: 15)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('Tên sản phẩm: Tai nghe không dây Bluetooth X200',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('Nhà sản xuất: Công ty TNHH Âm Thanh Việt',
                    style: TextStyle(fontSize: 16)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('Giá bán: 590.000 đ',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 6),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('Mô tả sản phẩm:',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                    'Tai nghe Bluetooth 5.0, chống ồn chủ động, thời lượng pin '
                    '20 giờ, chống nước IPX5, phù hợp nghe nhạc và gọi điện.',
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

  Widget _anhSanPham(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        url,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.image_not_supported, size: 100),
      ),
    );
  }
}
