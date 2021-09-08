import 'dart:io';

import 'package:maan_api_project/models/allProductResponse.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();
  static DBHelper cartHelper = DBHelper._();
  static final String cartTableName = 'cart';
  static final String productDetailsColumn = 'productDetails';
  static final String id = 'id';

  static final String favouriteTableName = 'favourites';
  static final String favouriteTitleColumnName = 'title';
  static final String favouritePriceColumnName = 'price';
  static final String favouriteDescriptionColumnName = 'description';
  static final String favouriteImageColumnName = 'image';
  Database database;
  initDatabase() async {
    database = await createDatabase();
  }

  Future<Database> createDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String directoryPath = directory.path;
    String databasePath = directoryPath + 'EcommerceApp.db';
    Database database =
        await openDatabase(databasePath, version: 1, onCreate: (db, v) {
      db.execute(
          'CREATE TABLE $cartTableName ($id INTEGER PRIMARY KEY, $productDetailsColumn TEXT)');

      db.execute('''CREATE TABLE $favouriteTableName ($id INTEGER PRIMARY KEY,
           $favouriteTitleColumnName TEXT,
            $favouritePriceColumnName TEXT,
             $favouriteDescriptionColumnName TEXT, 
             $favouriteImageColumnName TEXT)''');
    });
    return database;
  }

  addToCart(String productDetails, int productId) async {
    try {
      int x = await database.insert(
          cartTableName, {'id': productId, productDetailsColumn: productDetails});
      print(x);
    } on Exception catch (e) {
      // TODO
    }
  }

  addToFavourite(AllProductsResponse productDetails) async {
    try {
      int x = await database.insert(
        favouriteTableName, productDetails.toJson()
      );
      
      print(' Fav. $x');
    } on Exception catch (e) {
      // TODO
    }
  }

  Future<List<Map<String, Object>>> getCart() async {
    try {
      List<Map<String, Object>> maps = await database.query(cartTableName);
      return maps;
    } on Exception catch (e) {
      // TODO
    }
  }

  Future<List<Map<String, Object>>> getFavourite() async {
    try {
      List<Map<String, Object>> maps = await database.query(favouriteTableName);
      return maps;
    } on Exception catch (e) {
      // TODO
    }
  }

  removeFromCart(int id) async {
    try {
      int x =
          await database.delete(cartTableName, where: 'id=?', whereArgs: [id]);
      print(x);
    } on Exception catch (e) {
      // TODO
    }
  }

  removeFromFavourite(int id) async {
    try {
      int x = await database
          .delete(favouriteTableName, where: 'id=?', whereArgs: [id]);
      print(x);
    } on Exception catch (e) {
      // TODO
    }
  }
}
