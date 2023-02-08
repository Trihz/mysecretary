import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DebuggerLogic {
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

  /// this function reads the new settings that have been updated in the local storage
  /// it displays them using a display toast
  /// DEBUGGING FUNCTION
  void readSettings() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    displayToast(sharedPreferences.getString("Username").toString());
    displayToast(sharedPreferences.getString("Userpassword").toString());
    displayToast(sharedPreferences.getString("NotificationType").toString());
  }
}
