import 'package:flutter/material.dart';
import '../services/notification_service.dart';

/// BÀI TẬP 1
class ScreenNotiEx extends StatelessWidget {
  const ScreenNotiEx({super.key});

  Future<void> _schedule(
      BuildContext context, {
        required Duration delay,
        required int id,
        required String title,
        required String body,
        required String channelId,
        required String channelName,
        required String label,
      }) async {
    final ok = await NotificationService.instance.scheduleAfter(
      delay,
      id: id,
      title: title,
      body: body,
      channelId: channelId,
      channelName: channelName,
    );
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(ok
            ? 'Đã đặt lịch: $label'
            : 'Không đặt được lịch (xem Debug Console)'),
        backgroundColor: ok ? null : Colors.red,
      ));
  }

  @override
  Widget build(BuildContext context) {
    final noti = NotificationService.instance;
    return Scaffold(
      appBar: AppBar(title: const Text('Screen Noti Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => noti.show(),
              child: const Text('Gửi thông báo nhắc học Ngoại ngữ'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _schedule(
                context,
                // đổi thành Duration(seconds: 15) để test nhanh
                delay: const Duration(minutes: 2),
                id: 1,
                title: 'Uống nước',
                body: 'Nhắc uống nước đúng giờ',
                channelId: 'drink_water_channel',
                channelName: 'Uống nước',
                label: 'nhắc uống nước sau 2 phút',
              ),
              child: const Text('Gửi thông báo nhắc uống nước sau 2 phút'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _schedule(
                context,
                delay: const Duration(minutes: 10),
                id: 2,
                title: 'Học Ngoại ngữ',
                body: 'Đã đến giờ học Ngoại ngữ rồi!',
                channelId: 'learn_english_channel',
                channelName: 'Học Anh Văn',
                label: 'nhắc học Ngoại ngữ sau 10 phút',
              ),
              child: const Text('Hẹn giờ gửi thông báo học Ngoại ngữ sau 10 phút'),
            ),
          ],
        ),
      ),
    );
  }
}