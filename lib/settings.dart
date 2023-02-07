import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // variable to store the main color
  Color mainColor = const Color.fromARGB(255, 41, 143, 174);

  // varibles to store the user details
  String userNameTextField = "";

  // function to display the toast
  void displayToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // function to save details to the local storage
  void saveDetails(String userNameToStorage) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("Username", userNameToStorage);
    displayToast("Details Saved");
  }

  // function to get data from the loacl storage
  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userNameTextField = sharedPreferences.getString("Username").toString();
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
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
            colors: [Colors.purple, Colors.orange]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Icon(
                        Icons.add_a_photo,
                        color: mainColor,
                        size: 40,
                      ),
                    )),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Center(
                    child: Text(
                      userNameTextField,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        userNameTextField = value;
                      });
                    },
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      prefixIcon: Opacity(
                        opacity: 0.5,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      hintText: "Username",
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 13,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: const TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      prefixIcon: Opacity(
                        opacity: 0.5,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      hintText: "Username",
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 13,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: ElevatedButton(
                      onPressed: () {
                        saveDetails(userNameTextField);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: mainColor,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)))),
                      child: const Text("SAVE")),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
