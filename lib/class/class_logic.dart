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
      - tasks that have been deleted are not returned
      - it takes a parameter which contains a list of indexes of all deleted tasks
  */
  HashMap<int, List<String>> readClassTasks(List<int> deletedIndexes) {
    int count = 1;
    int deletedTasksSize = deletedIndexes.length;
    int indexSimilarityCount = 0;
    String typeOfGrouping = "";
    List<String> defaultList = ["", "", "", "", ""];
    HashMap<int, List<String>> classTasks = HashMap();

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
          if (typeOfGrouping == "Class") {
            classTasks[count] = tasksDatabase.get(x);
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
      classTasks[1] = defaultList;
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
