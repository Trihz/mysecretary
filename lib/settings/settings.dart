import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mysecretary/gradienticon.dart';
import 'package:mysecretary/settings/settings_logic.dart';
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

  /// variable to store the status of password
  bool passwordEnabled = false;

  /// variable to store the status of auto complete tasks
  bool autoDeleteEnabled = false;

  /// variable to store the status of notify due tasks
  bool notifyEnabled = false;

  /// these variable store the password settings
  String oldPasswordStored = "";
  String oldPasswordEntered = "";
  String newPassword = "";

  /// these variables store the username details
  String newUsername = "";

  /// these variables store the notfication settings
  String notificationType = "";
  String notificationTypeString = "Message";
  String notificationTime = "";

  // this variable sets the initial value for the
  String initialValue = "Message";

  // this variable stores the dropdown items
  var dropdownItems = [
    "Message",
    "Ringtone",
  ];

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

  /// function to chcek whether the password entered by the user matches the password already present in the database
  /// this ensures that the user does
  /*void checkPasswordmatch(String oldPasswordEntered, String oldPasswordStored) {
    print("Entered password ${oldPasswordEntered}");
    print("Stored password ${oldPasswordStored}");
    if (oldPasswordEntered == oldPasswordStored) {
      print("Correct password");
      /*SettingsLogic().saveSettings(
                newPassword,
                newUsername,
                notificationType,
                passwordEnabled,
                autoDeleteEnabled,
                notifyEnabled);*/
    } else {
      print("In correct password");
    }
  }*/

  /// this function reads the current settings from the database
  /// it assigns these settings as the default values to the settings variables
  /// if a setting is not modified it retains its default value
  /// "newPassword" and "newusername" gets assigned the old values so that they will retain them is they are not modified by the user
  /// if a value is not changed it retians the old value
  void readDefaultSettings() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      oldPasswordStored =
          sharedPreferences.getString("Userpassword").toString();
      newPassword = sharedPreferences.getString("Userpassword").toString();
      newUsername = sharedPreferences.getString("Username").toString();
      notificationType =
          sharedPreferences.getString("NotificationType").toString();
      passwordEnabled = sharedPreferences.getBool("PasswordStatus")!;
      autoDeleteEnabled = sharedPreferences.getBool("AutoDeleteStatus")!;
      notifyEnabled = sharedPreferences.getBool("NotifyStatus")!;
    });
  }

  /// function to display the enable password section
  Widget enablePasswordSection() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text("Enable Password",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 14)),
              )),
          Container(
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Center(
              child: FlutterSwitch(
                width: 70,
                height: 55,
                toggleSize: 30,
                value: passwordEnabled,
                borderRadius: 30,
                padding: 2.0,
                toggleColor: Colors.white,
                toggleBorder: Border.all(
                  color: Colors.black,
                  width: 4.0,
                ),
                activeColor: Colors.black,
                inactiveColor: Colors.black,
                duration: const Duration(milliseconds: 500),
                onToggle: (val) {
                  setState(() {
                    /// change the status of the password enable variable
                    passwordEnabled = val;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// function to display the enable auto delete tasks section
  Widget enableAutoDelete() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text("Auto Deleted Completed Tasks",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 14)),
              )),
          Container(
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Center(
              child: FlutterSwitch(
                width: 70.0,
                height: 55.0,
                toggleSize: 30,
                value: autoDeleteEnabled,
                borderRadius: 30,
                padding: 2.0,
                toggleColor: Colors.white,
                toggleBorder: Border.all(
                  color: Colors.black,
                  width: 4.0,
                ),
                activeColor: Colors.black,
                inactiveColor: Colors.black,
                duration: const Duration(milliseconds: 500),
                onToggle: (val) {
                  setState(() {
                    autoDeleteEnabled = val;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// function to display the notify due tasks section
  Widget enableNotifyDueTasks() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text("Notify Due Tasks",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 14)),
              )),
          Container(
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Center(
              child: FlutterSwitch(
                width: 70.0,
                height: 55.0,
                toggleSize: 30,
                value: notifyEnabled,
                borderRadius: 30,
                padding: 2.0,
                toggleColor: Colors.white,
                toggleBorder: Border.all(
                  color: Colors.black,
                  width: 4.0,
                ),
                activeColor: Colors.black,
                inactiveColor: Colors.black,
                duration: const Duration(milliseconds: 500),
                onToggle: (val) {
                  setState(() {
                    notifyEnabled = val;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// function to display the change password section
  Widget changePassword() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Change Password",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 14),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      oldPasswordEntered = value;
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
                    hintText: "Old Password",
                    hintStyle: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontSize: 13,
                        fontWeight: FontWeight.w100),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      newPassword = value;
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
                    hintText: "New Password",
                    hintStyle: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontSize: 13,
                        fontWeight: FontWeight.w100),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// function to display the change username section
  Widget changeUserName() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Change Username",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 14),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  newUsername = value;
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
                hintText: "New Username",
                hintStyle: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontSize: 13,
                    fontWeight: FontWeight.w100),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// function to display the notification setcion
  Widget notificationSettings() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Notification Settings",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 14),
              )),
          Container(
            height: MediaQuery.of(context).size.height * 0.09,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Notification type",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 12),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      child: DropdownButtonFormField(
                        value: initialValue,
                        dropdownColor: Colors.white,
                        iconEnabledColor: Colors.black,
                        iconDisabledColor: Colors.black,
                        items: dropdownItems.map((String items) {
                          return DropdownMenuItem(
                              value: items, child: Text(items));
                        }).toList(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(12, 10, 12, 0),
                        ),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 13),
                        onChanged: (String? value) {
                          setState(() {
                            notificationType = value!;
                            notificationTypeString = value;
                          });
                        },
                      ),
                    ),
                    Text(
                      notificationTypeString,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Ringtone",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 12),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.35,
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.upload,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Choose",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.35,
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Moonlight day",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Notification Time",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 12),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.punch_clock,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Set",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13),
                            ),
                          ],
                        )),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.35,
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "2100hrs",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// function to display the update changes button
  Widget updateChangesButton() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple, Colors.orange]),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: GestureDetector(
          onTap: () {
            confirmChangesDialog();
          },
          child: const Center(
              child: Text(
            "UPDATE CHANGES",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
          )),
        ));
  }

  /// function to display the delete database section (TASKS DATABASE)
  Widget deleteDatabase() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Delete Database",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w300, fontSize: 14),
          ),
          const SizedBox(width: 30),
          GestureDetector(
              onTap: () {
                // confirm delete dialog
                confirmDeleteDialog();
              },
              child: const Icon(Icons.delete))
        ],
      ),
    );
  }

  @override
  void initState() {
    /// read default settings
    readDefaultSettings();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(color: Colors.white),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 1,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  enablePasswordSection(),
                  enableAutoDelete(),
                  enableNotifyDueTasks(),
                  changePassword(),
                  changeUserName(),
                  notificationSettings(),
                  deleteDatabase(),
                  const SizedBox(height: 20),
                  updateChangesButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  /// alert dialog to propmt the user to confirm deletion of the database
  Future confirmDeleteDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          icon: const Icon(
            Icons.delete,
            size: 100,
            color: Colors.black26,
          ),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Center(
              child: ElevatedButton(
                  onPressed: () {
                    // delete both databases
                    SettingsLogic().deleteActiveTasksDatabase();
                    SettingsLogic().deleteInactiveTasksDatabase();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.black,
                      shadowColor: Colors.grey,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  child: const Text("CONFIRM")),
            ),
          )));

  /// alert dialog to prompt the user to confirm settings changes
  Future confirmChangesDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          icon: const Icon(
            Icons.update,
            size: 100,
            color: Colors.black26,
          ),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Center(
              child: ElevatedButton(
                  onPressed: () {
                    /// confirm the changes
                    SettingsLogic().saveSettings(
                        newPassword,
                        newUsername,
                        notificationType,
                        passwordEnabled,
                        autoDeleteEnabled,
                        notifyEnabled);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.black,
                      shadowColor: Colors.grey,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  child: const Text("CONFIRM")),
            ),
          )));
}
