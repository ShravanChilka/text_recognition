import 'package:flutter/material.dart';
import 'package:text_recognition/models/saves_model.dart';
import 'package:text_recognition/services/database_service.dart';

class DatabaseProvider extends ChangeNotifier {
  List<SavesModel>? savesModelList;
  DatabaseService db;

  DatabaseProvider({required this.db});

  Future<void> getSaves() async {
    savesModelList = await db.getSaves();
    debugPrint(savesModelList.toString());
  }

  Future<void> addToSave({required SavesModel savesModel}) async {
    savesModelList = await db.getSaves();
    savesModelList ??= [];
    savesModelList?.add(savesModel);
    await db.setSaves(savesModelList: savesModelList);
  }
}
