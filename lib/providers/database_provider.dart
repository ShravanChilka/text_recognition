import 'package:flutter/material.dart';
import 'package:text_recognition/models/saves_model.dart';
import 'package:text_recognition/services/database_service.dart';

class DatabaseProvider extends ChangeNotifier {
  List<SavesModel> savesModelList = [];
  DatabaseService db;

  DatabaseProvider({required this.db});

  Future<void> getSaves() async {
    savesModelList = await db.getSaves();
    notifyListeners();
  }

  Future<void> addToSave({required SavesModel savesModel}) async {
    savesModelList = await db.getSaves();
    savesModelList.add(savesModel);
    await db.setSaves(savesModelList: savesModelList);
    notifyListeners();
  }

  Future<void> removeSave({required SavesModel savesModel}) async {
    savesModelList.remove(savesModel);
    await db.setSaves(savesModelList: savesModelList);
    await db.getSaves();
    notifyListeners();
  }
}
