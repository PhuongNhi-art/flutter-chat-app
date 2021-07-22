import 'package:flutter/foundation.dart';

class MessageModel {
  String id;
  int index;
  String from;
  String room;

  int type; //TEXT: 0,PICTURE: 1,AUDIO: 2,VIDEO: 3,
  int eventType; //MESSAGE: 0,SERVER: 1,TYPING: 2
  String content;
  int createdAt;
  int updatedAt;
  MessageModel(
      {required this.id,
      required this.index,
      required this.from,
      required this.room,
      required this.type,
      required this.eventType,
      required this.content,
      required this.createdAt,
      required this.updatedAt});
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        id: json['_id'].toString(),
        index: json['index'],
        from: json['from'].toString(),
        room: json['room'].toString(),
        type: json['type'],
        eventType: json['eventType'],
        content: json['content'],
        createdAt: json['createAt'],
        updatedAt: json['updatedAt']);
  }
}
