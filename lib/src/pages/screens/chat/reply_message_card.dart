import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/src/config/app_colors.dart';
import 'package:helloworld/src/pages/models/message_model.dart';
import 'package:helloworld/src/pages/models/message_model1.dart';
import 'package:helloworld/src/utils/utils.dart';

class ReplyMessageCard extends StatelessWidget {
  final MessageModel messageModel;
  ReplyMessageCard({Key? key, required this.messageModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    String time = Utils.readHourAndMinute(messageModel.updatedAt);
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
                    messageModel.content,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 10,
                  child: Row(
                    children: [
                      Text(
                        time,
                        style: TextStyle(fontSize: 12, color: colorDarkGray),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.done_all,
                        size: 12,
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
