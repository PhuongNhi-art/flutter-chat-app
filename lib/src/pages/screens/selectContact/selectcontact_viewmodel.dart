import 'dart:convert';

import 'package:helloworld/src/pages/models/user_model.dart';
import 'package:helloworld/src/share_preference/user_preference.dart';
import 'package:helloworld/src/utils/app_url.dart';
import 'package:http/http.dart' as http;

class SelectContactViewModel {
  UserPreferences userPref = new UserPreferences();
  late UserModel userPrefModel;
  List<UserModel> usersList = [];
  Future<void> getAllUsers() async {
    userPrefModel = await userPref.getUser();

    // print("get user with last msg");
    var future = http.post(
      Uri.parse(AppUrl.getAllUsers),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userId": userPrefModel.id.toString(),
      }),
    );
    final response = await future;
    Map jsonData = jsonDecode(response.body) as Map;
    bool success = jsonData['success'];

    if (success == true) {
      if ((jsonData['message'] as List).isNotEmpty) {
        usersList = (jsonData['message'] as List)
            .map((data) => UserModel.fromJson(data))
            .toList();
      }
    } else {
      usersList = [];
      String err = jsonData['message'];
      print(err);
    }
  }
}
