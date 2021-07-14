import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/src/pages/models/user_model.dart';
import 'package:helloworld/src/pages/screens/chat/chat_view.dart';
import 'package:helloworld/src/share_preference/user_preference.dart';
import 'package:helloworld/src/utils/app_url.dart';
import 'package:helloworld/src/utils/validation.dart';
import 'package:helloworld/src/config/app_colors.dart';
import 'package:helloworld/src/utils/validation_item.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInViewModel extends ChangeNotifier {
  ValidationItem email = ValidationItem(null, null);
  ValidationItem password = ValidationItem(null, null);
  UserPreferences userPref = new UserPreferences();
  late UserModel userPrefModel;
  bool get isValid {
    if (email.error == null && password.error == null) {
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

  Future<void> submitData() async {
    if (email.value != null && password != null) {
      await login(email.value.toString(), password.value.toString());
    }
  }

  Future<void> login(String email, String password) async {
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
      Fluttertoast.showToast(
          msg: "Login success",
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
      // userPrefModel = await userPref.getUser();
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
  }
}
