import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  // FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin _localNotification =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: androidInitializationSettings,
          iOS: darwinInitializationSettings,
        );
    await _localNotification.initialize(settings: initializationSettings);

    await _requestPermission();
  }

  // Request permission
  Future<void> _requestPermission() async {
    final androidPlugin = _localNotification
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await androidPlugin?.requestNotificationsPermission();
    await androidPlugin?.requestExactAlarmsPermission();
  }

 Future<void> _scheduleDaily({
    required int id,
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    final now = tz.TZDateTime.now(tz.local);

    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'meal_reminders',
        'Meal Reminders',
        channelDescription: 'Notifications for meal reminders',
        importance: Importance.high,
        priority: Priority.high,
      ),
    );

    await _localNotification.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails: notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> scheduleBreakfast() async {
    await _scheduleDaily(
      id: 1,
      hour: 8,
      minute: 0,
      title: 'Breakfast Time 🍳',
      body: 'Start your day with a healthy breakfast',
    );
  }

  Future<void> scheduleLunch() async {
    await _scheduleDaily(
      id: 2,
      hour: 13,
      minute: 0,
      title: 'Lunch Time 🥗',
      body: 'Time for a balanced lunch',
    );
  }

  Future<void> scheduleDinner() async {
    await _scheduleDaily(
      id: 3,
      hour: 19,
      minute: 0,
      title: 'Dinner Time 🍽️',
      body: 'Enjoy your dinner',
    );
  }

  Future<void> scheduleMealReminders() async {
    // Clear existing reminders
    await _localNotification.cancelAll();

    await scheduleBreakfast();
    await scheduleLunch();
    await scheduleDinner();
  }

  Future<void> cancelAll() async {
    await _localNotification.cancelAll();
  }
}
