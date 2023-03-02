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
  HashMap<int, List<String>> readBusinessTasks(List<int> deletedIndexes) {
    int count = 1;
    int deletedTasksSize = deletedIndexes.length;
    int indexSimilarityCount = 0;
    String typeOfGrouping = "";
    List<String> defaultList = ["", "", "", "", ""];
    HashMap<int, List<String>> businessTasks = HashMap();

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
          } else {}
        }

        /// now check the value of the count
        /// if it is more than zero then there is similarity in the indexes
        /// skip this particular index
        /// its data has been deleted
        /// if it is zero then there is no similarity
        if (indexSimilarityCount == 0) {
          typeOfGrouping = tasksDatabase.get(x)[4];
          // check whether the grouping of task is "Class" and add it to the hashmap
          if (typeOfGrouping == "Business") {
            businessTasks[count] = tasksDatabase.get(x);
            count++;
          }
        }

        /// if count is non zero do nothing
        else {}

        /// clear the count variable
        indexSimilarityCount = 0;
      }
    }

    /// execute this if the the value at index 0 is null (initial value is not predefined)
    else {
      businessTasks[1] = defaultList;
    }

    displayToast(businessTasks.toString());
    return businessTasks;
  }
}
