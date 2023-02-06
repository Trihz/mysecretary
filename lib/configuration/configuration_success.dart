import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mysecretary/homescreen/homescreen_ui.dart';

class ConfigurationSuccess extends StatefulWidget {
  const ConfigurationSuccess({super.key});

  @override
  State<ConfigurationSuccess> createState() => _ConfigurationSuccessState();
}

class _ConfigurationSuccessState extends State<ConfigurationSuccess> {
  // function to display the configure success screen
  Widget successWindow() {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: CircleAvatar(
              radius: 37,
              backgroundColor: Colors.white,
              child: Image.asset("assets/checked.png"),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: const Center(
                child: Text(
              "Successful Configuration",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.orange),
            )),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(milliseconds: 1000),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: successWindow(),
    );
  }
}
