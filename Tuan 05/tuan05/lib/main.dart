import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class SanPham {
  final String ten;
  final String moTa;
  final int gia;
  final String hinhAnh;

  const SanPham({
    required this.ten,
    required this.moTa,
    required this.gia,
    required this.hinhAnh,
  });
}

final List<SanPham> danhSachSanPham = [
  const SanPham(
    ten: 'Điện thoại 01',
    moTa: 'Điện thoại màn hình cảm ứng',
    gia: 7000000,
    hinhAnh: 'assets/phone1.jpg',
  ),
  const SanPham(
    ten: 'Điện thoại 02',
    moTa: 'Điện thoại thông minh',
    gia: 8000000,
    hinhAnh: 'assets/phone2.jpg',
  ),
  const SanPham(
    ten: 'Điện thoại 03',
    moTa: 'Điện thoại cấu hình cao',
    gia: 9000000,
    hinhAnh: 'assets/phone3.jpg',
  ),
  const SanPham(
    ten: 'Điện thoại 04',
    moTa: 'Điện thoại thế hệ mới',
    gia: 10000000,
    hinhAnh: 'assets/phone4.jpg',
  ),
];

final List<SanPham> gioHang = [];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cửa hàng điện thoại',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const TrangGioiThieu(),
    );
  }
}

class TrangGioiThieu extends StatelessWidget {
  const TrangGioiThieu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logodhct.png',
              width: 150,
              height: 180,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              'Cửa hàng điện thoại',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text('140 Lê Trong Tấn, Tân Phú, TP.HCM'),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TrangSanPham(),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Nhấn để vào cửa hàng'),
            ),
          ],
        ),
      ),
    );
  }
}

class TrangSanPham extends StatefulWidget {
  const TrangSanPham({super.key});

  @override
  State<TrangSanPham> createState() => _TrangSanPhamState();
}

class _TrangSanPhamState extends State<TrangSanPham> {
  Future<void> themVaoGioHang(SanPham sanPham) async {
    final bool? dongY = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xác nhận'),
          content: Text('Bạn có muốn mua ${sanPham.ten} không?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Không'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Đồng ý'),
            ),
          ],
        );
      },
    );

    if (dongY == true) {
      setState(() {
        gioHang.add(sanPham);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đã thêm ${sanPham.ten} vào giỏ hàng'),
          ),
        );
      }
    }
  }

  Future<void> moGioHang() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const TrangGioHang(),
      ),
    );

    if (mounted) {
      setState(() {});
    }
  }

  String dinhDangGia(int gia) {
    return '${gia.toString()} VNĐ';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Cửa hàng điện thoại'),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: moGioHang,
                icon: const Icon(Icons.shopping_cart),
              ),
              if (gioHang.isNotEmpty)
                Positioned(
                  right: 4,
                  top: 4,
                  child: CircleAvatar(
                    radius: 9,
                    child: Text(
                      '${gioHang.length}',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.amber),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/hi.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                const SizedBox(height: 8),
                const Text(
                  'Cửa hàng điện thoại',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Cửa hàng'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Giỏ hàng'),
              onTap: () {
                Navigator.pop(context);
                moGioHang();
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Thoát'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TrangGioiThieu(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final int soCot = constraints.maxWidth >= 700 ? 4 : 2;

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: danhSachSanPham.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: soCot,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: 330,
            ),
            itemBuilder: (context, index) {
              final sanPham = danhSachSanPham[index];

              return Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          sanPham.hinhAnh,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        sanPham.ten,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        sanPham.moTa,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        dinhDangGia(sanPham.gia),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: () => themVaoGioHang(sanPham),
                        icon: const Icon(Icons.add_shopping_cart),
                        label: const Text('Mua'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class TrangGioHang extends StatefulWidget {
  const TrangGioHang({super.key});

  @override
  State<TrangGioHang> createState() => _TrangGioHangState();
}

class _TrangGioHangState extends State<TrangGioHang> {
  int get tongTien {
    int tong = 0;
    for (final sanPham in gioHang) {
      tong += sanPham.gia;
    }
    return tong;
  }

  Future<void> xoaSanPham(int index) async {
    final sanPham = gioHang[index];

    final bool? dongY = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xác nhận'),
          content: Text(
            'Bạn có muốn xóa ${sanPham.ten} khỏi giỏ hàng không?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Không'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Đồng ý'),
            ),
          ],
        );
      },
    );

    if (dongY == true) {
      setState(() {
        gioHang.removeAt(index);
      });
    }
  }

  Future<void> thanhToan() async {
    if (gioHang.isEmpty) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Thông báo'),
            content: const Text(
              'Bạn chưa có sản phẩm nào trong giỏ hàng.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Đóng'),
              ),
            ],
          );
        },
      );
      return;
    }

    final bool? dongY = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xác nhận thanh toán'),
          content: Text(
            'Tổng tiền: $tongTien VNĐ\nBạn có muốn thanh toán không?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Không'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Thanh toán'),
            ),
          ],
        );
      },
    );

    if (dongY == true) {
      setState(() {
        gioHang.clear();
      });

      if (mounted) {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Thanh toán'),
              content: const Text(
                'Bạn đã thanh toán thành công!',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Đóng'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Giỏ hàng của bạn'),
      ),
      body: Column(
        children: [
          Expanded(
            child: gioHang.isEmpty
                ? const Center(
              child: Text(
                'Bạn chưa có sản phẩm nào trong giỏ hàng.',
                style: TextStyle(fontSize: 17),
              ),
            )
                : ListView.builder(
              itemCount: gioHang.length,
              itemBuilder: (context, index) {
                final sanPham = gioHang[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: ListTile(
                    leading: Image.asset(
                      sanPham.hinhAnh,
                      width: 55,
                      height: 70,
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                      sanPham.ten,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text('${sanPham.gia} VNĐ'),
                    trailing: IconButton(
                      onPressed: () => xoaSanPham(index),
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (gioHang.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Tổng tiền: $tongTien VNĐ',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: thanhToan,
                child: const Padding(
                  padding: EdgeInsets.all(14),
                  child: Text(
                    'Thanh toán',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
