import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mysecretary/configuration/configuration_ui.dart';
import 'package:mysecretary/homescreen/homescreen_ui.dart';
import 'package:mysecretary/password/password_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpeningScreen extends StatefulWidget {
  const OpeningScreen({super.key});

  @override
  State<OpeningScreen> createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {
  /// variable to store the password enable status
  bool passwordEnabledStatus = false;

  /// check the the user has enabled password
  void checkPasswordStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    passwordEnabledStatus = sharedPreferences.getBool("PasswordStatus")!;
    print(passwordEnabledStatus);
  }

  /// widget to display the animated welcoming text
  Widget welcomingText() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: const Icon(
                Icons.star_half,
                color: Colors.white,
                size: 60,
              ),
            ),
            DefaultTextStyle(
              style: const TextStyle(fontSize: 30, color: Colors.white),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText('My Secretary'),
                ],
                isRepeatingAnimation: true,
              ),
            ),
          ],
        ));
  }

  @override
  void initState() {
    checkPasswordStatus();
    super.initState();
    /*SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isConfigured", false);*/
    Timer(
        const Duration(milliseconds: 5700),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    passwordEnabledStatus ? const PasswordPage() : const HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple, Colors.orange])),
        child: Center(
          child: welcomingText(),
        ),
      ),
    );
  }
}
