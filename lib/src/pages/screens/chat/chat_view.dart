import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/src/config/app_colors.dart';
import 'package:helloworld/src/pages/models/chat_model.dart';
import 'package:helloworld/src/pages/models/chat_temp.dart';
import 'package:helloworld/src/pages/models/message_model.dart';
import 'package:helloworld/src/pages/models/user_model.dart';
import 'package:helloworld/src/pages/screens/chat/chat_viewmodel.dart';
import 'package:helloworld/src/pages/screens/chat/date_card.dart';
import 'package:helloworld/src/pages/screens/chat/own_message_card.dart';
import 'package:helloworld/src/pages/screens/chat/reply_message_card.dart';
import 'package:helloworld/src/pages/screens/chat/texting_message.card.dart';
import 'package:helloworld/src/share_preference/user_preference.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
  // final ChatModel chatModel;
  final ChatTempModel chatModel;
  final UserModel userModel;
  Chat({Key? key, required this.chatModel, required this.userModel})
      : super(key: key);
}

class _ChatState extends State<Chat> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  bool _isVisible = false;
  bool _texting = false;
  // ChatViewModel chatViewModel = new ChatViewModel();

  late IO.Socket socket;
  UserPreferences userPref = new UserPreferences();
  List<MessageModel> messages = [];

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  Future<void> connect() async {
    // UserPreferences userPref = new UserPreferences();
    // UserModel userPrefModel = await userPref.getUser();
    print("userPrefModel ${widget.userModel.id}");
    socket = IO.io("http://192.168.1.244:8081", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("signin", widget.userModel.id);
    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {
        print("destination" + msg);
        setState(() {
          _texting = false;
        });
        setMessage("destination", msg);
      });
      socket.on("texting", (msg) {
        print("texting" + msg);
        // setState(() {
        //   _texting = true;
        // });
        setMessage("texting", msg);

        setState(() {
          _texting = msg == "true";
        });
      });
    });
    // print(socket.connected);
  }

  Future<void> sendTextingMessage(String message, String targetId) async {
    // UserPreferences userPref = new UserPreferences();
    // UserModel userPrefModel = await userPref.getUser();
    print("targetId ${targetId}");
    String sourceId = widget.userModel.id.toString();
    print("Source id ${sourceId}");
    // setMessage("source", message);
    socket.emit("texting",
        {"texting": message, "sourceId": sourceId, "targetId": targetId});
  }

  Future<void> sendMessage(String message, String targetId) async {
    // UserPreferences userPref = new UserPreferences();
    // UserModel userPrefModel = await userPref.getUser();
    print("targetId ${targetId}");
    String sourceId = widget.userModel.id.toString();
    print("Source id ${sourceId}");
    setMessage("source", message);
    socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  void setMessage(String type, String message) {
    setState(() {
      MessageModel messageModel = MessageModel(
          message: message, time: DateTime.now().toString(), type: type);
      // if (messages[messages.length - 1].time.toString() != messageModel.time) {}
      print(DateTime.now().toString().substring(0, 10));
      messages.add(messageModel);
    });
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    // TextEditingController messageController = TextEditingController();

    // final chatViewModel = Provider.of<ChatViewModel>(context);
    // chatViewModel.connect();
    connect();
    return Scaffold(
      backgroundColor: colorLightGreen,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.08),
        child: AppBar(
          // automaticallyImplyLeading: false,
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
            IconButton(
                color: Colors.white,
                onPressed: () {},
                icon: Icon(Icons.more_vert)),
          ],
          backgroundColor: colorDarkGreen,
          title: Container(
            child: Row(
              children: [
                CircleAvatar(
                  radius: (screenWidth < 768)
                      ? screenWidth * 0.05
                      : screenWidth * 0.02,
                  backgroundImage: AssetImage(widget.chatModel.image),
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
                      widget.chatModel.username,
                      style: TextStyle(
                          fontSize: (screenWidth < 768)
                              ? screenWidth * 0.045
                              : screenWidth * 0.01,
                          color: Colors.white),
                    ),
                    Text(
                      chatDatas[1].time,
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
                      if (messages[index].type == "texting") {
                        return Container();
                      } else if (messages[index].type == "source") {
                        if (index == 0) {
                          return Column(
                            children: [
                              DateCard(
                                  date: messages[index].time.substring(0, 10)),
                              OwnMessageCard(
                                messageModel: messages[index],
                              ),
                            ],
                          );
                        } else if (messages[index].time.substring(0, 10) !=
                            messages[index - 1].time.substring(0, 10)) {
                          return Column(
                            children: [
                              DateCard(
                                  date: messages[index].time.substring(0, 10)),
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
                      } else {
                        if (index == 0) {
                          return Column(
                            children: [
                              DateCard(
                                  date: messages[index].time.substring(0, 10)),
                              ReplyMessageCard(
                                messageModel: messages[index],
                              ),
                            ],
                          );
                        } else if (messages[index].time.substring(0, 10) !=
                            messages[index - 1].time.substring(0, 10)) {
                          return Column(
                            children: [
                              DateCard(
                                  date: messages[index].time.substring(0, 10)),
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
                                  sendTextingMessage(
                                      "true", widget.chatModel.id);
                                  setState(() {
                                    sendButton = true;
                                  });
                                } else {
                                  sendTextingMessage(
                                      "false", widget.chatModel.id);
                                  setState(() {
                                    sendButton = false;
                                  });
                                }
                                print(_texting.toString());
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
                                    await sendMessage(messageController.text,
                                        widget.chatModel.id);

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
