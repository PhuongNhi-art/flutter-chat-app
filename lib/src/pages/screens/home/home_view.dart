import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:helloworld/src/config/app_colors.dart';
import 'package:helloworld/src/pages/models/chat_model.dart';
import 'package:helloworld/src/pages/models/chat_temp.dart';
import 'package:helloworld/src/pages/screens/home/home_viewmodel.dart';
import 'package:helloworld/src/pages/screens/home/home_viewmodel.dart';
import 'package:helloworld/src/pages/screens/home/recent_chat_app.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
  final List<ChatTempModel> chatModel;
  Home({Key? key, required this.chatModel}) : super(key: key);
}

class _HomeState extends State<Home> {
  // final homeViewModel = new HomeViewModel();
  // homeViewModel.getUserWithLastMsg();
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text('WhatsApp', style: TextStyle(color: Colors.white));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final homeViewModel = Provider.of<HomeViewModel>(context);
  }

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
                RecentChat(chatModel: widget.chatModel),
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
          onPressed: () {},
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
