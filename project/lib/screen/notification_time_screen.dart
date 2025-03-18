import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;
import '../model/notes_model.dart';

class NotificationTimeScreen extends StatefulWidget {
  final Note note;
  NotificationTimeScreen({required this.note});

  @override
  _NotificationTimeScreenState createState() => _NotificationTimeScreenState();
}

class _NotificationTimeScreenState extends State<NotificationTimeScreen> {
  TimeOfDay? selectedTime;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    tzData.initializeTimeZones();
    var androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initSettings = InitializationSettings(android: androidInit);
    flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  Future<void> scheduleNotification(TimeOfDay time) async {
    final now = DateTime.now();
    final scheduledDate = DateTime(now.year, now.month, now.day, time.hour, time.minute);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      widget.note.id.hashCode,
      'Reminder',
      widget.note.title,
      tz.TZDateTime.from(scheduledDate, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, // Thêm tham số này
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Set Notification")),
      body: Column(
        children: [
          SizedBox(height: 30),
          Text(
            "Choose notification time for: ${widget.note.title}",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (time != null) {
                setState(() {
                  selectedTime = time;
                });
              }
            },
            child: Text("Select Time"),
          ),
          if (selectedTime != null)
            Text("Selected Time: ${selectedTime!.format(context)}"),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (selectedTime != null) {
                scheduleNotification(selectedTime!);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Notification Scheduled!")));
              }
            },
            child: Text("Save Notification"),
          ),
        ],
      ),
    );
  }
}