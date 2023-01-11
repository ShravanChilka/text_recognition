import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:text_recognition/models/database.dart';
import 'package:text_recognition/models/saves_model.dart';
import 'package:text_recognition/utils/utils.dart';

abstract class DatabaseService {
  Future<void> init();
  Future<List<SavesModel>> getSaves();
  Future<void> closeBox();
  Future<void> setSaves({required List<SavesModel> savesModelList});
}

class DatabaseServiceImpl implements DatabaseService {
  late Box<Database> db;

  DatabaseServiceImpl._sharedInstance();
  static final DatabaseServiceImpl _instance =
      DatabaseServiceImpl._sharedInstance();
  factory DatabaseServiceImpl() => _instance;

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    registerAdapters();
    await openBox();
  }

  void registerAdapters() {
    Hive.registerAdapter(SavesModelAdapter());
    Hive.registerAdapter(DatabaseAdapter());
  }

  Future<void> openBox() async {
    db = await Hive.openBox(DatabaseBoxKey.savesBoxKey);
  }

  @override
  Future<List<SavesModel>> getSaves() async {
    final data = db.get(DatabaseKey.savesKey);
    if (data != null) {
      return data.savesModelList;
    } else {
      return [];
    }
  }

  @override
  Future<void> setSaves({required List<SavesModel> savesModelList}) async {
    await db.put(
        DatabaseKey.savesKey, Database(savesModelList: savesModelList));
  }

  @override
  Future<void> closeBox() async {
    await db.close();
  }
}
