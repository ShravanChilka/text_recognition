import 'package:hive/hive.dart';
import 'package:text_recognition/models/saves_model.dart';

part 'database.g.dart';

@HiveType(typeId: 2)
class Database {
  @HiveField(0)
  List<SavesModel> savesModelList = [];

  @override
  toString() {
    return 'Database { savesModelList : $savesModelList }';
  }

  Database({required this.savesModelList});
}
