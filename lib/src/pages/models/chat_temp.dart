class ChatTempModel {
  final String id;
  final String username, email;
  final String time = "3m ago";
  final String image = "assets/images/parrot.png";
  final int unread = 1;
  final bool isActive = true;
  ChatTempModel({
    required this.id,
    required this.username,
    required this.email,
  });
  factory ChatTempModel.fromJson(Map<String, dynamic> json) {
    return ChatTempModel(
      id: json['_id'],
      username: json['username'],

      // password: json['password'],
      email: json['email'],
      // createAt: json['createAt'],
    );
  }
}

// List chatDatas = [
//   ChatModel(
//       id: "1",
//       name: "Jenny",
//       lastMessage: "Hope you dong ",
//       image: "assets/images/parrot.png",
//       time: "3m ago",
//       unread: 1,
//       isActive: true),
//   ChatModel(
//       id: "2",
//       name: "Horware",
//       lastMessage: "Hope you dong ",
//       image: "assets/images/group.png",
//       time: "3m ago",
//       unread: 0,
//       isActive: false),
// ];
