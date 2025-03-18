import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/auth/main_page.dart';
import 'package:project/firebase_options.dart';
import 'package:project/screen/home.dart';
import 'package:project/screen/login.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'helper/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await NotificationService.initialize();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name:'task-manager',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // runApp(MaterialApp(
  //   initialRoute: '/',
  //   routes: {
  //     '/': (context) => LogIN_Screen(() {}),
  //     '/home': (context) => Home_Screen(),
  //   },
  // ));
  
  runApp(MyApp());
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