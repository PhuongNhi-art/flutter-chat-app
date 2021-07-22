import 'dart:convert';

import 'package:helloworld/src/pages/models/message_model.dart';
import 'package:helloworld/src/utils/app_url.dart';
import 'package:http/http.dart' as http;

class ChatViewModel {
  ChatViewModel() {}
  List<MessageModel> messages = [];
  Future<void> getMessage(String roomId) async {
    // userPrefModel = await userPref.getUser();

    // print("get user with last msg");
    var future = http.post(
      Uri.parse(AppUrl.getMessage),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "roomId": roomId,
      }),
    );
    final response = await future;
    Map jsonData = jsonDecode(response.body) as Map;
    bool success = jsonData['success'];
    // print("roomId ${roomId}");
    if (success == true) {
      if ((jsonData['message'] as List).isNotEmpty) {
        // print("Co ${jsonData["message"]}");
        messages = (jsonData['message'] as List)
            .map((data) => MessageModel.fromJson(data))
            .toList();
        // print("Message content ${messages[0].content}");
        // rooms.forEach((element) async {
        //   if (element.type == 0) {
        //     String username =
        //         await getUsername(element.users, userPrefModel.id.toString());
        //     element.name = username;
        //     print("usesrname after ${element.name}");
        //   }
        // });= rooms;
      } else
        print("Chua ${jsonData["message"]}");
    } else {
      messages = [];
      String err = jsonData['message'];
      print(err);
    }
  }
}
