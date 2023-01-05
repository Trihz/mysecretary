import 'dart:collection';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

class Classlogic {
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
  HashMap<int, List<String>> readClassTasks() {
    int count = 1;
    String typeOfGrouping = "";
    HashMap<int, List<String>> classTasks = HashMap();
    int currentNumberOfTasks = int.parse(tasksDatabase.get(0));
    for (int x = 1; x <= currentNumberOfTasks; x++) {
      typeOfGrouping = tasksDatabase.get(x)[4];
      // check whether the grouping of task is "Class" and add it to the hashmap
      if (typeOfGrouping == "Class") {
        classTasks[count] = tasksDatabase.get(x);
        count++;
      }
    }
    displayToast(classTasks.toString());
    return classTasks;
  }

  /* 
      Function to determine if the task is active or not
      - it takes the endDate of the task as parameter
      - compares the endDate with today's date to determine if the tasks is active or not
      - returns a boolean to show the state of the task
      - True >> Active
      - False >> Not Active
  */
  bool computeTaskStatus(String endDate) {
    bool taskStatus = true;
    String todaysYear = DateFormat("yyyy").format(DateTime.now());
    String todaysMonth = DateFormat("MM").format(DateTime.now());
    String todaysDay = DateFormat("dd").format(DateTime.now());
    String endDateYear = endDate.substring(0, 4);
    String endDateMonth = endDate.substring(5, 7);
    String endDateDay = endDate.substring(8);
    if (int.parse(todaysYear) > int.parse(endDateYear)) {
      // if the current year is greater than the year of the task, then the task has passed deadline
      taskStatus = false;
    } else if (int.parse(todaysMonth) > int.parse(endDateMonth) &&
        int.parse(todaysYear) > int.parse(endDateYear)) {
      taskStatus = false;
    } else if (int.parse(todaysMonth) == int.parse(endDateMonth) &&
        int.parse(todaysYear) == int.parse(endDateYear) &&
        int.parse(todaysDay) > int.parse(endDateDay)) {
      taskStatus = false;
    }
    /*displayToast(endDateYear);
    displayToast(endDateMonth);
    displayToast(endDateDay);
    displayToast(todaysYear);
    displayToast(todaysMonth);
    displayToast(todaysDay);*/
    return taskStatus;
  }
}
