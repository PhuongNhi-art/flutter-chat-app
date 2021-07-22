import 'dart:io';

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:helloworld/src/pages/models/user_model.dart';

class SocketUtils {
  static String _serverIP =
      Platform.isIOS ? "http://localhost" : "http://192.168.1.244";
  static const int SERVER_PORT = 8081;
  static String _connectUrl = '$_serverIP:$SERVER_PORT';

  static const CONNECTION = "connection";
  static const JOIN_ROOM = "join";
  static const DISCONNECT = "disconnect";
  static const MESSAGE_DETECTION = "message detection";
  static const CONNECT_USER = "connect user";
  static const ON_TYPING = "on typing";
  static const CHAT_MESSAGE = "chat message";
  late IO.Socket socket;
  void connect() {
    socket = IO.io(_connectUrl, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
      // "user":
    });
    socket.connect();
  }
}
