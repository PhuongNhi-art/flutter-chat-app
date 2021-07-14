import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/src/config/app_colors.dart';
import 'package:helloworld/src/utils/app_url.dart';
import 'package:helloworld/src/utils/validation.dart';
import 'package:helloworld/src/utils/validation_item.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordViewModel extends ChangeNotifier {
  ValidationItem email = ValidationItem(null, null);
  bool result = false;
  bool get isValid {
    if (email.error == null) {
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

  // void submitData() {
  //   if (email.value != null) {
  //     forgotPassword(email.value.toString());
  //   }
  // }

  Future<bool> forgotPassword() async {
    bool test = false;
    if (email.value != null) {
      final response = await http.post(
        Uri.parse(AppUrl.forgotpassword),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email.value.toString(),
        }),
      );
      print(email);
      Map jsonData = jsonDecode(response.body) as Map;
      bool success = jsonData['success'];
      if (success == true) {
        test = true;
        Fluttertoast.showToast(
            msg: "Verification code has been sent to your email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: colorGray,
            textColor: Colors.white,
            fontSize: 16.0);
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
      // return Future<bool>.value(test);
    }
    return Future<bool>.value(test);
  }
}
