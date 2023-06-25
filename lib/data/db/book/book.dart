import 'package:book_selection/data/model/book/book.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:book_selection/data/model/book/book.dart' as bt;

class BookDatabase {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await openDatabase(
      join(await getDatabasesPath(), 'book_database.db'),
      onCreate: _createDB,
      version: 1,
    );
    return _database!;
  }

  Future _createDB(Database db, int version) async {
    const codeType = 'VARCHAR PRIMARY KEY NOT NULL';
    const textType = 'VARCHAR NOT NULL';
    const intType = 'INTEGER NOT NULL';
    const textTypeNull = 'VARCHAR';

    await db.execute('''
      CREATE TABLE ${bt.tableBook}(
        ${bt.BookFields.code} $codeType,
        ${bt.BookFields.isbn} $textType,
        ${bt.BookFields.title} $textType,
        ${bt.BookFields.description} $textTypeNull,
        ${bt.BookFields.category} $textType,
        ${bt.BookFields.publishDate} $textTypeNull,
        ${bt.BookFields.price} $intType,
        ${bt.BookFields.hardCover} $textTypeNull
      )
    ''');
  }

  Future<void> insertBook(BookModel book) async {
    final db = await database;

    await db.insert(
      bt.tableBook,
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<BookModel>> getBooks() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(bt.tableBook);

    return List.generate(maps.length, (i) {
      final result = BookModel(
        code: maps[i][bt.BookFields.code].toString(),
        isbn: maps[i][bt.BookFields.isbn].toString(),
        title: maps[i][bt.BookFields.title].toString(),
        description: maps[i][bt.BookFields.description].toString(),
        category: maps[i][bt.BookFields.category].toString(),
        publishDate: maps[i][bt.BookFields.publishDate].toString(),
        price: maps[i][bt.BookFields.price].toString(),
        hardCover: maps[i][bt.BookFields.hardCover].toString(),
      );
      return result;
    });
  }

  Future<void> updateBook(BookModel book) async {
    final db = await database;

    await db.update(
      bt.tableBook,
      book.toMap(),
      where: 'code = ?',
      whereArgs: [book.code],
    );
  }

  Future<void> deleteBook(String code) async {
    final db = await database;

    await db.delete(
      bt.tableBook,
      where: 'code = ?',
      whereArgs: [code],
    );
  }
}
