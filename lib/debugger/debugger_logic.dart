import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:collection';
import 'package:hive/hive.dart';

class DebuggerLogic {
  // referencing the already opened local
  final tasksDatabase = Hive.box("TasksDatabase");

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
    displayToast(sharedPreferences.getBool("PasswordStatus").toString());
    displayToast(sharedPreferences.getBool("AutoDeleteStatus").toString());
    displayToast(sharedPreferences.getBool("NotifyStatus").toString());
  }

  /// function to display all the task present
  /// including their details
  void readAllTasksData() {
    int count = 1;
    List<int> deletedIndexes = [];
    int deletedTasksSize = deletedIndexes.length;
    int indexSimilarityCount = 0;
    HashMap<int, List<String>> allTasks = HashMap();
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

    print("Final Tasks: $allTasks");

    displayToast(allTasks.toString());
  }

  /// this function checks the value at index 0 of the tasks database
  void readIndex_0_Value() {
    if (tasksDatabase.get(0) == null) {
      displayToast("No value defined at index 0");
    } else {
      displayToast(tasksDatabase.get(0));
    }
  }
}
