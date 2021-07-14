import 'package:flutter/material.dart';
import 'package:helloworld/src/pages/models/message_model.dart';
import 'package:helloworld/src/pages/models/user_model.dart';
import 'package:helloworld/src/share_preference/user_preference.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatViewModel extends ChangeNotifier {
  // late IO.Socket socket;
  // UserPreferences userPref = new UserPreferences();
  // late UserModel userPrefModel;
  // List<MessageModel> messages = [];
  // // String message = "";
  // // void changeMesssage(String value) {
  // //   message = value;
  // // }
  // // Future<void> getUser() async {
  // //   userPrefModel = await userPref.getUser();
  // //   print("userPrefmodel ${userPrefModel.email}");
  // // }
  // ChatViewModel() {}
  // Future<void> connect() async {
  //   userPrefModel = await userPref.getUser();
  //   print("userPrefModel ${userPrefModel.id.toString()}");
  //   socket = IO.io("http://192.168.1.244:8081", <String, dynamic>{
  //     "transports": ["websocket"],
  //     "autoConnect": false,
  //   });
  //   socket.connect();
  //   socket.emit("signin", userPrefModel.id);
  //   socket.onConnect((data) {
  //     print("Connected");
  //     socket.on("message", (msg) {
  //       print("destination" + msg);

  //       setMessage("destination", msg);
  //     });
  //   });
  //   // print(socket.connected);
  // }

  // Future<void> sendMessage(String message, String targetId) async {
  //   userPrefModel = await userPref.getUser();
  //   print("targetId ${targetId}");
  //   String sourceId = userPrefModel.id.toString();
  //   print("Source id ${sourceId}");
  //   // print(
  //   //     "userPrefmodel ${userPrefModel.id} ${userPrefModel.email}${userPrefModel.username}");
  //   setMessage("source", message);
  //   socket.emit("message",
  //       {"message": message, "sourceId": sourceId, "targetId": targetId});
  // }

  // void setMessage(String type, String message, String) {
  //   MessageModel messageModel = MessageModel(message: message, type: type);
  //   messages.add(messageModel);
  //   print("message in set ${messageModel.message}");
  //   notifyListeners();
  // }
}
