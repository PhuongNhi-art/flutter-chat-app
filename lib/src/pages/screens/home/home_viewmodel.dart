import 'dart:convert';

import 'package:helloworld/src/config/constants.dart';
import 'package:helloworld/src/pages/models/message_model.dart';
import 'package:helloworld/src/pages/models/room_model.dart';
import 'package:helloworld/src/pages/models/user_model.dart';
import 'package:helloworld/src/share_preference/user_preference.dart';
import 'package:helloworld/src/utils/app_url.dart';
import 'package:date_format/date_format.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeViewModel {
  List<RoomModel> rooms = [];
  List<RoomModel> roomModels = [];
  int haveNewMsg = 0;
  UserPreferences userPref = new UserPreferences();
  late UserModel userPrefModel;
  IO.Socket socket = IO.io("http://192.168.1.244:8081", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
    // "query": widget.userModel.toString(),
  });
  List<MessageModel> newMessages = [];
  HomeViewModel() {
    // getUserWithLastMsg();
  }
  Future<void> getRooms() async {
    userPrefModel = await userPref.getUser();

    // print("get user with last msg");
    var future = http.post(
      Uri.parse(AppUrl.getRoom),
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
        // print("Co ${jsonData["message"]}");
        rooms = (jsonData['message'] as List)
            .map((data) => RoomModel.fromJson(data))
            .toList();
        // rooms.forEach((element) async {
        //   if (element.type == 0) {
        //     String username =
        //         await getUsername(element.users, userPrefModel.id.toString());
        //     element.name = username;
        //     print("usesrname after ${element.name}");
        //   }
        // });
        // roomModels = rooms;
      } else
        print("Chua ${jsonData["message"]}");
    } else {
      roomModels = [];
      String err = jsonData['message'];
      print(err);
    }
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }

  // Future<String> getUsername(List<String> users, String userId) async {
  //   // userPrefModel = await userPref.getUser();
  //   users.removeWhere((element) => element == userId);
  //   print("user0 ${users[0]}");
  //   print("get user with last msg");
  //   var future = http.post(
  //     Uri.parse(AppUrl.findUsername),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       "id": users[0],
  //     }),
  //   );
  //   final response = await future;
  //   Map jsonData = jsonDecode(response.body) as Map;
  //   Map user = await jsonData['user'] as Map;
  //   bool success = jsonData['success'];

  //   if (success == true) {
  //     print('username ${user['username']}');
  //     return user['username'];
  //   } else {
  //     String err = jsonData['message'];
  //     print(err);
  //     return "";
  //   }
  // }
  Future<void> connect() async {
    UserPreferences userPref = new UserPreferences();
    UserModel userPrefModel = await userPref.getUser();

    socket.connect();
    socket.onConnect((data) {
      print("Connected");
      socket.emit(Constants.SIGNIN, userPrefModel.id);
      // socket.emit(Constants.JOIN_ROOM, userPrefModel.id);
    });
    socket.on(Constants.MESSAGE, (msg) {
      // print(msg);
      MessageModel message = MessageModel.fromJson(msg);
      print("listen message ${msg}");
      newMessages.add(message);
      haveNewMsg++;
      print(haveNewMsg.toString());

      // print("message ${messageModel.content.toString()}");
    });
  }
}
