import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

class BusinessLogic {
  // referencing the already opened local
  final tasksDatabase = Hive.box("TasksDatabase");

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

  /*
      Function to read all the data stored in the local database that have "class" as their grouping
      - the data is displayed in a containers
      - the function returns a hashmap containing all the tasks recorded by the user
  */
  HashMap<int, List<String>> readBusinessTasks() {
    int count = 1;
    String typeOfGrouping = "";
    HashMap<int, List<String>> businessTasks = HashMap();
    int currentNumberOfTasks = int.parse(tasksDatabase.get(0));
    for (int x = 1; x <= currentNumberOfTasks; x++) {
      typeOfGrouping = tasksDatabase.get(x)[4];
      // check whether the grouping of task is "Class" and add it to the hashmap
      if (typeOfGrouping == "Business") {
        businessTasks[count] = tasksDatabase.get(x);
        count++;
      }
    }
    displayToast(businessTasks.toString());
    return businessTasks;
  }
}
