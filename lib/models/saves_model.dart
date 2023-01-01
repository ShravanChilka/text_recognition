import 'package:hive/hive.dart';

part 'saves_model.g.dart';

@HiveType(typeId: 1)
class SavesModel {
  @HiveField(0)
  String recogniseText;

  SavesModel({required this.recogniseText});
}
