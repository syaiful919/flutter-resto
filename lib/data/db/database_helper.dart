import 'package:resto/data/model/restaurant_local_model.dart';
import 'package:resto/data/model/restaurant_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createObject();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createObject();
    }

    return _databaseHelper;
  }

  static const String _tblFavorites = 'favorites';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/resto.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblFavorites (
             id TEXT PRIMARY KEY,
             name TEXT,
             description TEXT,
             pictureId TEXT,
             city TEXT,
             rating REAL
           )     
        ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database> get database async {
    if (_database == null) _database = await _initializeDb();
    return _database;
  }

  Future<void> insertFavorite(RestaurantModel restaurant) async {
    RestaurantLocalModel data = RestaurantLocalModel.fromRestaurant(restaurant);
    final db = await database;
    await db.insert(_tblFavorites, data.toJson());
  }

  Future<List<RestaurantLocalModel>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(_tblFavorites);

    return results.map((res) => RestaurantLocalModel.fromJson(res)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db.query(
      _tblFavorites,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db.delete(
      _tblFavorites,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
