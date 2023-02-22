import 'dart:collection';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mysecretary/newtask/newtask_logic.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  // this variable sets the initial value for the dropdown
  String initialValue = "Class";

  // variable to store the value of grouping from the dropdown
  String taskGroup = "";

  // this variable stores the dropdown items
  var dropdownItems = [
    "Class",
    "Personal",
    "Business",
  ];
  // variable to store the main color
  Color mainColor = const Color.fromARGB(255, 41, 143, 174);

  // variables to store the task definition and task name
  // ignore: non_constant_identifier_names
  String taskName_TextField = "";
  // ignore: non_constant_identifier_names
  String taskDefinition_TextField = "";

  // variables to strore the start and end date
  // ignore: non_constant_identifier_names
  String taskStartDate_Calendar = "";
  // ignore: non_constant_identifier_names
  String taskEndDate_Calendar = "";

  // variable to storethe selected date
  String selectedDateStart = "";
  String selectedDateEnd = "";

  // function to return today's date
  DateTime today = DateTime.now();

  // text form controller
  final TextEditingController textEditingController = TextEditingController();

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

  /// fill all fieds snackbar
  void showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 1000),
        backgroundColor: Colors.white,
        content: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: const Center(
                child: Text(
              "Please fill all the details",
              style: TextStyle(color: Colors.red),
            ))),
      ),
    );
  }

  // function to show the selected day
  void _onDaySelected(DateTime day, DateTime focusedday) {
    setState(() {
      today = day;
    });
  }

  // function to return the table calendar
  Widget tableCalendar() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width * 1,
      margin: const EdgeInsets.only(right: 2, left: 2),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.orange]),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TableCalendar(
        focusedDay: today,
        daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Colors.white),
            weekendStyle: TextStyle(color: Colors.white)),
        headerStyle: const HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500)),
        calendarStyle: const CalendarStyle(
            selectedDecoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            selectedTextStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            weekendTextStyle: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
            todayDecoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            todayTextStyle:
                TextStyle(fontWeight: FontWeight.w400, color: Colors.black)),
        availableGestures: AvailableGestures.all,
        selectedDayPredicate: (day) => isSameDay(day, today),
        firstDay: DateTime(2010),
        lastDay: DateTime(2040),
        rowHeight: 30,
        onDaySelected: _onDaySelected,
      ),
    );
  }

  // function to display the start date
  Widget startDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.2,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: const Center(
            child: Text(
              "START DATE",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 13),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.2,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: const Center(
            child: Text(
              "END DATE",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  // function to dsiplay the end date
  Widget endDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedDateStart = today.toString().split(" ")[0];
              taskStartDate_Calendar = selectedDateStart;
            });
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.35,
            padding: const EdgeInsets.only(right: 20, left: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.purple, Colors.orange]),
              boxShadow: [
                BoxShadow(
                    color: Colors.transparent,
                    offset: Offset(1, 1),
                    blurRadius: 1,
                    spreadRadius: 1)
              ],
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
            child: Center(
              child: Text(
                taskStartDate_Calendar,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selectedDateEnd = today.toString().split(" ")[0];
              taskEndDate_Calendar = selectedDateEnd;
            });
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.35,
            padding: const EdgeInsets.only(right: 20, left: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.purple, Colors.orange]),
              boxShadow: [
                BoxShadow(
                    color: Colors.transparent,
                    offset: Offset(1, 1),
                    blurRadius: 1,
                    spreadRadius: 1)
              ],
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
            child: Center(
              child: Text(
                taskEndDate_Calendar,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // function to display the dropdown for selecting the type of task grouping  (Class,Personal,Business)
  Widget groupingsDropdown() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: DropdownButtonFormField(
          value: initialValue,
          dropdownColor: Colors.white,
          iconEnabledColor: Colors.grey,
          iconDisabledColor: Colors.grey,
          items: dropdownItems.map((String items) {
            return DropdownMenuItem(value: items, child: Text(items));
          }).toList(),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(2),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            isDense: true,
            contentPadding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
          ),
          style: const TextStyle(color: Colors.grey, fontSize: 13),
          onChanged: (String? value) {
            setState(() {
              taskGroup = value!;
            });
          },
        ),
      ),
    );
  }

  // function to display the task name area
  Widget taskNameField() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: TextField(
        onChanged: (value) {
          setState(() {
            taskName_TextField = value;
          });
        },
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          prefixIcon: Icon(
            Icons.task,
            color: Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          hintText: "Task name",
          hintStyle: TextStyle(
              color: Colors.grey,
              fontStyle: FontStyle.italic,
              fontSize: 12,
              fontWeight: FontWeight.w300),
        ),
      ),
    );
  }

  // function to display the task recording area
  Widget taskDefinitionField() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: TextFormField(
          controller: textEditingController,
          minLines: 3,
          maxLines: 6,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
              hintText: "Task definition",
              hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5)))),
        ));
  }

  // function to display the save button
  Widget saveButton() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: ElevatedButton(
          onPressed: () {
            setState(() {
              taskDefinition_TextField = textEditingController.value.text;
            });

            if (taskName_TextField == "" ||
                taskDefinition_TextField == "" ||
                taskStartDate_Calendar == "" ||
                taskEndDate_Calendar == "" ||
                taskGroup == "") {
              showSnackBar();
            } else {
              NewTaskLogic().recordData(
                  taskName_TextField,
                  taskDefinition_TextField,
                  taskStartDate_Calendar,
                  taskEndDate_Calendar,
                  taskGroup);

              /// revert the values back to default state
              setState(() {
                taskName_TextField = "";
                taskDefinition_TextField = "";
                taskStartDate_Calendar = "";
                taskEndDate_Calendar = "";
                taskGroup = "";
              });
              taskCreationDialog();
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shadowColor: Colors.grey,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)))),
          child: const Text(
            "SAVE",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          )),
    );
  }

  @override
  void initState() {
    Hive.openBox("TasksDatabase");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(color: Colors.white),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            tableCalendar(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            groupingsDropdown(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            startDate(),
            endDate(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            taskNameField(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            taskDefinitionField(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            saveButton()
          ],
        ),
      ),
    ));
  }

  /// alert dialog to show succesfull creation of a task
  Future taskCreationDialog() => showDialog(
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
                "Task Successfully Created",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          )));
}
