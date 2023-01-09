import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mysecretary/homescreen/homescreen_ui.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  // variable to store the main color
  Color mainColor = const Color.fromARGB(255, 41, 143, 174);

  // variable to store the configure button color
  Color bodyColor = const Color.fromARGB(255, 41, 143, 174);
  Color borderColor = Colors.grey.shade300;
  Color textColor = Colors.white;

  // variable to hold the sate of the theme
  bool themeStatus = false;

  // variable to store status of the button
  bool isConfiguredbuttonState = true;
  bool isConfigured = true;

  // function to display a toast message
  void displayToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  //function to display the configure screen
  Widget configureScreen() {
    return isConfigured ? configureButton() : const HomeScreen();
  }

  // function to display the configure button
  Widget configureButton() {
    return GestureDetector(
      onLongPress: (() {
        displayToast("App Configured Successfully");
        setState(() {
          isConfiguredbuttonState = false;
        });
      }),
      child: CircleAvatar(
        radius: 37,
        backgroundColor: borderColor,
        child: CircleAvatar(
          radius: 33,
          backgroundColor: bodyColor,
          child: Text(
            "CONFIGURE",
            style: TextStyle(
                fontWeight: FontWeight.w500, color: textColor, fontSize: 10),
          ),
        ),
      ),
    );
  }

  // function to display the configure success screen
  Widget configureSuccessScreen() {
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
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 1,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Center(
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade300,
                        onPrimary: Colors.black,
                        shadowColor: Colors.grey,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    child: const Text(
                      "CONTINUE",
                      style: TextStyle(),
                    )),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(color: Colors.white),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 1,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Center(
            child: isConfiguredbuttonState
                ? configureScreen()
                : configureSuccessScreen()),
      ),
    ));
  }
}
