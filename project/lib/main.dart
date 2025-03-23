import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/auth/main_page.dart';
import 'package:project/firebase_options.dart';
import 'package:project/screen/home.dart';
import 'package:project/screen/login.dart';
import 'package:timezone/data/latest_all.dart' as tz;

import 'helper/notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Timezone cho notification
  tz.initializeTimeZones();

  // Khởi tạo Notification Plugin
  await NotificationService.initialize();

  // Xin quyền hiển thị Notification
  await NotificationService.flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.requestPermission();

  // Khởi tạo Firebase
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: 'task-manager',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(const MyApp());
}

extension on AndroidFlutterLocalNotificationsPlugin? {
  requestPermission() {}
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Main_Page(),
      routes: {
        '/login': (context) => LogIN_Screen(() {}),
        '/home': (context) => Home_Screen(),
      },
    );
  }
}