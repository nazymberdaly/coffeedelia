import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// {@template coffee_entity}
/// A model representing a coffee in an entity.
/// {@endtemplate}
class CoffeeEntity {
  /// {@macro coffee_entity}
  CoffeeEntity({required this.imagePath, this.id});

  /// Coffee's  id.
  final int? id;

  /// Path to the locally stored coffee image
  final String imagePath;

  /// Convert a Coffee object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
    };
  }

  /// Create a Coffee object from a map
  static CoffeeEntity fromMap(Map<String, dynamic> map) {
    return CoffeeEntity(
      id: map['id'] as int,
      imagePath: map['imagePath'] as String,
    );
  }
}

/// {@template db_client}
/// Client used  to save favorite coffee images locally
/// {@endtemplate}
class DbClient {
  DbClient._internal();

  /// {@macro db_client}
  static Database? _database;
  static final DbClient instance = DbClient._internal();

  factory DbClient() => instance;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await openDatabase(
      'coffee_database.db',
      version: 1,
      onCreate: _createDb,
    );
    return _database!;
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE coffees(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        imagePath TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertCoffee(CoffeeEntity coffee) async {
    final db = await database;
    return db.insert('coffees', coffee.toMap());
  }

  Future<List<CoffeeEntity>> getCoffees() async {
    final db = await database;
    final maps = await db.query('coffees');
    return maps.map((map) => CoffeeEntity.fromMap(map)).toList();
  }

  Future<int> deleteCoffee(int id) async {
    final db = await database;
    return await db.delete('coffees', where: 'id = ?', whereArgs: [id]);
  }

  Future<CoffeeEntity?> getCoffee(int id) async {
    final db = await database;
    final maps =
        await db.query('coffees', where: 'id = ?', whereArgs: [id], limit: 1);
    if (maps.isNotEmpty) {
      return CoffeeEntity.fromMap(maps.first);
    }
    return null;
  }

  Future<String> saveImage(File imageFile, String coffeeName) async {
    final directory = await getApplicationDocumentsDirectory();
    final newImagePath = '${directory.path}/${coffeeName}_${DateTime.now().millisecondsSinceEpoch}.jpg'; // Include timestamp for uniqueness
    await imageFile.copy(newImagePath);
    return newImagePath;
  }
}
