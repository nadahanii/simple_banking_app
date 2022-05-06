import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:basic_banking_app/Model/User.dart';
import 'package:basic_banking_app/Model/Transfer.dart';

class DatabaseHelper {
  //making it a singleton class
  DatabaseHelper.init();
  static final DatabaseHelper instance = DatabaseHelper.init();

  static final _dbName = "myDB.db";
  static final _dbVersion = 1;

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) //db is created, so return it
    {
      return _database!;
    }
    //initiating db
    _database = await _initiateDB();
    return _database!;
  }

  _initiateDB() async {
    Directory directory =
        await getApplicationDocumentsDirectory(); //get doc directories in different types of mobiles
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future? _onCreate(Database db, int version) async {
    //data types
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final doubleType = 'DOUBLE NOT NULL';

    //creating tables
    await db.execute('''
      CREATE TABLE $tableUsers (
      ${UserFields.id} $idType,
      ${UserFields.name} $textType,
      ${UserFields.email} $textType,
      ${UserFields.cur_balance} $doubleType
      )
      ''');

    await db.execute('''
      CREATE TABLE $tableTransfers (
      ${TransferFields.id} $idType,
      ${TransferFields.senderName} $textType,
      ${TransferFields.receiverName} $textType,
      ${TransferFields.transferredAmount} $doubleType
      )
      ''');
  }

  Future<User> insertUser(User user) async {
    final db = await instance.database;
    final id = await db.insert(tableUsers, user.toJson());
    return user.copy(id: id);
  }

  Future<int> insertTransfer(Transfer transfer) async {
    final db = await instance.database;
    final id = await db.insert(tableUsers, transfer.toJson());
    return id;
  }

  Future<User> queryUserById(int id) async {
    final db = await instance.database;
    final maps = await db.query(tableUsers,
        columns: UserFields.values,
        where: '${UserFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception('User whose id $id is not found');
    }
  }

  Future<List<User>?> queryAllUsers() async {
    final db = await instance.database;
    final result = await db.query(tableUsers);

    return result.map((json) => User.fromJson(json)).toList();
  }

  Future<List<Transfer>?> queryAllTransfers() async {
    final db = await instance.database;
    final result = await db.query(tableTransfers);
    return result.map((json) => Transfer.fromJson(json)).toList();
  }

  Future/*<int>*/ updateUser(int id,double balance) async {
    final db = await instance.database;

    db.rawUpdate(''' 
    UPDATE users SET cur_balance=? Where id=?''',
    ['$balance',id]
    );
    /*return db.update(
      tableUsers,
      User user = queryUserById(id),
      where: '${UserFields.id} = ?',
      whereArgs: [user.id],
    );*/
  }

  Future<int> deleteUser(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableUsers,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );
  }

  void addUsers() {
    User user1 = User(
        name: 'Gianna Loyd', email: 'gian.loyd@gmail.com', cur_balance: 3000.0);
    insertUser(user1);
    User user2 = User(
        name: 'Paulette Thies',
        email: 'paulett-th@progressenergyinc.info',
        cur_balance: 4200.0);
    insertUser(user2);
    User user3 = User(
        name: 'Romaine Rogahn',
        email: 'romaine.rogahn@hotmail.com',
        cur_balance: 1300.0);
    insertUser(user3);
    User user4 = User(
        name: 'Billy Farrell',
        email: 'billy_farrell@yahoo.com',
        cur_balance: 5000.0);
    insertUser(user4);
    User user5 = User(
        name: 'Kathryn Wisoky',
        email: 'kathryn_wisoky@yahoo.com',
        cur_balance: 6730.0);
    insertUser(user5);
    User user6 = User(
        name: 'Kiana Leannon',
        email: 'kiana_leannon@hotmail.com',
        cur_balance: 8600.0);
    insertUser(user6);
    User user7 = User(
        name: 'Marion Ondricka',
        email: 'marion_ondricka85@yahoo.com',
        cur_balance: 2500.0);
    insertUser(user7);
    User user8 = User(
        name: 'Bella Hartman',
        email: 'bella.hartmann28@hotmail.com',
        cur_balance: 1932.0);
    insertUser(user8);
    User user9 = User(
        name: 'Tracy Brown',
        email: 'tracy_brown17@hotmail.com',
        cur_balance: 5200.0);
    insertUser(user9);
    User user10 = User(
        name: 'Danial Ullrich',
        email: 'danial_ullrich35@yahoo.com',
        cur_balance: 8960.0);
    insertUser(user10);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
