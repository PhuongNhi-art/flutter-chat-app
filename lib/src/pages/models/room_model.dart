import 'package:helloworld/src/pages/models/user_model.dart';

class RoomModel {
  String id;
  String name;
  UserModel admin;
  String lastMessage;
  List<UserModel> users;
  int type;
  int unread;
  int isActive;
  int createdAt;
  int updatedAt;
  RoomModel({
    required this.id,
    required this.name,
    required this.admin,
    required this.users,
    required this.lastMessage,
    required this.type,
    required this.unread,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['_id'],
      admin: UserModel.fromJson(json['admin']),
      //List<UserModel>.from(json['users'])
      users: (json['users'] as List)
          .map((data) => UserModel.fromJson(data))
          .toList(),
      name: json['name'],
      lastMessage: json['lastMessage'],
      type: json['type'],
      isActive: json['isActive'],
      unread: json['unread'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
