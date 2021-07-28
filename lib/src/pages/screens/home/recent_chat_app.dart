import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/src/config/constants.dart';
import 'package:helloworld/src/pages/models/message_model.dart';
import 'package:helloworld/src/pages/models/room_model.dart';
import 'package:helloworld/src/pages/models/user_model.dart';

import 'package:helloworld/src/pages/screens/chat/chat_view.dart';
import 'package:helloworld/src/pages/screens/chat/chat_viewmodel.dart';
import 'package:helloworld/src/pages/screens/home/home_viewmodel.dart';
import 'package:helloworld/src/share_preference/user_preference.dart';
import 'package:helloworld/src/utils/utils.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class RecentChat extends StatefulWidget {
  @override
  _RecentChatState createState() => _RecentChatState();
  List<RoomModel> roomModel = [];
  // late IO.Socket socket;
  // int haveNewMsg = 0;
  RecentChat({
    Key? key,
    required this.roomModel,
    // // required this.socket,
    // required this.haveNewMsg
  }) : super(key: key);
}

class _RecentChatState extends State<RecentChat> {
  List<MessageModel> newMessages = [];
  // int haveNewMsg = 0;
  IO.Socket socket = IO.io("http://192.168.1.244:8081", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
    // "query": widget.userModel.toString(),
  });
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
  }

  Future<void> connect() async {
    UserPreferences userPref = new UserPreferences();
    UserModel userPrefModel = await userPref.getUser();
    socket.connect();
    socket.onConnect((data) {
      print("Connected");
      socket.emit(Constants.SIGNIN, userPrefModel.id);
      // socket.emit(Constants.JOIN_ROOM, userPrefModel.id);
    });
    socket.on(Constants.NEW_MESSAGE, (msg) {
      MessageModel message = MessageModel.fromJson(msg);
      print("listen message ${message.room}");
      if (!mounted) return;
      setState(() {
        widget.roomModel.forEach((element) {
          if (element.id == message.room) {
            element.lastMessage = message;
            element.updatedAt = message.updatedAt;
            element.unread++;
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("Socket ${socket.toString()}");
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;

    ChatViewModel chatViewModel = ChatViewModel();
    // homeViewModel.getRooms();

    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: (widget.roomModel.length > 0)
            ? ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: widget.roomModel.length,
                itemBuilder: (BuildContext context, int index) {
                  final RoomModel room = widget.roomModel[index];

                  // time = homeViewModel.readTimestamp(room.updatedAt);
                  return GestureDetector(
                    onTap: () async {
                      UserPreferences userPref = new UserPreferences();
                      UserModel userPrefModel = await userPref.getUser();
                      await chatViewModel.getMessage(room.id);
                      // print(userPrefModel.id.toString());
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Chat(
                                  messages: chatViewModel.messages,
                                  roomModel: room,
                                  userModel: userPrefModel,
                                  socket: socket,
                                )),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 24.0,
                                    child: Icon(
                                      (room.type == 0)
                                          ? Icons.person
                                          : Icons.group,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  (room.isActive == 0)
                                      ? Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            height: 15,
                                            width: 15,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor,
                                                    width: 1.5)),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    room.users[0].username.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    width: screenWidth * 0.45,
                                    child: Text(
                                      // (newMessages.length > 0)
                                      //     ? newMessages[newMessages.length - 1]
                                      //         .content
                                      // :
                                      // room.lastMessage!.content.toString(),
                                      (room.lastMessage != null)
                                          ? room.lastMessage!.content.toString()
                                          : "",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Column(children: [
                            Text(
                              Utils.readTimestamp(room.updatedAt),
                              style: TextStyle(
                                  color: (room.unread > 0)
                                      ? Colors.green
                                      : Colors.grey),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            if (room.unread > 0)
                              Container(
                                width: 20,
                                height: 20,
                                child: Center(
                                  child: Text(
                                    room.unread.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    // borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: Colors.green),
                              ),
                          ]),
                        ],
                      ),
                    ),
                  );
                })
            : Container(),
      ),
    );
  }
}
