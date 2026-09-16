import 'package:flutter/material.dart';

void main() {
  runApp(const EWalletApp());
}

class EWalletApp extends StatelessWidget {
  const EWalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Wallet Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: Colors.white),
      home: const WalletScreen(),
    );
  }
}

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  // Hàm hiển thị thông báo khi bấm nút để kiểm tra thao tác
  void _showActionMessage(BuildContext context, String actionName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã bấm vào chức năng: $actionName'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Widget _quickAction(BuildContext context, IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () => _showActionMessage(context, label), 
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
          const SizedBox(height: 6),
          Text(label),
        ],
      ),
    );
  }

  Widget _menuTile(BuildContext context, IconData icon, Color color, String title, String subtitle) {
    return InkWell(
      onTap: () => _showActionMessage(context, title), // Thêm sự kiện bấm vào hàng menu
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: const Color(0xFFF5F5FA), borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(subtitle, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: () => _showActionMessage(context, 'Thêm giao dịch mới'),
        child: const Icon(Icons.attach_money),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text.rich(
                  TextSpan(children: [
                    TextSpan(text: 'My ', style: TextStyle(fontSize: 24, color: Colors.grey)),
                    TextSpan(text: 'Cards', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ]),
                ),
                InkWell(
                  onTap: () => _showActionMessage(context, 'Thêm thẻ mới'),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade200),
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Thẻ số dư
            Container(
              padding: const EdgeInsets.all(20),
              height: 170,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8E6CEF), Color(0xFF6C4CE0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Balance', style: TextStyle(color: Colors.white70)),
                  Text('\$5250.25', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('12345678', style: TextStyle(color: Colors.white70)),
                      Text('10/24', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Dot indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 20, height: 6, margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.circular(4))),
                Container(width: 6, height: 6, margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle)),
                Container(width: 6, height: 6, margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle)),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _quickAction(context, Icons.send, 'Send', Colors.green),
                _quickAction(context, Icons.credit_card, 'Pay', Colors.blue),
                _quickAction(context, Icons.receipt_long, 'Bills', Colors.orange),
              ],
            ),
            const SizedBox(height: 24),
            _menuTile(context, Icons.bar_chart, Colors.teal, 'Statistics', 'Payment and Income'),
            _menuTile(context, Icons.swap_horiz, Colors.indigo, 'Transactions', 'Transaction History'),
          ],
        ),
      ),
    );
  }
}