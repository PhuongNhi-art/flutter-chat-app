import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:helloworld/src/config/app_colors.dart';
import 'package:helloworld/src/config/constants.dart';
import 'package:helloworld/src/pages/models/message_model.dart';
import 'package:helloworld/src/pages/models/room_model.dart';
import 'package:helloworld/src/pages/models/user_model.dart';

import 'package:helloworld/src/pages/screens/home/recent_chat_app.dart';
import 'package:helloworld/src/pages/screens/selectContact/selectcontact_view.dart';
import 'package:helloworld/src/share_preference/user_preference.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
  final List<RoomModel> roomModel;
  Home({Key? key, required this.roomModel}) : super(key: key);
}

class _HomeState extends State<Home> {
  Icon cusIcon = Icon(Icons.search);
  List<MessageModel> newMessages = [];
  int haveNewMsg = 0;
  // IO.Socket socket = IO.io("http://192.168.1.244:8081", <String, dynamic>{
  //   "transports": ["websocket"],
  //   "autoConnect": false,
  //   // "query": widget.userModel.toString(),
  // });
  Widget cusSearchBar = Text('WhatsApp', style: TextStyle(color: Colors.white));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // connect();
  }

  // Future<void> connect() async {
  //   UserPreferences userPref = new UserPreferences();
  //   UserModel userPrefModel = await userPref.getUser();

  //   socket.connect();
  //   socket.onConnect((data) {
  //     print("Connected");
  //     socket.emit(Constants.SIGNIN, userPrefModel.id);
  //     // socket.emit(Constants.JOIN_ROOM, userPrefModel.id);
  //   });
  //   socket.on(Constants.MESSAGE, (msg) {
  //     // print(msg);
  //     MessageModel message = MessageModel.fromJson(msg);
  //     print("listen message ${msg}");
  //     newMessages.add(message);
  //     haveNewMsg++;
  //     // print(haveNewMsg.to)

  //     // print("message ${messageModel.content.toString()}");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    final List<String> entries = <String>['A', 'B', 'C'];
    final List<int> colorCodes = <int>[600, 500, 100];

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    if (this.cusIcon.icon == Icons.search) {
                      print(widget.roomModel.length);
                      this.cusIcon = Icon(Icons.cancel);
                      this.cusSearchBar = TextField(
                        textInputAction: TextInputAction.go,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Search"),
                      );
                    } else {
                      this.cusIcon = Icon(Icons.search);
                      this.cusSearchBar = Text('WhatsApp');
                    }
                  });
                },
                icon: cusIcon),
            IconButton(
                color: Colors.white,
                onPressed: () {},
                icon: Icon(Icons.more_vert)),
          ],
          title: cusSearchBar,
          backgroundColor: colorDarkGreen,
          bottom: TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(
                text: 'CHATS',
              ),
              Tab(
                text: 'STATUS',
              ),
              Tab(
                text: 'CALL',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Column(
              children: [
                RecentChat(
                  roomModel: widget.roomModel,
                  // socket: socket,
                  // haveNewMsg: haveNewMsg,
                ),
              ],
            ),
            // Center(
            //   child: Text("It's cloudy here"),
            // ),

            Center(
              child: Text("It's sunny here"),
            ),
            Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => SelectContact()));
          },
          child: Text(
            '+',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          backgroundColor: colorDarkGreen,
        ),
      ),
    );
  }
}
