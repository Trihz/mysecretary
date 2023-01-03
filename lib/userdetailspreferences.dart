import 'package:shared_preferences/shared_preferences.dart';

class UserDetailsPreference {
  static Future init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  }

  // function to set username
  static Future setUserName(String username) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString("Username", username);
  }

  // function to get the username
  static Future<String> getUserName() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('Username') ?? "";
  }
}
