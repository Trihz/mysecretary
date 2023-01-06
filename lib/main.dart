import 'package:flutter/material.dart';
import 'package:mysecretary/homescreen/homescreen_ui.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("TasksDatabase");
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
        debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "My Secretary",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 40,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Container(
            height: 200,
            width: 200,
          ),
        ],
      ),
      duration: 500,
      nextScreen: const HomeScreen(),
      splashIconSize: 250,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(seconds: 1),
      backgroundColor: const Color.fromARGB(255, 41, 143, 174),
    );
  }
}
