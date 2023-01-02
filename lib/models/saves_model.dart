import 'package:hive/hive.dart';

part 'saves_model.g.dart';

@HiveType(typeId: 1)
class SavesModel {
  @HiveField(0)
  String recogniseText;

  @override
  toString() {
    return 'SavesModel { recogniseText : $recogniseText }';
  }

  SavesModel({required this.recogniseText});
}
