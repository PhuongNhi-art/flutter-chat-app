import 'dart:convert';

import 'package:helloworld/src/pages/models/chat_temp.dart';
import 'package:helloworld/src/pages/models/user_model.dart';
import 'package:helloworld/src/share_preference/user_preference.dart';
import 'package:helloworld/src/utils/app_url.dart';

import 'package:http/http.dart' as http;

class HomeViewModel {
  List<ChatTempModel> usersTemp = [];
  UserPreferences userPref = new UserPreferences();
  late UserModel userPrefModel;
  HomeViewModel() {
    // getUserWithLastMsg();
  }
  Future<void> getUserWithLastMsg() async {
    userPrefModel = await userPref.getUser();

    print("get user with last msg");
    final response = await http.post(
      Uri.parse(AppUrl.getAllUsers),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userId": userPrefModel.id.toString(),
      }),
    );
    Map jsonData = jsonDecode(response.body) as Map;
    usersTemp = (jsonData['message'] as List)
        .map((data) => ChatTempModel.fromJson(data))
        .toList();
    // print(usersTemp[0].email);
    print("user in home ${userPrefModel.id.toString()}");
  }
}
