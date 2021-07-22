import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/src/pages/models/contact_model.dart';

class AvatarCard extends StatelessWidget {
  ContactModel contactModel;
  AvatarCard({Key? key, required this.contactModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Column(
        children: [
          Stack(children: [
            CircleAvatar(
                radius: 23,
                child: Icon(
                  Icons.person,
                  size: 20,
                  color: Colors.white,
                ),
                backgroundColor: Colors.blueGrey[200]),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 11,
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            )
          ]),
          SizedBox(
            height: 2,
          ),
          Text(
            contactModel.name,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
