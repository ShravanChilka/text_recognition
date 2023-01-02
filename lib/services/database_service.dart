import 'package:hive_flutter/hive_flutter.dart';
import 'package:text_recognition/models/saves_model.dart';
import 'package:text_recognition/utils/utils.dart';

abstract class DatabaseService {
  Future<void> init();
  Future<List<SavesModel>?> getSaves();
  Future<void> closeBox();
  Future<void> setSaves({required List<SavesModel>? savesModelList});
}

class DatabaseServiceImpl implements DatabaseService {
  late Box savesBox;

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    registerAdapters();
    await openBox();
  }

  void registerAdapters() {
    Hive.registerAdapter(SavesModelAdapter());
  }

  Future<void> openBox() async {
    savesBox = await Hive.openBox(DatabaseBoxKey.savesBoxKey);
  }

  @override
  Future<List<SavesModel>?> getSaves() async {
    return await savesBox.get(DatabaseKey.savesKey);
  }

  @override
  Future<void> setSaves({required List<SavesModel>? savesModelList}) async {
    await savesBox.put(DatabaseKey.savesKey, savesModelList);
  }

  @override
  Future<void> closeBox() async {
    await savesBox.close();
  }
}
