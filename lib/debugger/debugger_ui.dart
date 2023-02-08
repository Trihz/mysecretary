import 'package:flutter/material.dart';
import 'package:mysecretary/debugger/debugger_logic.dart';

class DebuggerUI extends StatefulWidget {
  const DebuggerUI({super.key});

  @override
  State<DebuggerUI> createState() => _DebuggerUIState();
}

class _DebuggerUIState extends State<DebuggerUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Center(
            child: ElevatedButton(
                onPressed: () {
                  DebuggerLogic().readSettings();
                },
                child: const Text("Display"))),
      ),
    );
  }
}
