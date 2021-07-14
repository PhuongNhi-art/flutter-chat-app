import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/src/config/app_colors.dart';
import 'package:helloworld/src/pages/models/user_model.dart';
import 'package:helloworld/src/share_preference/user_preference.dart';
import 'package:helloworld/src/utils/app_url.dart';
import 'package:helloworld/src/utils/validation.dart';
import 'package:helloworld/src/utils/validation_item.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class SignUpViewModel extends ChangeNotifier {
  ValidationItem email = ValidationItem(null, null);
  ValidationItem password = ValidationItem(null, null);
  ValidationItem username = ValidationItem(null, null);
  ValidationItem repassword = ValidationItem(null, null);

  UserPreferences userPref = new UserPreferences();
  late UserModel userPrefModel;
  bool get isValid {
    if (email.error == null &&
        password.error == null &&
        repassword.error == null &&
        username.error == null) {
      return true;
    } else
      return false;
  }

  void changeEmail(String value) {
    if (Validation.validateEmail(value) != null) {
      email = ValidationItem(value, Validation.validateEmail(value));
    } else
      email = ValidationItem(value, null);

    notifyListeners();
  }

  void changePassword(String value) {
    if (Validation.validatePass(value) != null) {
      password = ValidationItem(value, Validation.validatePass(value));
    } else
      password = ValidationItem(value, null);
    notifyListeners();
  }

  void changeUsername(String value) {
    if (Validation.validateUser(value) != null) {
      username = ValidationItem(value, Validation.validateUser(value));
    } else
      username = ValidationItem(value, null);
    notifyListeners();
  }

  void changeRepassword(String value) {
    print(Validation.validateRepassword(password.value.toString(), value));
    if (Validation.validateRepassword(password.value.toString(), value) !=
        null) {
      repassword = ValidationItem(value,
          Validation.validateRepassword(password.value.toString(), value));
    } else
      repassword = ValidationItem(value, null);
    notifyListeners();
  }

  Future<void> submitData() async {
    if (email.value != null && password != null && repassword != null) {
      await signup(email.value.toString(), username.value.toString(),
          password.value.toString());
    }
  }

  Future<void> signup(String email, String username, String password) async {
    final response = await http.post(
      Uri.parse(AppUrl.register),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'username': username,
        'password': password,
      }),
    );
    // print('email${_email}');
    // print('password${_password}');
    Map jsonData = jsonDecode(response.body) as Map;
    bool success = jsonData['success'];
    if (success == true) {
      Fluttertoast.showToast(
          msg: "Register success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: colorGray,
          textColor: Colors.white,
          fontSize: 16.0);
      Map user = jsonData['message'] as Map;
      UserModel userModel = new UserModel(
          id: user['_id'],
          username: user['username'],
          email: user['email'],
          token: jsonData['token']);

      await userPref.saveUser(userModel);
      userPrefModel = await userPref.getUser();
      // Navigator.pop(Chat());

    } else {
      String err = jsonData['message'];
      Fluttertoast.showToast(
          msg: err.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: colorGray,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
