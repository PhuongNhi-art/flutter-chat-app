import 'package:floor/floor.dart';

@entity
class MessageModel1 {
  @primaryKey
  final int id;
  final String type;
  final String message;
  final String time;
  MessageModel1(this.id, this.type, this.message, this.time);
}
