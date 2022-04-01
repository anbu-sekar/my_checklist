import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/checkListData.dart';

///DataBase Configuraions
//Initiate DataBase
class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('checkList.db');
    return _database!;
  }

  //Setting DataBase Path
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print(path);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  //Create DataBase
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const foreignKey = 'FOREIGN KEY';
    const refernce = 'REFERENCES';

    await db.execute('''
    CREATE TABLE $checkListCategory ( 
  ${CheckListCategoryData.id} $idType, 
  ${CheckListCategoryData.category} $textType,
  ${CheckListCategoryData.time} $textType
  )
    ''');

    await db.execute('''
  CREATE TABLE $checkLists (
  ${CheckListsData.id}  $idType,
  ${CheckListsData.checkList}  $textType,
  ${CheckListsData.checkListStatus}  $boolType,
  ${CheckListsData.time}  $textType,
  ${CheckListsData.categoryId}  $integerType,
  $foreignKey(${CheckListsData.categoryId}) $refernce $checkListCategory(${CheckListCategoryData.id})
  )
    ''');
  }

  //Close Database
  Future close() async {
    final db = await instance.database;
    db.close();
  }

  ///Category TABLE Operations
  //Create checklist
  Future<CheckListCategory> createCategory(CheckListCategory note) async {
    final db = await instance.database;

    final id = await db.insert(checkListCategory, note.toJson());
    return note.copy(id: id);
  }

  //Fetch Lists
  Future<CheckListCategory> readCategory(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      checkListCategory,
      columns: CheckListCategoryData.values,
      where: '${CheckListCategoryData.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return CheckListCategory.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  //Get category from database
  Future<List<CheckListCategory>> readCategoryLists() async {
    final db = await instance.database;

    const orderBy = '${CheckListCategoryData.time} ASC';
    final result = await db.query(checkListCategory, orderBy: orderBy);

    return result.map((json) => CheckListCategory.fromJson(json)).toList();
  }

  //Update Category
  Future<int> update(CheckListCategory note) async {
    final db = await instance.database;

    return db.update(
      checkListCategory,
      //CheckListCategory.toJson(),
      note.toJson(),
      where: '${CheckListCategoryData.id} = ?',
      whereArgs: [note.id],
    );
  }

  //Delete Category from Data Base
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      checkListCategory,
      where: '${CheckListCategoryData.id} = ?',
      whereArgs: [id],
    );
  }

  /// CheckList Table Operations

  //Create CheckList
  Future<CheckLists> createCheckList(CheckLists note) async {
    final db = await instance.database;

    final id = await db.insert(checkLists, note.toJson());
    return note.copy(id: id);
  }

  //Fetch Lists
  Future<List<CheckLists>> readCheckLists(int id) async {
    final db = await instance.database;

    final result = await db.query(
      checkLists,
      columns: CheckListsData.values,
      where: '${CheckListsData.categoryId} = ?',
      whereArgs: [id],
    );
    return result.map((json) => CheckLists.fromJson(json)).toList();
  }

  //Get category from database
  Future<List<CheckLists>> readAllCheckLists() async {
    final db = await instance.database;

    const orderBy = '${CheckListsData.time} ASC';
    final result = await db.query(checkLists, orderBy: orderBy);
    return result.map((json) => CheckLists.fromJson(json)).toList();
  }

  //Update Category
  Future<int> updateCheckList(CheckLists list) async {
    final db = await instance.database;

    return db.update(
      checkLists,
      list.toJson(),
      where: '${CheckListsData.id} = ?',
      whereArgs: [list.id],
    );
  }

  //Delete Category from Data Base
  Future<int> deleteCheckList(int id) async {
    final db = await instance.database;
    return await db.delete(
      checkLists,
      where: '${CheckListsData.id} = ?',
      whereArgs: [id],
    );
  }
}
