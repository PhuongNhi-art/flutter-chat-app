import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/src/config/app_colors.dart';
import 'package:helloworld/src/pages/models/message_model.dart';

class DateCard extends StatelessWidget {
  final String date;
  DateCard({Key? key, required this.date}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
        child:
            Text(date, style: TextStyle(fontSize: 14, color: colorDarkGray)));
  }
}
