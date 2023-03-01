import 'package:flutter/material.dart';
import 'package:mysecretary/homescreen/homescreen_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  String enteredPassword = "";

  String storedPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple, Colors.orange])),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.purple, Colors.orange],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(1, 1),
                      blurRadius: 1,
                      spreadRadius: 1)
                ],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: const Center(
                      child: Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  )),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: TextField(
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        enteredPassword = value;
                      });
                    },
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      prefixIcon: Opacity(
                        opacity: 0.5,
                        child: Icon(
                          Icons.password_rounded,
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 13,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: ElevatedButton(
                    onPressed: () {
                      authenticatePassword();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5)))),
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void authenticatePassword() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    storedPassword = sharedPreferences.getString("Userpassword")!;
    print(storedPassword);
    print(enteredPassword);
    if (enteredPassword == storedPassword) {
      print("Correct password");
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      print("Incorrect password");

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(child: Text("Incorrect Password",style: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.w800),)),
        backgroundColor: Colors.white54,
        duration: Duration(milliseconds: 500),
      ));
    }
  }
}
