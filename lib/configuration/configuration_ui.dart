import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mysecretary/configuration/configuration_logic.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool isConfigurationDone = true;

  // variables to store the username and user password
  String userName = "";
  String userPassword = "";

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
    return Homescreen();
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
                      Icon(
                        Icons.photo_camera,
                        size: 65,
                        color: mainColor,
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
                      setState(() {
                        userName = value;
                      });
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
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        userPassword = value;
                      });
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      prefixIcon: Opacity(
                        opacity: 0.5,
                        child: Icon(
                          Icons.password,
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
                      hintText: "Password",
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
              onTap: (() {
                recorduserDetails();
                readUserDetails();
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

  // function to record the user name and password
  void recorduserDetails() async {
    // declare the instance of Shared Preference
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // record the values to the defined database as key-value pair
    sharedPreferences.setString("Username", userName);
    sharedPreferences.setString("Userpassword", userPassword);
    displayToast("Details Saved");
  }

  // function to show the details stored in the database created by shared preference
  void readUserDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    displayToast(sharedPreferences.getString("Username").toString());
    displayToast(sharedPreferences.getString("Userpassword").toString());
  }

  // function to display the homescreen
  Widget Homescreen() {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(color: Colors.red),
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
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: SingleChildScrollView(
          child: Center(
              child: isConfiguredbuttonState
                  ? configureScreen()
                  : configureSuccessScreen()),
        ),
      ),
    ));
  }
}
