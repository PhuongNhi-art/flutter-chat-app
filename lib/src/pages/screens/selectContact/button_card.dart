import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonCard extends StatelessWidget {
  IconData icon;
  String name;

  ButtonCard({Key? key, required this.name, required this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          radius: 23,
          child: Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
          backgroundColor: Colors.blueGrey),
      title: Text(name,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
    );
  }
}
