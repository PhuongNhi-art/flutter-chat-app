import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/src/config/app_colors.dart';
import 'package:helloworld/src/pages/models/message_model.dart';

class TextingMessageCard extends StatelessWidget {
  // final MessageModel messageModel;
  // TextingMessageCard({Key? key, required this.messageModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: screenWidth - 45),
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colors.white,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 60, 20),
                  child: Text(
                    "...",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
