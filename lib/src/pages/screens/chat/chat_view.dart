import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/src/config/app_colors.dart';
import 'package:helloworld/src/config/constants.dart';
import 'package:helloworld/src/database/app_database.dart';
import 'package:helloworld/src/pages/models/message_model.dart';

import 'package:helloworld/src/pages/models/message_model1.dart';
import 'package:helloworld/src/pages/models/room_model.dart';
import 'package:helloworld/src/pages/models/user_model.dart';
import 'package:helloworld/src/pages/screens/chat/date_card.dart';
import 'package:helloworld/src/pages/screens/chat/own_message_card.dart';
import 'package:helloworld/src/pages/screens/chat/reply_message_card.dart';
import 'package:helloworld/src/pages/screens/chat/texting_message.card.dart';
import 'package:helloworld/src/share_preference/user_preference.dart';
import 'package:helloworld/src/utils/utils.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
  // final ChatModel chatModel;
  final RoomModel roomModel;
  final UserModel userModel;
  final IO.Socket socket;
  final List<MessageModel> messages;
  Chat(
      {Key? key,
      required this.messages,
      required this.roomModel,
      required this.userModel,
      required this.socket})
      : super(key: key);
}

class _ChatState extends State<Chat> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  bool _isVisible = false;
  bool _texting = false;
  // ChatViewModel chatViewModel = new ChatViewModel();

  // late IO.Socket socket;
  UserPreferences userPref = new UserPreferences();
  // List<MessageModel1> messages = [];
  List<MessageModel> messages = [];
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect(widget.socket);
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        if (!mounted) return;
        setState(() {
          show = false;
        });
      }
    });
  }

  List<String> user(List<String> user, String userId) {
    user.removeWhere((element) => element == userId);
    return user;
  }

  Future<void> connect(IO.Socket socket) async {
    print("userPrefModel ${widget.userModel.id}");
    // socket = IO.io("http://192.168.1.244:8081", <String, dynamic>{
    //   "transports": ["websocket"],
    //   "autoConnect": false,
    //   // "query": widget.userModel.toString(),
    // });
    // socket.connect();
    // socket.onConnect((data) {
    //   print("Connected");
    //   // socket.emit(Constants.SIGNIN, widget.userModel.id);

    // });
    socket.emit(Constants.JOIN_ROOM, widget.roomModel.id);
    socket.on(Constants.MESSAGE, (msg) {
      // print(msg);
      MessageModel messageModel = MessageModel.fromJson(msg);
      if (!mounted) return;
      setState(() {
        _texting = false;
        messages.add(messageModel);
      });
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      // messages.add(messageModel);
      print(messageModel.content.toString());
    });
    socket.on(Constants.ON_TYPING, (msg) {
      if (msg['user'].toString() != widget.userModel.id.toString()) {
        setState(() {
          _texting = msg['content'].toString() == 'true' ? true : false;
        });
      }
    });
  }

  Future<void> sendMessage(UserModel userModel, RoomModel roomModel, int type,
      int eventType, String content) async {
    widget.socket.emit(Constants.MESSAGE, {
      "from": userModel.id.toString(),
      "room": roomModel.id.toString(),
      "type": type,
      "eventType": eventType,
      "content": content
    });
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  Future<void> sendTextingMessage(
      String message, UserModel userModel, RoomModel roomModel) async {
    widget.socket.emit(Constants.ON_TYPING,
        {"content": message, "room": roomModel.id, "user": userModel.id});
  }

  // Future<void> saveMessage(String type, message) async {
  //   MessageModel1 messageModel =
  //       MessageModel1(1, type, message, DateTime.now().toString());
  //   print(
  //       '${messageModel.id}${messageModel.type}${messageModel.message}${messageModel.time}');
  //   final database =
  //       await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  //   final messageDao = database.messageDao;
  //   // final person = Person(1, 'Frank');

  //   await messageDao.insertPerson(messageModel);
  //   final result = await messageDao.findMessageById(1);
  //   // print(result);
  // }

  @override
  Widget build(BuildContext context) {
    messages = widget.messages;
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    // print(user(widget.roomModel.users, widget.userModel.id.toString())[0]
    //     .toString());

    return Scaffold(
      backgroundColor: colorLightGreen,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.08),
        child: AppBar(
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
              // this.dispose();
            },
          ),
          actions: <Widget>[
            IconButton(
              color: Colors.white,
              onPressed: () {},
              icon: Icon(Icons.video_call),
            ),
            IconButton(
              color: Colors.white,
              onPressed: () {},
              icon: Icon(Icons.call),
            ),
            PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(0),
                onSelected: (value) {
                  print(value);
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: Text("View Contact"),
                      value: "View Contact",
                    ),
                    PopupMenuItem(
                      child: Text("Media, links, and docs"),
                      value: "Media, links, and docs",
                    ),
                    PopupMenuItem(
                      child: Text("Whatsapp Web"),
                      value: "Whatsapp Web",
                    ),
                    PopupMenuItem(
                      child: Text("Search"),
                      value: "Search",
                    ),
                    PopupMenuItem(
                      child: Text("Mute Notification"),
                      value: "Mute Notification",
                    ),
                    PopupMenuItem(
                      child: Text("Wallpaper"),
                      value: "Wallpaper",
                    ),
                  ];
                }),
          ],
          backgroundColor: colorDarkGreen,
          title: Container(
            child: Row(
              children: [
                CircleAvatar(
                  radius: (screenWidth < 768)
                      ? screenWidth * 0.05
                      : screenWidth * 0.02,
                  child: Icon((widget.roomModel.type == 0)
                      ? Icons.person
                      : Icons.group),
                ),
                SizedBox(
                  width: (screenWidth < 768)
                      ? screenWidth * 0.05
                      : screenWidth * 0.01,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.roomModel.users[0].username.toString(),
                      style: TextStyle(
                          fontSize: (screenWidth < 768)
                              ? screenWidth * 0.045
                              : screenWidth * 0.01,
                          color: Colors.white),
                    ),
                    Text(
                      (widget.roomModel.type == 0) ? "3m ago" : "",
                      style: TextStyle(
                          fontSize: (screenWidth < 768)
                              ? screenWidth * 0.045
                              : screenWidth * 0.01,
                          color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: WillPopScope(
          child: Column(
            children: [
              // Visibility(
              //   visible: _isVisible,
              //   child: Text("Thursday",
              //       style: TextStyle(fontSize: 13, color: colorDarkGray)),
              // ),
              Expanded(
                // height: screenHeight * 0.8,
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: messages.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      String time = Utils.readDate(messages[index].updatedAt);

                      if (messages[index].from != widget.userModel.id) {
                        //Reply
                        if (index == 0) {
                          return Column(
                            children: [
                              DateCard(date: time),
                              ReplyMessageCard(
                                messageModel: messages[index],
                              ),
                            ],
                          );
                        } else if (time !=
                            Utils.readDate(messages[index - 1].updatedAt)) {
                          return Column(
                            children: [
                              DateCard(date: time),
                              ReplyMessageCard(
                                messageModel: messages[index],
                              ),
                            ],
                          );
                        } else {
                          return ReplyMessageCard(
                            messageModel: messages[index],
                          );
                        }
                      } else //own
                      {
                        if (index == 0) {
                          return Column(
                            children: [
                              DateCard(date: time),
                              OwnMessageCard(
                                messageModel: messages[index],
                              ),
                            ],
                          );
                        } else if (time !=
                            Utils.readDate(messages[index - 1].updatedAt)) {
                          return Column(
                            children: [
                              DateCard(date: time),
                              OwnMessageCard(
                                messageModel: messages[index],
                              ),
                            ],
                          );
                        } else {
                          return OwnMessageCard(
                            messageModel: messages[index],
                          );
                        }
                      }
                    }),
              ),
              Visibility(
                child: TextingMessageCard(),
                visible: _texting,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(1, 1, 1, 6),
                          width: screenWidth * 0.85,
                          child: Card(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            shape: RoundedRectangleBorder(
                              borderRadius: (screenWidth < 768)
                                  ? BorderRadius.circular(screenWidth * 0.5)
                                  : BorderRadius.circular(screenWidth * 0.1),
                            ),
                            child: TextFormField(
                              focusNode: focusNode,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              controller: messageController,
                              onChanged: (value) async {
                                if (value.length > 0) {
                                  sendTextingMessage("true", widget.userModel,
                                      widget.roomModel);
                                  setState(() {
                                    sendButton = true;
                                  });
                                } else {
                                  sendTextingMessage("false", widget.userModel,
                                      widget.roomModel);
                                  setState(() {
                                    sendButton = false;
                                  });
                                }
                                // print(_texting.toString());
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type a message",
                                hintStyle: (screenWidth < 768)
                                    ? TextStyle(fontSize: screenWidth * 0.04)
                                    : TextStyle(fontSize: screenWidth * 0.01),
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      focusNode.unfocus();
                                      focusNode.canRequestFocus = false;
                                      show = !show;
                                    });
                                  },
                                  icon: Icon(Icons.emoji_emotions),
                                ),
                                contentPadding:
                                    EdgeInsets.all(screenWidth * 0.01),
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.attach_file)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.camera_alt))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 1),
                            child: CircleAvatar(
                              backgroundColor: colorDarkGreen,
                              maxRadius: (screenWidth < 768)
                                  ? screenWidth * 0.06
                                  : screenWidth * 0.02,
                              // minRadius: 10,
                              // radius: screenWidth * 0.05,
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  sendButton ? Icons.send : Icons.mic,
                                  size: (screenWidth < 768)
                                      ? screenWidth * 0.05
                                      : screenWidth * 0.02,
                                ),
                                onPressed: () async {
                                  if (sendButton) {
                                    scrollController.animateTo(
                                        scrollController
                                            .position.maxScrollExtent,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeOut);
                                    // widget.roomModel.users
                                    //     .forEach((element) async {
                                    // await sendMessage(messageController.text,
                                    //     widget.roomModel.users);
                                    // await saveMessage(
                                    //     "source", messageController.text);
                                    // });
                                    await sendMessage(
                                        widget.userModel,
                                        widget.roomModel,
                                        Constants.TYPE_MESSAGE,
                                        Constants.EVENT_TYPE_MESSAGE,
                                        messageController.text);

                                    messageController.clear();
                                    setState(() {
                                      sendButton = false;
                                    });
                                  }
                                },
                              ),
                            )),
                      ],
                    ),
                    show ? emojiSelect() : Container(),
                  ],
                ),
              )
            ],
          ),
          onWillPop: () {
            if (show) {
              setState(() {
                show = false;
              });
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
        ),
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
      onEmojiSelected: (emoji, category) {
        messageController.text = messageController.text + emoji.emoji;
        setState(() {
          sendButton = true;
        });
      },
      rows: 4,
      columns: 7,
    );
  }
}
