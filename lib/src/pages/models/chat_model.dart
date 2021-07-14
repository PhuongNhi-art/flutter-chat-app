class ChatModel {
  final String id;
  final String name, lastMessage, image, time;
  final int unread;
  final bool isActive;

  ChatModel(
      {required this.id,
      required this.name,
      required this.lastMessage,
      required this.image,
      required this.time,
      required this.unread,
      required this.isActive});
}

List chatDatas = [
  ChatModel(
      id: "1",
      name: "Jenny",
      lastMessage: "Hope you dong ",
      image: "assets/images/parrot.png",
      time: "3m ago",
      unread: 1,
      isActive: true),
  ChatModel(
      id: "2",
      name: "Horware",
      lastMessage: "Hope you dong ",
      image: "assets/images/group.png",
      time: "3m ago",
      unread: 0,
      isActive: false),
];
