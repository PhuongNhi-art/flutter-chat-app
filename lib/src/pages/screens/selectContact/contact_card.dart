import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helloworld/src/pages/models/contact_model.dart';

class ContactCard extends StatelessWidget {
  ContactModel contactModel;
  ContactCard({Key? key, required this.contactModel}) : super(key: key);
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
          contactModel.select
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
      title: Text(contactModel.name,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      subtitle: Text(
        contactModel.status,
        style: TextStyle(fontSize: 13),
      ),
    );
  }
}
