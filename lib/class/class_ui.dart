import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:mysecretary/class/class_logic.dart';

class Class extends StatefulWidget {
  const Class({super.key});

  @override
  State<Class> createState() => _ClassState();
}

class _ClassState extends State<Class> {
  // variables to store the details about class tasks
  String taskName = "";
  String taskDefinition = "";
  String startDate = "";
  String endDate = "";

  // variable to store the main color
  Color mainColor = const Color.fromARGB(255, 41, 143, 174);

  // variable to hold class tasks
  HashMap<int, List<String>> classTasksHashMap = HashMap();

  // function to display the upper container
  Widget upperContainer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          title(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          refreshButton(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        ],
      ),
    );
  }

  // function to show dates title
  Widget title() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(color: Colors.white),
      child: Center(
        child: Text(
          "CLASS TASKS",
          style: TextStyle(
              color: mainColor, fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
    );
  }

  // function to display the dates container
  Widget refreshButton() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.04,
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: ElevatedButton(
          onPressed: (() {}),
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: mainColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
          child: const Text(
            "REFRESH",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
          ),
        ));
  }

  // function to display the lower container
  Widget lowerContainer() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: ListView.builder(
            itemCount: classTasksHashMap.length,
            itemBuilder: ((context, index) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.89,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: mainColor,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(1, 1),
                        blurRadius: 1,
                        spreadRadius: 1)
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      child: Center(
                        child: Text(
                          classTasksHashMap[index + 1]![0].toString(),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.all(5),
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      child: Center(
                        child: Text(
                          classTasksHashMap[index + 1]![1].toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 13),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      child: Center(
                        child: Text(
                          "( ${classTasksHashMap[index + 1]![2]} -- ${classTasksHashMap[index + 1]![3]} )",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 13),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Status:",
                            style: TextStyle(
                                color: mainColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 13),
                          ),
                          Text(
                            computeTaskStatusIndicator(
                                classTasksHashMap[index + 1]![3]),
                            style: TextStyle(
                                color: mainColor, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  ],
                ),
              );
            })));
  }

  // function to compute the vlaue of task status indicator
  String computeTaskStatusIndicator(String taskEndDate) {
    String taskStatusIndicator = "";
    bool taskStatus = Classlogic().computeTaskStatus(taskEndDate);
    if (taskStatus == true) {
      taskStatusIndicator = "ACTIVE";
    } else {
      taskStatusIndicator = "NOT ACTIVE";
    }
    return taskStatusIndicator;
  }

  @override
  void initState() {
    classTasksHashMap = Classlogic().readClassTasks(); // initialize class tasks
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(color: mainColor),
      child: Column(
        children: [upperContainer(), lowerContainer()],
      ),
    ));
  }
}
