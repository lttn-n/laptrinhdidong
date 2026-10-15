import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _plugin.initialize(const InitializationSettings(android: android));
    _initialized = true;
    final status = await Permission.notification.status;
    if (status.isDenied) await Permission.notification.request();
    // Android 12+: app may need exact alarm permission as well.
    final impl = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await impl?.requestExactAlarmsPermission();
  }

  static AndroidNotificationDetails _details(String id, String name, [String? description]) =>
      AndroidNotificationDetails(id, name, channelDescription: description,
        importance: Importance.max, priority: Priority.high,
        visibility: NotificationVisibility.public, playSound: true,
        enableVibration: true, showWhen: true);

  int nextId() => DateTime.now().microsecondsSinceEpoch.remainder(2147483647);
  Future<void> showSimpleNotification({int id = 0, String title = 'Nhắc học từ vựng', String body = 'Bạn đã học 5 từ mới hôm nay chưa?'}) async {
    await _plugin.show(id, title, body, NotificationDetails(android: _details('learn_english_channel', 'Học Anh Văn')));
  }
  Future<void> scheduleNotificationAfter(Duration delay, String channelId, String channelName, String channelDescription) async {
    await _plugin.zonedSchedule(nextId(), channelName, channelDescription,
      tz.TZDateTime.now(tz.local).add(delay),
      NotificationDetails(android: _details(channelId, channelName, channelDescription)),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }
  Future<void> scheduleNotificationAt({required int id, required String title, required String body, required DateTime scheduledTime}) async {
    await _plugin.zonedSchedule(id, title, body, tz.TZDateTime.from(scheduledTime, tz.local),
      NotificationDetails(android: _details('todo_channel', 'Nhắc công việc')),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }
  Future<List<PendingNotificationRequest>> getPendingNotifications() => _plugin.pendingNotificationRequests();
  Future<void> cancelNotification(int id) => _plugin.cancel(id);
}
