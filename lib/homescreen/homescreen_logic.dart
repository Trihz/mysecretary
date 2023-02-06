import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'dart:collection';

class HomeScreenLogic {
  // referencing the already opened local
  final tasksDatabase = Hive.box("TasksDatabase");

  // variable to store the start date of each task
  String startDate = "";

  // function to open the box

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

  // this function gets the today's date,stores it in a string and returns its value
  String getTodaysDate() {
    String todayDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    return todayDate;
  }

  // this function builds the date after a user taps the scrolling dayss
  String buildScrollingDate(String dayTapped) {
    if (dayTapped.length == 1) {
      dayTapped = "0$dayTapped";
    }
    String builtDate = DateFormat("yyyy-MM-$dayTapped").format(DateTime.now());

    return builtDate;
  }

  /*
      Function to read data stored in the local database (current day data)
      - the data is displayed in a containers
      - i have created a "count" variable to store the next index to store data in the hashmap
      - the fucntion filters the tasks and finds the task for today by comparing the date of the task and the date today
      - the function also returns a hashmap containing all the taks for today
  */
  HashMap<int, List<String>> readTodaysData() {
    int count = 1;
    List<String> defaultList = ["", "", "", "", ""];
    HashMap<int, List<String>> todaysTasks = HashMap();
    todaysTasks[1] = defaultList;
    int currentNumberOfTasks = int.parse(tasksDatabase.get(0));
    String todaysDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    for (int x = 1; x <= currentNumberOfTasks; x++) {
      startDate =
          tasksDatabase.get(x)[2].toString(); // get the start date of each task
      // compare the start date with today's date
      if (todaysDate == startDate) {
        todaysTasks[count] = tasksDatabase.get(x);
        count++;
      }
    }
    displayToast(todaysTasks.toString());
    return todaysTasks;
  }

  /*
      Function to read all the data stored in the local database
      - the data is displayed in a containers
      - the function returns a hashmap containing all the tasks recorded by the user
  */
  HashMap<int, List<String>> readAllTasksData() {
    HashMap<int, List<String>> allTasks = HashMap();
    int currentNumberOfTasks = int.parse(tasksDatabase.get(0));
    for (int x = 1; x <= currentNumberOfTasks; x++) {
      allTasks[x] = tasksDatabase.get(x);
    }
    displayToast(allTasks.toString());
    return allTasks;
  }

  /*
      Function to read all the data stored in the local database for the specified date (date tapped by the user)
      - the data is displayed in a containers
      - the function returns a hashmap containing all the tasks recorded by the user
  */
  HashMap<int, List<String>> readTasksForDayTapped(String dateTapped) {
    int count = 1;
    String startDate = "";
    HashMap<int, List<String>> tasksForDayTapped = HashMap();
    int currentNumberOfTasks = int.parse(tasksDatabase.get(0));
    for (int x = 1; x <= currentNumberOfTasks; x++) {
      startDate = tasksDatabase.get(x)[2].toString();
      if (dateTapped == startDate) {
        tasksForDayTapped[count] = tasksDatabase.get(x);
        count++;
      }
    }
    displayToast(tasksForDayTapped.toString());
    return tasksForDayTapped;
  }

  /*
      function to return the number of days in the specified month
  */
  String numberOfDaysInTheMonth() {
    String days = "";
    return days;
  }
}
