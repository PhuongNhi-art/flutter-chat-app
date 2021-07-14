import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/src/config/app_colors.dart';
import 'package:helloworld/src/share_preference/user_preference.dart';
import 'package:helloworld/src/utils/app_url.dart';
import 'package:helloworld/src/utils/validation.dart';
import 'package:helloworld/src/utils/validation_item.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  ValidationItem currentpassword = ValidationItem(null, null);
  ValidationItem newpassword = ValidationItem(null, null);
  ValidationItem repeatnewpassword = ValidationItem(null, null);
  bool get isValid {
    if (newpassword.error == null && repeatnewpassword.error == null) {
      return true;
    } else
      return false;
  }

  void changeNewPassword(String value) {
    if (Validation.validatePass(value) != null) {
      newpassword = ValidationItem(value, Validation.validatePass(value));
    } else
      newpassword = ValidationItem(value, null);
    notifyListeners();
  }

  // void changeCurrentPassword(String value) {
  //   if (Validation.validatePass(value) != null) {
  //     currentpassword = ValidationItem(value, Validation.validatePass(value));
  //   } else
  //     currentpassword = ValidationItem(value, null);
  //   notifyListeners();
  // }

  void changeRepeatNewPassword(String value) {
    if (Validation.validateRepassword(newpassword.value.toString(), value) !=
        null) {
      repeatnewpassword = ValidationItem(value,
          Validation.validateRepassword(newpassword.value.toString(), value));
    } else
      repeatnewpassword = ValidationItem(value, null);
    notifyListeners();
  }

  void submitData() {
    if (newpassword.value != null && repeatnewpassword.value != null) {
      // String email = '';
      changePassword(newpassword.value.toString());
    }
  }

  Future<void> changePassword(String newpassword) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse(AppUrl.changepassword),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "_id": sharedPreferences.getString("_id").toString(),
        "newPassword": newpassword,
      }),
    );
    Map jsonData = jsonDecode(response.body) as Map;
    bool success = jsonData['success'];
    Fluttertoast.showToast(
        msg: jsonData['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: colorGray,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<bool> login(email, password) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    bool test = false;
    final response = await http.post(
      Uri.parse(AppUrl.login),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    Map jsonData = jsonDecode(response.body) as Map;
    bool success = jsonData['success'];
    if (success == true) {
      test = true;

      Fluttertoast.showToast(
          msg: "Login success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: colorGray,
          textColor: Colors.white,
          fontSize: 16.0);
      // String user = jsonData['message'];
      Map user = jsonData['message'] as Map;
      // String userid = user['_id'];
      print(user['_id']);
      sharedPreferences.setString('_id', user['_id']);
      // UserPreferences.saveUser()
    } else {
      String err = jsonData['message'];
      print(err);
      Fluttertoast.showToast(
          msg: err.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: colorGray,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    // print(test);
    print(Future<bool>.value(test));
    print(test);
    return Future<bool>.value(test);
  }
}
