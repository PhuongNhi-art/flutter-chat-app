import 'package:flutter/material.dart';
import 'dart:async';

import 'package:helloworld/src/config/app_colors.dart';
import 'package:helloworld/src/pages/models/contact_model.dart';
import 'package:helloworld/src/pages/models/user_model.dart';
import 'package:helloworld/src/pages/screens/selectContact/avatar_card.dart';
import 'package:helloworld/src/pages/screens/selectContact/button_card.dart';
import 'package:helloworld/src/pages/screens/selectContact/check_group.dart';
import 'package:helloworld/src/pages/screens/selectContact/contact_card.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
  final List<UserModel> usersList;
  CreateGroup({Key? key, required this.usersList}) : super(key: key);
}

class _CreateGroupState extends State<CreateGroup> {
  List<UserModel> groups = [];
  // List contact = [
  //   ContactModel(name: "Dev", status: "Dev in High School"),
  //   ContactModel(name: "Test", status: "Test in High School"),
  //   ContactModel(name: "Game", status: "Test in High School"),
  //   ContactModel(name: "Game", status: "Test in High School"),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorDarkGreen,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Group",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              "Add participants",
              style: TextStyle(fontSize: 13, color: Colors.white),
            ),
          ],
        ),
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(
          //     Icons.search,
          //     color: Colors.white,
          //   ),
          // ),
          // Text("Tiếp"),
          Center(
            child: (groups.length >= 2)
                ? TextButton(
                    onPressed: () {
                      print(groups.length.toString());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => CheckGroup(
                                    groups: groups,
                                  )));
                    },
                    child: Text(
                      "NEXT",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  )
                : Container(),
          ),
        ],
      ),
      body: Stack(children: [
        ListView.builder(
          itemCount: widget.usersList.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                height: groups.length > 0 ? 90 : 10,
              );
            }
            return InkWell(
              child: ContactCard(
                userModel: widget.usersList[index - 1],
              ),
              onTap: () {
                // if (contact[index].select == false) {
                //   setState(() {
                //     contact[index].select = true;
                //     groups.add(contact[index]);
                //   });
                // } else {
                //   setState(() {
                //     contact[index].select = false;
                //     groups.remove(contact[index]);
                //   });
                // }
              },
            );
          },
        ),
        groups.length > 0
            ? Column(
                children: [
                  Container(
                    height: 75,
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: widget.usersList.length,
                      itemBuilder: (context, index) {
                        // if (contact[index].select == true) {
                        //   return InkWell(
                        //     onTap: () {
                        //       setState(() {
                        //         contact[index].select = false;
                        //         groups.remove(contact[index]);
                        //       });
                        //     },
                        //     child: AvatarCard(
                        //       contactModel: contact[index],
                        //     ),
                        //   );
                        // } else
                        return Container();
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                ],
              )
            : Container(),
      ]),
    );
  }
}
