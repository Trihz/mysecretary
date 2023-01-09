import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  // variable to store the main color
  Color mainColor = const Color.fromARGB(255, 41, 143, 174);

  // variable to hold the sate of the theme
  bool themeStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  padding: const EdgeInsets.only(left: 30),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Name",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 15),
                    ),
                  ),
                ),
                /*Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      prefixIcon: Opacity(
                        opacity: 0.5,
                        child: Icon(
                          Icons.person,
                          color: mainColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color: mainColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color: mainColor,
                        ),
                      ),
                      hintText: "Username",
                      hintStyle: TextStyle(
                          color: mainColor,
                          fontStyle: FontStyle.italic,
                          fontSize: 13,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),*/
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  padding: const EdgeInsets.only(left: 30,right: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child:  Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Theme",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: mainColor,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.23,
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: FlutterSwitch(
                            width: 100.0,
                            height: 55.0,
                            toggleSize: 30,
                            value: themeStatus,
                            borderRadius: 30,
                            padding: 2.0,
                            toggleColor: Colors.white,
                            toggleBorder: Border.all(
                              color: mainColor,
                              width: 4.0,
                            ),
                            activeColor: mainColor,
                            activeText: "B",
                            inactiveColor: mainColor,
                            inactiveText: "C",
                            onToggle: (val) {
                              setState(() {
                                themeStatus = val;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Center(
              child: CircleAvatar(
                radius: 37,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: mainColor,
                  child: const Text(
                    "CONFIGURE",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 10),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
