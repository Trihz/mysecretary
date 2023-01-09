import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ConfigurationLogic {
  // referencing the already opened database
  final tasksDatabase = Hive.box("TasksDatabase");

  // function to display toast
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

  /*
     function to read data from the local storage
     - reads the data of specified index
     - data plus the index displayed in the toast
  */
  void readData() {
    displayToast(
        "Data Stored: ${tasksDatabase.get(0, defaultValue: "No data found")}");
  }

  /*
      function to predefine the key value
      - creates a new record in the database for holding key value
      - default key for this varible is '0'
      - this method is run once
  */
  void predefineKeyValue() {
    tasksDatabase.put(0, "0");
    displayToast("0 key predefined");
  }
}
