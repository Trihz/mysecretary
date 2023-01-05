import 'dart:collection';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mysecretary/business/business_ui.dart';
import 'package:mysecretary/class/class_ui.dart';
import 'package:mysecretary/personal/personal_ui.dart';
import 'package:mysecretary/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // variable to store the main color
  Color mainColor = const Color.fromARGB(255, 41, 143, 174);
  // variable to store the color for uncompleted task
  Color uncompletedTaskColor = Colors.transparent;
  // variable to store the color for completed tasks
  Color completedTaskColor = const Color.fromARGB(255, 41, 143, 174);

  // variable to store the username
  String userName = "";

  // variable to store the date for today
  String todayDate = "";
  // a list to define the dates of the month
  List date = ["1", "2", "3", "04", "5", "6", "7", "8", "9", "10", "11", "12"];

  /* 
      function to get username 
      - achieved through shared preferences
      - stored in the local storage
  */
  void getUsername() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userNameStorage = sharedPreferences.getString("Username");
    setState(() {
      userName = userNameStorage.toString();
    });
  }

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

  // function to show the lower containe
  Widget upperContainer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width * 1,
      margin: const EdgeInsets.only(right: 3, left: 3),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 41, 143, 174),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          safeContainer(),
          firstContainer(),
          secondContainer(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          scrollingDates(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01)
        ],
      ),
    );
  }

  // Widget to show the upper container
  Widget lowerContainer(TabController tabController) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        children: [thirdContainer(tabController), fourthContainer()],
      ),
    );
  }

  // function to display the third container
  Widget thirdContainer(TabController tabController) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.47,
      width: MediaQuery.of(context).size.width * 1,
      padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [],
      ),
    );
  }

  // function to display the fourth container
  Widget fourthContainer() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width * 1,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: floatingButton());
  }

  // function to display safe container
  Widget safeContainer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
    );
  }

  // function to display the first container
  Widget firstContainer() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 1,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: profile());
  }

  // function to display the first container
  Widget secondContainer() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 1,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Center(child: groupings()));
  }

  // function to display the add button
  Widget groupings() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.17,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: const Center(
              child: Text(
                "GROUPINGS",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Class()));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.25,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 41, 143, 174),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(1, 1),
                            blurRadius: 1,
                            spreadRadius: 1)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.25,
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                            child: Image.asset("assets/class.png")),
                        const Text(
                          "Class",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (() {
                     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Personal()));
                  }),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.25,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 41, 143, 174),
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(1, 1),
                            blurRadius: 1,
                            spreadRadius: 1)
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.25,
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                            child: Image.asset("assets/personal.png")),
                        const Text(
                          "Personal",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (() {
                     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Business()));
                  }),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.25,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 41, 143, 174),
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(1, 1),
                            blurRadius: 1,
                            spreadRadius: 1)
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.25,
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                            child: Image.asset("assets/business.png")),
                        const Text(
                          "Business",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01)
        ],
      ),
    );
  }

  /// function to display the profile
  Widget profile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Text(
                    "Hello $userName",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  )),
              Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Text(
                    todayDate,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 12),
                  )),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Profile()));
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage("assets/steve.jpg"), fit: BoxFit.fill),
            ),
          ),
        ),
      ],
    );
  }

  // function to show scrolling dates
  Widget scrollingDates() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: ListView.builder(
          itemCount: date.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: (() {}),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.13,
                margin:
                    const EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 5),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Date",
                      style: TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.w300,
                          fontSize: 13),
                    ),
                    Text(
                      date[index].toString(),
                      style: TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    ),
                  ],
                ),
              ),
            );
          })),
    );
  }

  // function to display the add button
  Widget floatingButton() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 1,
      padding: const EdgeInsets.only(right: 30, left: 30),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {},
          child: const CircleAvatar(
              radius: 20,
              backgroundColor: Color.fromARGB(255, 41, 143, 174),
              child: Opacity(
                opacity: 0.7,
                child: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
              )),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          upperContainer(),
          lowerContainer(tabController),
        ],
      ),
    ));
  }
}
