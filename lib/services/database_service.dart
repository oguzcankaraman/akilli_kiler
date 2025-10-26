import 'package:akilli_kiler/helpers/pantry_item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._constructor();
  static Database? _db;

  final String _pantryItemsTableName = 'pantry_items';
  final String _pantryItemIdColumnName = 'id';
  final String _pantryItemNameColumnName = 'name';
  final String _pantryItemExpiryDateColumnName = 'expiry_date';

  DatabaseService._constructor();

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'master_db.db');
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $_pantryItemsTableName (
          $_pantryItemIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
          $_pantryItemNameColumnName TEXT NOT NULL,
          $_pantryItemExpiryDateColumnName TEXT NOT NULL
        )
        ''');
      },
    );
    return database;
  }

  Future<void> addPantryItem(PantryItem pantryItem) async {
    final database = await db;
    await database.insert(
      _pantryItemsTableName,
      pantryItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<PantryItem>> getPantryItems() async {
    final database = await db;
    final data = await database.query(_pantryItemsTableName);
    return data.map((item) => PantryItem.fromMap(item)).toList();
  }

  Future<void> deletePantryItem(int id) async {
    final database = await db;
    await database.delete(
      _pantryItemsTableName,
      where: '$_pantryItemIdColumnName = ?',
      whereArgs: [id],
    );
  }

  Future<void> updatePantryItem(PantryItem pantryItem) async {
    final database = await db;
    await database.update(
      _pantryItemsTableName,
      pantryItem.toMap(),
      where: '$_pantryItemIdColumnName = ?',
      whereArgs: [pantryItem.id],
    );
  }
}
