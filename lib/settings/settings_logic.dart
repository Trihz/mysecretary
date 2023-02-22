import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsLogic {
  /// referencing the already opened database
  /// this is the tasks database
  final tasksDatabase = Hive.box("TasksDatabase");

  /// database for storing inactive tasks
  final deletedTasksDatabase = Hive.box("DeletedTasksDatabase");

  /// function to display toast
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

  /// this function saves the settings to the local storage
  void saveSettings(
      String newPassword,
      String newUsername,
      String notificationType,
      bool passwordEnabled,
      bool autoDeleteEnabled,
      bool notifyEnabled) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("Username", newUsername);
    sharedPreferences.setString("Userpassword", newPassword);
    sharedPreferences.setString("NotificationType", notificationType);
    sharedPreferences.setBool("PasswordStatus", passwordEnabled);
    sharedPreferences.setBool("AutoDeleteStatus", autoDeleteEnabled);
    sharedPreferences.setBool("NotifyStatus", notifyEnabled);
  }

  /// this function deletes the whole database including all the data contained in the database
  /// it deletes the tasks database
  void deleteActiveTasksDatabase() async {
    tasksDatabase.deleteFromDisk();
  }

  /// this function deletes the whole database including all the data contained in the database
  /// it deletes the inactive tasks database
  void deleteInactiveTasksDatabase() {
    deletedTasksDatabase.deleteFromDisk();
    displayToast("Databases deleted");
  }

  /// this function resets the database after deleting it
  void resetDatabase() async {}
}
