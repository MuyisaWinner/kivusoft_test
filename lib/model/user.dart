import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kivusoft_test/controllers/user_controller.dart';
import 'package:kivusoft_test/root.dart';

import '../services/database/database_helper.dart';
import 'package:path/path.dart';

class UserModel {
  String id = '',
      nom = '',
      postNom = '',
      email = '',
      password = '',
      status = '',
      profile = '';

  UserModel();
  UserModel.build(
      {required this.id,
      required this.nom,
      required this.postNom,
      required this.email,
      required this.password,
      required this.status,
      required this.profile});
  String get nomComplet => '${nom.maj} ${postNom.maj}';

  Map<String, dynamic> get toMap => {
        'id': id,
        'nom': nom,
        'postNom': postNom,
        'email': email,
        'password': password,
        'profile': profile,
        'status': status
      };
  static String tableName = 'UserModel';

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel.build(
      id: data['id'],
      nom: data['nom'],
      postNom: data['postNom'],
      email: data['email'],
      status: data['status'],
      password: data['password'],
      profile: data['profile']);

  static String get sql => """
CREATE TABLE $tableName(
  id TEXT PRIMARY KEY,
  nom TEXT NOT NULL,
  postNom TEXT NOT NULL,
  email TEXT NOT NULL,
  password TEXT NOT NULL,
  profile TEXT NOT NULL,
  status TEXT NOT NULL
)
""";

  static UsersController get controller => Get.put(UsersController());

  Future<bool> add() => controller.add(toMap);
  Future<bool> delete() => controller.delete(id);

  Future<bool> desconnect() async {
    await box.remove('USER_TOKEN');
    return true;
  }

  static Future<String> profilePath(String id) async {
    return join(await DbHelper.instance.dbDirectory, 'profile', '$id.png');
  }

  UserModel? get current {
    // return controller.data
    //     .map((element) => UserModel.fromMap(element))
    //     .toList()
    //     .firstOrNull;
    final token = box.read('USER_TOKEN');
    if (token != null) {
      return UserModel.fromMap(jsonDecode(box.read(token)));
    }
    return null;
  }

  static UserModel? get currrent => controller.data
      .map((element) => UserModel.fromMap(element))
      .toList()
      .firstWhereOrNull(
          (element) => element.status == UserStatus.connected.name);

  Future<bool> connect() async {
    //CETTE METHODE SAUVEGARDE LA SESSION
    final user = controller.data
        .map((element) => UserModel.fromMap(element))
        .toList()
        .firstWhereOrNull((element) =>
            element.email == email && element.password == password);

    if (user == null) {
      print('USER NOT FOUND');
      return false;
    } else {
      print('USER  FOUND');

      await box.write('USER_TOKEN', jsonEncode(user.toMap));
      return true;
    }
  }

  Future<void> createProfile(String id, List<int> bytes) async {
    var pic = File(await profilePath(id));
    if (bytes.isEmpty) return;
    if (pic.existsSync() && pic.readAsBytesSync().toList() == bytes) return;
    if (pic.existsSync() && pic.readAsBytesSync().toList() != bytes) {
      await pic.delete(recursive: true);
    }
    final dir = Directory(join(await DbHelper.instance.dbDirectory, 'profile'));
    if (!await dir.exists()) {
      dir
          .create(recursive: true)
          .then((value) async => await pic.writeAsBytes(bytes));
    } else {
      await pic.writeAsBytes(bytes);

      print('Profile saved : ${pic.path}');
    }
  }

  Uint8List? get picture {
    var file = File(profile);
    if (file.existsSync()) {
      return file.readAsBytesSync();
    } else {
      print('File not exist');
      return null;
    }
  }
}

enum UserStatus { connected, disconnected }
