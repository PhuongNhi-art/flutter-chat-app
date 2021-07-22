import 'package:flutter/material.dart';
import 'dart:async';

import 'package:helloworld/src/config/app_colors.dart';
import 'package:helloworld/src/pages/models/contact_model.dart';
import 'package:helloworld/src/pages/screens/selectContact/button_card.dart';
import 'package:helloworld/src/pages/screens/selectContact/contact_card.dart';
import 'package:helloworld/src/pages/screens/selectContact/create_group.dart';

class SelectContact extends StatefulWidget {
  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  List contact = [
    ContactModel(name: "Dev", status: "Dev in High School"),
    ContactModel(name: "Test", status: "Test in High School"),
    ContactModel(name: "Game", status: "Test in High School"),
    ContactModel(name: "Game", status: "Test in High School"),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorDarkGreen,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Contact",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              "256 contact",
              style: TextStyle(fontSize: 13, color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          PopupMenuButton<String>(
              padding: EdgeInsets.all(0),
              color: Colors.white,
              onSelected: (value) {
                print(value);
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text("Invite a friend"),
                    value: "Invite a friend",
                  ),
                  PopupMenuItem(
                    child: Text("Contacts"),
                    value: "Contacts",
                  ),
                  PopupMenuItem(
                    child: Text("Refresh"),
                    value: "Refresh",
                  ),
                  PopupMenuItem(
                    child: Text("Help"),
                    value: "Help",
                  ),
                ];
              }),
        ],
      ),
      body: ListView.builder(
        itemCount: contact.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => CreateGroup()));
                },
                child: ButtonCard(icon: Icons.group, name: "New group"));
          } else if (index == 1) {
            return ButtonCard(icon: Icons.person, name: "New contact");
          } else
            return ContactCard(contactModel: contact[index]);
        },
      ),
    );
  }
}
