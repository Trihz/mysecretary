import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskDetailsLogic {
  /// referencing the already opened database
  /// database for storing the tasks
  final tasksDatabase = Hive.box("TasksDatabase");

  /// database for storing deleted tasks keys
  final deletedTasksDatabase = Hive.box("DeletedTasksDatabase");

  // String to store the key of this task
  String deletedTaskKey = "";

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

  /// we have to create a variable that keeps track of the current index
  /// the variable is stored in the database
  /// we define the variable and store its value in the database
  /// we define the key of the variable to "0"
  /// the initial value is defined to be "0"
  /// each time a new task needs to be added then the variable is incremented and used as a key for the current task
  /// this function is run once
  void predefineKeyValue() {
    deletedTasksDatabase.put(0, "0");
    displayToast("0 key predefined");
  }

  /// this function updates the task key to be used to store the current task being added
  /// the value at index "0" is first fetched from the database
  /// it is incremented
  /// converted into a string
  /// assigned to a local varible
  /// this value is the updated into the database
  void newKey() {
    int keyValue = int.parse(deletedTasksDatabase.get(0));
    keyValue = keyValue + 1;
    deletedTaskKey = keyValue.toString();
    deletedTasksDatabase.put(0, keyValue.toString());
  }

  /// function to record the indexes of the tasks deleted
  /// the indexes are recorded in a local database created using hive
  /// the indexes are integers
  /// method to fetch the key is first called then the data recorded using the newly fetched keys
  void recordDeletedTasksIndexes(String taskKey) {
    newKey();
    deletedTasksDatabase.put(deletedTaskKey, taskKey);
    print(deletedTaskKey);
  }

  /// function to view the deleted tasks keys
  /// reads the current size of the database
  void readDeletedTasksKeys() {
    String size = deletedTasksDatabase.get(0);
    print("Size of database: $size");
  }

  /// function to view the data stored in deleted tasks database
  void readData() {
    List deletedTasks = [];
    int databaseSize = int.parse(deletedTasksDatabase.get(0));
    for (int x = 1; x <= databaseSize; x++) {
      deletedTasks.add(deletedTasksDatabase.get(x.toString()));
    }
    print(deletedTasks);
  }

  /// function to delete the deleted tasks database
  /// deletes the whole database
  void deleteDatabase() {
    deletedTasksDatabase.deleteFromDisk();
    displayToast("Database deleted");
  }

  /// this function deletes the specified task from the local database
  void deleteSpecifiedTask(String taskKey) {
    tasksDatabase.delete(int.parse(taskKey));
  }
}
