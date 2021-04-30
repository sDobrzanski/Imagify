import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

final String tableFavPhotos = 'FavouritePhotos';
final String columnId = '_id';
final String columnDesc = 'desc';
final String columnAuthor = 'author';
final String columnUrl = 'url';
final String columnLikes = 'likes';
final String columnDownloadUrl = 'downloadUrl';

class FavouritePhoto {
  int id;
  String desc;
  String author;
  String url;
  int likes;
  String downloadUrl;
  FavouritePhoto();

  FavouritePhoto.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    desc = map[columnDesc];
    author = map[columnAuthor];
    url = map[columnUrl];
    likes = map[columnLikes];
    downloadUrl = map[columnDownloadUrl];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnDesc: desc,
      columnLikes: likes,
      columnAuthor: author,
      columnUrl: url,
      columnDownloadUrl: downloadUrl,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

class DatabaseHelper {
  static Database _database;
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableFavPhotos (
                $columnId INTEGER PRIMARY KEY,
                $columnDesc TEXT NOT NULL,
                $columnAuthor TEXT NOT NULL,
                $columnUrl TEXT NOT NULL,
                $columnDownloadUrl TEXT NOT NULL,
                $columnLikes INTEGER NOT NULL
              )
              ''');
  }

  Future insertFavPhoto(FavouritePhoto photo) async {
    Database db = await database;
    await db.insert(tableFavPhotos, photo.toMap());
  }

  Future<List<FavouritePhoto>> returnFavPhotos() async {
    List<FavouritePhoto> listFavPhotos = [];
    Database db = await database;
    List<Map> result = await db.query(tableFavPhotos);
    result.forEach((element) {
      listFavPhotos.add(FavouritePhoto.fromMap(element));
    });
    return listFavPhotos;
  }

  Future<int> delete(int id) async {
    Database db = await database;
    return await db
        .delete(tableFavPhotos, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    Database db = await database;
    return await db.delete(tableFavPhotos);
  }
}
