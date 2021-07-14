import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/src/pages/models/chat_temp.dart';
import 'package:helloworld/src/pages/models/user_model.dart';

import 'package:helloworld/src/pages/screens/chat/chat_view.dart';
import 'package:helloworld/src/pages/screens/home/home_viewmodel.dart';
import 'package:helloworld/src/share_preference/user_preference.dart';

class RecentChat extends StatelessWidget {
  final List<ChatTempModel> chatModel;
  RecentChat({Key? key, required this.chatModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    HomeViewModel homeViewModel = HomeViewModel();
    homeViewModel.getUserWithLastMsg();
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: chatModel.length,
            itemBuilder: (BuildContext context, int index) {
              // final ChatModel chat = chatDatas[index];
              // final ChatTempModel chat = homeViewModel.usersTemp[index];
              final ChatTempModel chat = chatModel[index];
              return GestureDetector(
                onTap: () async {
                  UserPreferences userPref = new UserPreferences();
                  UserModel userPrefModel = await userPref.getUser();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Chat(
                              chatModel: chat,
                              userModel: userPrefModel,
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
                                backgroundImage: AssetImage(chat.image),
                              ),
                              if (chat.isActive)
                                Positioned(
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
                            ],
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chat.username,
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
                                  "",
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
                          chat.time,
                          style: TextStyle(
                              color: (chat.unread > 0)
                                  ? Colors.green
                                  : Colors.grey),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        if (chat.unread > 0)
                          Container(
                            width: 20,
                            height: 20,
                            child: Center(
                              child: Text(
                                '1',
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
            }),
      ),
    );
  }
}
