import 'package:floor/floor.dart';

import 'package:helloworld/src/pages/models/message_model1.dart';

@dao
abstract class MessageDao {
  @Query('SELECT * FROM message')
  Future<List<MessageModel1>> findAllMessages();

  @Query('SELECT * FROM messageWHERE id = :id')
  Stream<MessageModel1?> findMessageById(int id);

  @insert
  Future<void> insertPerson(MessageModel1 messageModel);
}

// class MessageDAO {
//   static final MessageDAO instance = MessageDAO._init();
//   static Database? _database;
// }
