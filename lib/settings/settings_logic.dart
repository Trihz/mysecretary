import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsLogic {
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
}
