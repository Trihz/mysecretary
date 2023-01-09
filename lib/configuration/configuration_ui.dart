import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mysecretary/configuration/configuration_logic.dart';
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
    return isConfigured ? configureScreenDisplay() : const HomeScreen();
  }

  // function to display the configure button
  Widget configureScreenDisplay() {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.17,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.camera_rounded,
                        size: 65,
                      ),
                      Text(
                        "Choose Photo",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: mainColor,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      prefixIcon: Opacity(
                        opacity: 0.5,
                        child: Icon(
                          Icons.person,
                          color: mainColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color: mainColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color: mainColor,
                        ),
                      ),
                      hintText: "Username",
                      hintStyle: TextStyle(
                          color: mainColor,
                          fontStyle: FontStyle.italic,
                          fontSize: 13,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.3),
          Container(
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: GestureDetector(
              onLongPress: (() {
                displayToast("App Configured Successfully");
                ConfigurationLogic()
                    .predefineKeyValue(); // predefine the key value to "0" during configuration
                ConfigurationLogic().readData();
                setState(() {
                  isConfiguredbuttonState =
                      false; // set the state to false meaning that configuration has been done
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
                        fontWeight: FontWeight.w500,
                        color: textColor,
                        fontSize: 10),
                  ),
                ),
              ),
            ),
          ),
        ],
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
                child: Text(
                  "Restart the App to save changes",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: mainColor,
                      fontSize: 17),
                ),
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
