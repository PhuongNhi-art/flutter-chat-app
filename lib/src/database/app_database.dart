// database.dart

// required package imports

import 'dart:async';

import 'package:floor/floor.dart';
import 'package:helloworld/src/dao/message_dao.dart';
import 'package:helloworld/src/pages/models/message_model1.dart';

import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';
// the generated code will be there

@Database(version: 1, entities: [MessageModel1])
abstract class AppDatabase extends FloorDatabase {
  MessageDao get messageDao;
}
