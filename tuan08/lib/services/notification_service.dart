import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _inited = false;

  AndroidFlutterLocalNotificationsPlugin? get _androidImpl => _plugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

  Future<void> init() async {
    if (_inited) return;
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));

    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await _plugin.initialize(settings);
    await _requestPermission();
    _inited = true;
  }

  Future<void> _requestPermission() async {
    final status = await Permission.notification.status;
    if (status.isDenied) {
      await Permission.notification.request();
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
    // Android 12+: xin quyền báo thức chính xác (nếu chưa có)
    final canExact = await _androidImpl?.canScheduleExactNotifications() ?? true;
    if (!canExact) {
      await _androidImpl?.requestExactAlarmsPermission();
    }
  }

  AndroidNotificationDetails _android(String id, String name, [String? desc]) {
    return AndroidNotificationDetails(
      id,
      name,
      channelDescription: desc,
      importance: Importance.max,
      priority: Priority.high,
      visibility: NotificationVisibility.public,
      playSound: true,
      enableVibration: true,
      showWhen: true,
    );
  }

  /// Hiện thông báo ngay
  Future<void> show({
    int id = 0,
    String title = 'Nhắc học từ vựng',
    String body = 'Bạn đã học 5 từ mới hôm nay chưa?',
    String channelId = 'general_channel',
    String channelName = 'Thông báo chung',
  }) async {
    await _plugin.show(
      id,
      title,
      body,
      NotificationDetails(android: _android(channelId, channelName)),
    );
  }

  /// Lên lịch theo thời điểm cụ thể. Trả về false nếu thời điểm đã qua hoặc lỗi.
  /// daily = true: lặp lại mỗi ngày vào đúng giờ:phút đó.
  Future<bool> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime time,
    String channelId = 'reminder_channel',
    String channelName = 'Nhắc nhở',
    bool daily = false,
  }) async {
    var t = tz.TZDateTime.from(time, tz.local);
    final now = tz.TZDateTime.now(tz.local);
    if (!t.isAfter(now)) {
      if (!daily) return false;
      t = t.add(const Duration(days: 1));
    }

    final canExact = await _androidImpl?.canScheduleExactNotifications() ?? false;

    try {
      await _plugin.zonedSchedule(
        id,
        title,
        body,
        t,
        NotificationDetails(android: _android(channelId, channelName)),
        androidScheduleMode: canExact
            ? AndroidScheduleMode.exactAllowWhileIdle
            : AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: daily ? DateTimeComponents.time : null,
      );
      debugPrint('Scheduled #$id at $t (exact: $canExact)');
      return true;
    } catch (e) {
      debugPrint('Schedule error: $e');
      return false;
    }
  }

  /// Lên lịch sau 1 khoảng delay
  Future<bool> scheduleAfter(
      Duration delay, {
        int id = 1,
        required String title,
        required String body,
        String channelId = 'reminder_channel',
        String channelName = 'Nhắc nhở',
      }) {
    return schedule(
      id: id,
      title: title,
      body: body,
      time: DateTime.now().add(delay),
      channelId: channelId,
      channelName: channelName,
    );
  }

  Future<void> cancel(int id) => _plugin.cancel(id);
  Future<List<PendingNotificationRequest>> pending() =>
      _plugin.pendingNotificationRequests();
}