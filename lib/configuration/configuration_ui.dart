import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mysecretary/business/business_ui.dart';
import 'package:mysecretary/class/class_ui.dart';
import 'package:mysecretary/configuration/configuration_logic.dart';
import 'package:mysecretary/configuration/configuration_success.dart';
import 'package:mysecretary/homescreen/homescreen_logic.dart';
import 'package:mysecretary/newtask/newtask_logic.dart';
import 'package:mysecretary/newtask/newtask_ui.dart';
import 'package:mysecretary/personal/personal_ui.dart';
import 'package:mysecretary/profile.dart';
import 'package:mysecretary/tasksdetails/tasksdetails_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen>
    with TickerProviderStateMixin {
  // variable to store the main color
  Color mainColor = const Color.fromARGB(255, 41, 143, 174);
  // variable to store the color for uncompleted task
  Color uncompletedTaskColor = Colors.transparent;
  // variable to store the color for completed tasks
  Color completedTaskColor = const Color.fromARGB(255, 41, 143, 174);

  // variable to store the configure button color
  Color bodyColor = const Color.fromARGB(255, 41, 143, 174);
  Color borderColor = Colors.grey.shade300;
  Color textColor = Colors.white;

  // varaibles to store the main screen gradient colors
  Color color1 = Colors.purple;
  Color color2 = Colors.orange;

  // variables to store the username and user password
  String userName = "";
  String userPassword = "";

  // variable to store the date for today
  String todayDate = "";

  // a list to define the dates of the month
  List date = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13"
  ];

  // variables to hold different types of tasks
  HashMap<int, List<String>> tasksForDateTappedHashMap = HashMap();
  HashMap<int, List<String>> tasksHashMap = HashMap();
  HashMap<int, List<String>> todaysTasksHashMap = HashMap();

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

  /// function to record the username and password
  /// username and password come from the textfields
  /// they are passed to this method in order to be recorded to the local database using shared preferences
  void recorduserDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("Username", userName);
    sharedPreferences.setString("Userpassword", userPassword);
    displayToast("Details Saved");
  }

  /// function to update the configuration state to true when the user clicks the configure button
  /// this isConfigured variable is then read at after the splash screen to determine whether the configuratio has been done or not
  void recordConfigurationStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isConfigured", true);
  }

  /// function to read the configuration state and assign it to the "hasConfigurationBeenDone" variable
  void readConfigurationStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    displayToast(sharedPreferences.getBool("isConfigured").toString());
  }

  /// function to show the details stored in the database created by shared preference
  /// this is a debugging function and has no effect on the functioning of the system
  /// SHOULD BE DELETED BEFORE LAUNCH
  void readUserDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    displayToast(sharedPreferences.getString("Username").toString());
    displayToast(sharedPreferences.getString("Userpassword").toString());
  }

  // function to display the configure button
  Widget configuringWindow(TabController tabController) {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(
                      MediaQuery.of(context).size.width * 3, 300)),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.purple, Colors.orange]),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Container(
                  height: MediaQuery.of(context).size.height * 0.17,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(Icons.photo_camera, size: 65, color: Colors.white),
                      Text(
                        "Choose Photo",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
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
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      prefixIcon: Opacity(
                        opacity: 0.5,
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      hintText: "Username",
                      hintStyle: TextStyle(
                          color: Colors.black,
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
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      prefixIcon: Opacity(
                        opacity: 0.5,
                        child: Icon(
                          Icons.password,
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontSize: 13,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Container(
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: GestureDetector(
                onTap: (() {
                  /// record the user details
                  recorduserDetails();

                  /// record the configuration status
                  recordConfigurationStatus();

                  /// read user details
                  readUserDetails();

                  /// read configuration status
                  readConfigurationStatus();

                  /// predefine the key value for the tasks (Hive)
                  NewTaskLogic().predefineKeyValue();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ConfigurationSuccess()));
                }),
                child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [
                              color1,
                              color2,
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight)),
                    child: const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Text('CONFIGURE',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500))))),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    Hive.openBox("TasksDatabase");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
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
          child: Center(child: configuringWindow(tabController)),
        ),
      ),
    ));
  }
}
