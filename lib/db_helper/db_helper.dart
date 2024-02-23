import 'dart:io';

import 'package:music/model/audio_file_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
class DbHelper
{
  Database? _db;
  Future<Database?> get db
  async {
    if(_db!=null)
    {
      return _db;
    }
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();
    String path=join(directory!.path,'db');
    var db=await openDatabase(path,version: 1,onCreate: (db, version) {
      db.execute("CREATE TABLE Favourite(id INTEGER PRIMARY KEY, name TEXT, path TEXT, size TEXT, length TEXT, isFavourite INTEGER)");
    },);
    return db;
  }
  Future<AudioFile> insert(AudioFile model) async {
    var dbClient=await db;
    dbClient!.insert('Favourite', model.toMap()).then((value) {
    });
    return model;
  }
  Future<int> delete (String name,) async {
    var dbClient=await db;
    return await dbClient!.delete(
        'Favourite',
        where: 'name = ?',
        whereArgs: [name]).then((value) {
      // Utils.showSnackBar('Deleted', 'Task is removed successfully', const Icon(Icons.done,color: Colors.white,size: 16,));
      return value;
    });
  }
  Future<List<AudioFile>> getData() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query('Favourite');
    return queryResult.map((e) {
      return AudioFile.fromMap(e);
    }).toList();
  }

  Future<bool> isFavoriteExists(String name) async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query(
      'Favourite',
      where: 'name = ?',
      whereArgs: [name],
    );
    return queryResult.isNotEmpty;
  }
}