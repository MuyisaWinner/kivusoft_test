import 'dart:async';

import 'package:get/get.dart';
import 'package:kivusoft_test/model/todo.dart';
import '../services/database/database_helper.dart';

class TodoController extends GetxController {
  var data = <Map<String, dynamic>>[].obs;
  final tableName = TodoModel.tableName;

  final db = DbHelper.instance;

  Future<bool> add(Map<String, dynamic> toMap) async {
    var result = await db.add(tableName, toMap);
    await getData();
    return result;
  }

  Future<bool> delete(String id) async {
    var result = await db.delete(tableName, id);
    await getData();
    return result;
  }

  Future<void> getData() async {
    data.value = await db.read(tableName);
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
