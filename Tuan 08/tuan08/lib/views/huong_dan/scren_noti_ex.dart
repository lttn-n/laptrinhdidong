import 'package:flutter/material.dart';
import '../../services/notification_service.dart';
class ScreenNotiEx extends StatelessWidget {
  const ScreenNotiEx({super.key});
  @override
  Widget build(BuildContext context) {
    final service = NotificationService();
    return Scaffold(appBar: AppBar(title: const Text('Screen Noti Example')),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton(onPressed: () => service.showSimpleNotification(), child: const Text('Gửi thông báo nhắc học Ngoại ngữ')),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () => service.scheduleNotificationAfter(const Duration(minutes: 2), 'drink_water_channel', 'Uống nước', 'Nhắc uống nước đúng giờ'), child: const Text('Gửi thông báo nhắc uống nước sau 2 phút')),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () => service.scheduleNotificationAfter(const Duration(minutes: 10), 'english_channel', 'Học Ngoại ngữ', 'Đến giờ học Ngoại ngữ'), child: const Text('Hẹn giờ gửi thông báo học Ngoại ngữ sau 10 phút')),
      ])));
  }
}
