import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

String userLoggedInKey = "USERLOGGEDINKEY";

class HelperFunctions {
  static saveUserLoggedInDetails({@required bool isLoggedIn}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(userLoggedInKey, isLoggedIn);
  }

  static Future<bool> getUserLoggedInDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(userLoggedInKey);
  }
}
