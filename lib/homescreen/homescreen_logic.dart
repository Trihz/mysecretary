import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'dart:collection';
import 'package:quiver/time.dart';

class HomeScreenLogic {
  // referencing the already opened local
  final tasksDatabase = Hive.box("TasksDatabase");

  /// database for storing deleted tasks keys
  final deletedTasksDatabase = Hive.box("DeletedTasksDatabase");

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

  // this function builds the date after a user taps the scrolling days
  String buildScrollingDate(String dayTapped) {
    if (dayTapped.length == 1) {
      dayTapped = "0$dayTapped";
    }
    String builtDate = DateFormat("yyyy-MM-$dayTapped").format(DateTime.now());

    return builtDate;
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

  /// function to load the deleted tasks keys
  /// this function has to be loaded each time the taks are loaded
  /// this is to ensure that deleted tasks wont be loaded
  /// function to view the data stored in deleted tasks database
  List<int> loadedDeletedTasks() {
    List<int> deletedTasks = [];
    int databaseSize = int.parse(deletedTasksDatabase.get(0));
    for (int x = 1; x <= databaseSize; x++) {
      deletedTasks.add(int.parse(deletedTasksDatabase.get(x.toString())));
    }
    print(deletedTasks);
    return deletedTasks;
  }

  /*
      Function to read data stored in the local database (current day data)
      - the data is displayed in a containers
      - i have created a "count" variable to store the next index to store data in the hashmap
      - the fucntion filters the tasks and finds the task for today by comparing the date of the task and the date today
      - the function also returns a hashmap containing all the taks for today
      - you have to skip indexes that have not data or data has been deleted
  */
  HashMap<int, List<String>> readTodaysData() {
    int count = 1;
    List<String> defaultList = ["", "", "", "", ""];
    HashMap<int, List<String>> todaysTasks = HashMap();

    if (tasksDatabase.get(0) != null) {
      int currentNumberOfTasks = int.parse(tasksDatabase.get(0));
      String todaysDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
      for (int x = 1; x <= currentNumberOfTasks; x++) {
        /// skip index 6
        if (x != 6) {
          /// get the start date of each task
          startDate = tasksDatabase.get(x)[2].toString();
          // compare the start date with today's date
          if (todaysDate == startDate) {
            todaysTasks[count] = tasksDatabase.get(x);
            count++;
          }
        }
      }
    } else {
      todaysTasks[1] = defaultList;
    }

    displayToast(todaysTasks.toString());
    return todaysTasks;
  }

  /* 
      Function to read all the data stored in the local database
      - the data is displayed in a containers
      - the function returns a hashmap containing all the tasks recorded by the user
      - you have to skip indexes that have not data or data has been deleted
  */
  HashMap<int, List<String>> readAllTasksData(List<int> deletedIndexes) {
    int count = 1;
    int deletedTasksSize = deletedIndexes.length;
    int indexSimilarityCount = 0;
    List<String> defaultList = ["", "", "", "", ""];
    HashMap<int, List<String>> allTasks = HashMap();

    /// execute this statement if the value at index 0 of the database is not null
    if (tasksDatabase.get(0) != null) {
      int currentNumberOfTasks = int.parse(tasksDatabase.get(0));
      for (int x = 1; x <= currentNumberOfTasks; x++) {
        /// run this for loop to check for any similarity btn the current index and the deleted tasks indexes
        /// if there is similarity then the count becomes non-zero
        for (int y = 0; y < deletedTasksSize; y++) {
          /// check whether the current index matches any of the deleted indexes
          /// if there is similarity then update the count
          /// if not do not update the count
          if (x == deletedIndexes[y]) {
            indexSimilarityCount++;
          }
        }

        /// now check the value of the count
        /// if it is more than zero then there is similarity in the indexes
        /// skip this particular index
        /// its data has been deleted
        /// if it is zero then there is no similarity
        if (indexSimilarityCount == 0) {
          allTasks[count] = tasksDatabase.get(x);
          count++;
        }

        /// if count is non zero do nothing
        else {}

        /// clear the count variable
        indexSimilarityCount = 0;
      }
    }

    /// execute this if the the value at index 0 is null (initial value is not predefined)
    else {
      allTasks[1] = defaultList;
      displayToast("Predefine Intial Value First");
    }

    print("Final Tasks: $allTasks");

    displayToast(allTasks.toString());
    return allTasks;
  }

  /// this function checks whether the value at index 0 is null or not
  /// it returns a response to indicate whether initial value has been defined
  /// the response can be "null" or "not null"
  String checkInitialValueStatus() {
    String initialValueStatus = "";
    if (tasksDatabase.get(0) != null) {
      initialValueStatus = "not null";
    } else {
      initialValueStatus = "null";
    }
    print(initialValueStatus);
    displayToast(initialValueStatus);
    return initialValueStatus;
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
  int numberOfDaysInTheMonth() {
    int daysInTheMonth = 0;
    String todaysYear = "";
    String todaysMonth = "";
    todaysYear = DateFormat("yyyy").format(DateTime.now());
    todaysMonth = DateFormat("MM").format(DateTime.now());
    daysInTheMonth = daysInMonth(int.parse(todaysYear), int.parse(todaysMonth));
    displayToast(daysInTheMonth.toString());
    return daysInTheMonth;
  }

  /// function to generate the days to be displayed in the scrolling dates
  List generateScrollingDates() {
    int days = HomeScreenLogic().numberOfDaysInTheMonth();
    List scrollingDates = [];
    for (int x = 1; x <= days; x++) {
      scrollingDates.add(x);
    }
    return scrollingDates;
  }
}
