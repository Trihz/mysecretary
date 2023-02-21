import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mysecretary/tasksdetails/tasksdetails_logic.dart';

class TaskDetailsUI extends StatefulWidget {
  String taskName = "";
  String taskDefinition = "";
  String startDate = "";
  String endDate = "";
  String taskGroup = "";
  String taskKey = "";
  TaskDetailsUI(this.taskName, this.taskDefinition, this.startDate,
      this.endDate, this.taskGroup, this.taskKey,
      {Key? key})
      : super(key: key);

  @override
  State<TaskDetailsUI> createState() => _TaskDetailsUIState();
}

class _TaskDetailsUIState extends State<TaskDetailsUI> {
  /// variable to store the main color
  Color mainColor = const Color.fromARGB(255, 41, 143, 174);

  /// function to diaplay the toast message
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

  /// this function makes all the details about the task to be blank after the task has been deleted
  void defaultState() {
    setState(() {
      widget.taskName = "";
      widget.taskGroup = "";
      widget.taskDefinition = "";
      widget.startDate = "";
      widget.endDate = "";
    });
  }

  /// function to display the task name section
  Widget taskName() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.04,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "TASK NAME",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w200),
                ),
              )),
          Container(
              height: MediaQuery.of(context).size.height * 0.04,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Center(
                  child: Text(
                    widget.taskName,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  /// function to display the task group section
  Widget taskGroup() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.04,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "TASK GROUP",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w200),
                ),
              )),
          Container(
              height: MediaQuery.of(context).size.height * 0.04,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Center(
                  child: Text(
                    widget.taskGroup,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  /// function to display the task definition section
  Widget taskDefinition() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.18,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "TASK DEFINITION",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w200),
                ),
              )),
          Container(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Center(
                  child: Text(
                    widget.taskDefinition,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  /// function to display the start and end date section
  Widget taskDates() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.11,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: const Center(
                  child: Text(
                    "START DATE",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w200),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: const Center(
                  child: Text(
                    "END DATE",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w200),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Center(
                  child: Text(
                    widget.startDate,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Center(
                  child: Text(
                    widget.endDate,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// this function gets executed first when the screen is launched
  @override
  void initState() {
    displayToast(widget.taskKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1, 1),
                    blurRadius: 1,
                    spreadRadius: 1)
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                taskName(),
                taskGroup(),
                taskDefinition(),
                taskDates()
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              confirmDeleteDialog();
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.purple, Colors.orange]),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: const Center(
                child: Text(
                  "DELETE TASK",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        ],
      ),
    ));
  }

  /// alert dialog to show succesfull deletion of a task
  Future taskDeletionDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          icon: const Icon(
            Icons.done,
            size: 100,
            color: Colors.black26,
          ),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: const Center(
              child: Text(
                "Task Deleted Successfully",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          )));

  /// alert dialog to propmt the user to confirm deletion of the task
  Future confirmDeleteDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          icon: const Icon(
            Icons.delete,
            size: 100,
            color: Colors.black26,
          ),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Center(
              child: ElevatedButton(
                  onPressed: () {
                    /// delete the task by recording it in the deleted tasks database
                    TaskDetailsLogic()
                        .recordDeletedTasksIndexes(widget.taskKey);
                    TaskDetailsLogic().readData();
                    defaultState();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.black,
                      shadowColor: Colors.grey,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  child: const Text("CONFIRM")),
            ),
          )));
}
