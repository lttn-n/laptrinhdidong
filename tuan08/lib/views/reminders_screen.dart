import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../services/notification_service.dart';

/// Menu "Lịch nhắc": các lịch đã đặt nhưng chưa hiện notification
class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});
  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  final noti = NotificationService.instance;
  late Future<List<PendingNotificationRequest>> future = noti.pending();

  void reload() => setState(() => future = noti.pending());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lịch nhắc')),
      body: FutureBuilder<List<PendingNotificationRequest>>(
        future: future,
        builder: (context, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final list = snap.data!;
          if (list.isEmpty) return const Center(child: Text('Chưa có lịch nhắc nào'));
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, i) {
              final r = list[i];
              return ListTile(
                leading: const Icon(Icons.alarm),
                title: Text(r.title ?? ''),
                subtitle: Text(r.body ?? ''),
                trailing: IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.red),
                  onPressed: () async {
                    await noti.cancel(r.id);
                    reload();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
