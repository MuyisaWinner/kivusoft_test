// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:kivusoft_test/model/user.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

import 'dart:io';

import '../../model/todo.dart';

class DbHelper {
  DbHelper();
  static DbHelper get instance => DbHelper();
  static String databaseName = 'K_concours.db';
  static int databaseVersion = 1;

  static Future<String> get databasePath async {
    return join(await instance.dbDirectory, databaseName);
  }

  Future<String> get dbDirectory async {
    sqfliteFfiInit();
    databaseFactoryFfi;

    String path = Platform.isAndroid
        ? await getDatabasesPath()
        : Platform.isWindows
            ? await databaseFactoryFfi.getDatabasesPath()
            : throw UnimplementedError('Platform not supported');
    return path;
  }

  Future<Database> initDB() async {
    //methode d'execution de la base de donnee sur windows
    // lire le chemin d'acces et creation des tables
    late Database db;
    if (Platform.isWindows) {
      DatabaseFactory databaseFactory = databaseFactoryFfi;
      db = await databaseFactory.openDatabase(await databasePath,
          options: OpenDatabaseOptions(
            version: databaseVersion,
            onCreate: _onCreate,
          ));
    } else {
      //base de donnee sur android
      //chemin d'acces et creation des tables

      db = await openDatabase(await databasePath,
          version: databaseVersion, onCreate: _onCreate);
    }
    return db;
  }

  //this is only for developpement
  //don't use it in production
  //this fonction will remouve all the database

  // Future<void> startDB({bool remove = false}) async {
  //   if (remove) {
  //     await deleteDB().then((value) async => await initDB());
  //   } else {
  //     await initDB();
  //   }
  //   await setDefault();
  // }

  Future<void> deleteDB() async {
    DatabaseFactory factory = databaseFactoryFfi;
    await factory.deleteDatabase(await databasePath);
    print('DB MESSAGE : database deleted');
  }

  //methode de creation des tables
  Future<void> _onCreate(Database db, int version) async {
    //creation de la table personal
    await db.execute(TodoModel.sql);
    await db.execute(UserModel.sql);
    print('DB MESSAGE : Table created success...');
  }

  Future<bool> add(String table, Map<String, dynamic> data) async {
    Database db = await initDB();
    try {
      await db.insert(table, data,
          conflictAlgorithm: ConflictAlgorithm.replace);
      print('DB Message : Added success $table');

      return true;
    } on DatabaseException catch (e) {
      print('DB Message : Added failed $table - $e');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> read(String table) async {
    Database db = await initDB();
    List<Map<String, dynamic>> datas = await db.query(table);
    return datas;
  }

  Future<bool> update(String table, Map<String, dynamic> data) async {
    Database db = await initDB();
    try {
      await db.update(
        table,
        data,
        where: 'id = ?',
        whereArgs: [data['id']],
      );
      print('DB Message : Updated success $table');
      return true;
    } on DatabaseException catch (e) {
      print('DB Message : Updated failed $table - ${e.result}');
      return false;
    }
  }

  Future<bool> delete(String table, String id) async {
    Database db = await initDB();
    try {
      await db.delete(
        table,
        where: 'id = ?',
        whereArgs: [id],
      );
      print('DB Message : Deleted success $table');
      return true;
    } on DatabaseException catch (e) {
      print('DB Message : Deleted failed $table - ${e.result}');
      return false;
    }
  }

  Future<Map<String, dynamic>?> get(String table, String id) async {
    Database db = await initDB();
    List<Map<String, dynamic>> result = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    }

    return null;
  }
}
