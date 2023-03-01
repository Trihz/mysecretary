import 'package:flutter/material.dart';
import 'package:mysecretary/SplashScreen/splashscreen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mysecretary/password/password_ui.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("TasksDatabase");
  await Hive.openBox("DeletedTasksDatabase");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: OpeningScreen());
  }
}
