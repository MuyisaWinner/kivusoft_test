// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kivusoft_test/componnents/color.dart';
import 'package:kivusoft_test/controllers/todo_controller.dart';

class TodoModel {
  String id = '', title = '', description = '', status = '';
  DateTime date = DateTime.now();

  Map<String, dynamic> get toMap => {
        'id': id,
        'title': title,
        'description': description,
        'date': date.millisecondsSinceEpoch,
        'status': status
      };

  TodoModel();
  TodoModel.build({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
  });
  factory TodoModel.fromMap(Map<String, dynamic> data) => TodoModel.build(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      status: data['status'],
      date: DateTime.fromMillisecondsSinceEpoch(data['date']));

  static String tableName = 'todoTable';
  static String get sql => """
CREATE TABLE $tableName(
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  date INTEGER NOT NULL,
  status TEXT NOT NULL
)
""";

  static TodoController get controller => Get.put(TodoController());

  Future<bool> add() => controller.add(toMap);
  Future<bool> delete() => controller.delete(id);
  TodoStatus get getStatus =>
      TodoStatus.values.firstWhere((element) => element.name == status);
}

enum TodoStatus { annuler, terminer, en_cours }

extension TodoStatusExtension on TodoStatus {
  String get label {
    switch (this) {
      case TodoStatus.annuler:
        return 'Annuler';
      case TodoStatus.terminer:
        return 'Terminer';
      case TodoStatus.en_cours:
        return 'En cours';
      default:
        throw UnimplementedError('Aucune Todo');
    }
  }

  Color get color {
    switch (this) {
      case TodoStatus.annuler:
        return PrimaryColor.pink;
      case TodoStatus.terminer:
        return PrimaryColor.green;
      case TodoStatus.en_cours:
        return PrimaryColor.orange;
      default:
        throw UnimplementedError('Aucune Todo');
    }
  }
}
