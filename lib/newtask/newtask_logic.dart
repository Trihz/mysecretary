import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

class NewTaskLogic {
  // referencing the already opened database
  final tasksDatabase = Hive.box("TasksDatabase");

  // String to store the key of this task
  String taskKey = "";

  // hashmap to store the task details
  List<String> taskData = ["", "", "", "", "", ""];

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
    // ignore: prefer_interpolation_to_compose_strings
    displayToast(
        // ignore: prefer_interpolation_to_compose_strings
        "Data Stored: " +
            tasksDatabase.get(0, defaultValue: "No data found").toString());
  }

  /*
     function to delete the whole database
     - removes the file which contains the box
     - closes the box
     - the app should be restarted
     - the "predefineKeyValue()" should be run each time the database is closed
  */
  void deleteDatabase() {
    tasksDatabase.deleteFromDisk();
    displayToast("Database deleted");
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

  /*  
      function to increment the key and update it each a new task needs to be added
      - checks the value of current key
      - increments it 
      - stores the data with the incremented value
      - updates the key variable in the locala database
  */
  void newTaskKey() {
    int keyValue = int.parse(tasksDatabase.get(0));
    keyValue = keyValue + 1;
    taskKey = keyValue.toString(); /* set the key value */
    tasksDatabase.put(0, keyValue.toString());
  }

  /*
      function to set the task data to be recorded into the local database
      - start date
      - end date
      - task name
      - task definition
      - The data is recorded into a hashmap
  */
  void newTaskData(String taskName, String taskDefinition, String startDate,
      String endDate, String taskGroup, String taskKey) {
    /* set the data values */
    taskData[0] = taskName;
    taskData[1] = taskDefinition;
    taskData[2] = startDate;
    taskData[3] = endDate;
    taskData[4] = taskGroup;
    taskData[5] = taskKey;
    displayToast(taskData.toString());
  }

  /* 
      Function to record data to the local device database 
      - the key used is the value stored in key "0" in the local database
      - the data stored is the task name,definition,start date and end date all under "taskDetails" variable
      - "determineKeyValue()" method is run in the start of this method to get the key value to be used
  */
  void recordData(String taskName, String taskDefinition, String startDate,
      String endDate, String taskGroup) {
    newTaskKey();
    newTaskData(
        taskName, taskDefinition, startDate, endDate, taskGroup, taskKey);
    tasksDatabase.put(int.parse(taskKey), taskData);
  }
}
