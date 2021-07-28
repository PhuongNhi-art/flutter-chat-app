import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helloworld/src/pages/models/contact_model.dart';
import 'package:helloworld/src/pages/models/user_model.dart';

class ContactCard extends StatelessWidget {
  UserModel userModel;
  bool select = false;
  ContactCard({Key? key, required this.userModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 53,
        width: 50,
        child: Stack(children: [
          CircleAvatar(
              radius: 23,
              child: Icon(
                Icons.person,
                size: 20,
                color: Colors.white,
              ),
              backgroundColor: Colors.blueGrey[200]),
          select
              ? Positioned(
                  bottom: 4,
                  right: 5,
                  child: CircleAvatar(
                    backgroundColor: Colors.teal,
                    radius: 11,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                )
              : Container(),
        ]),
      ),
      title: Text(userModel.username.toString(),
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      subtitle: Text(
        "@" + userModel.email.toString(),
        style: TextStyle(fontSize: 13),
      ),
    );
  }
}
