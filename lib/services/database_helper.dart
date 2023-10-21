import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dp_prueba_ingreso/models/user_model.dart'; 

class DatabaseHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 2;

  static const userTable = 'user_table';

  static const columnId = '_id';
  static const columnFirstName = 'first_name';
  static const columnLastName = 'last_name';
  static const columnDateOfBirth = 'date_of_birth';
  // Nueva tabla para las direcciones
  static const columnIdAdress = 'addressId';
  static const addressTable = 'address_table';
  static const columnStreet = 'street';
  static const columnCity = 'city';
  static const columnCountry = 'country';
  static const columnZipCode = 'zipCode';
  static const columnUserId = 'userId'; // Clave foránea para relacionar la dirección con el usuario

  //singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Tiene la base de datos sólo una instancia abierta.
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Método para inicializar la base de datos
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // Método para crear la base de datos cuando se inicializa por primera vez
 Future _onCreate(Database db, int version) async {
  await db.execute('''
    CREATE TABLE $userTable (
      $columnId INTEGER PRIMARY KEY,
      $columnFirstName TEXT NOT NULL,
      $columnLastName TEXT NOT NULL,
      $columnDateOfBirth TEXT NOT NULL
    )
  ''');

  await db.execute('''
    CREATE TABLE $addressTable (
        $columnIdAdress INTEGER PRIMARY KEY,
        $columnUserId INTEGER NOT NULL,
        $columnStreet TEXT NOT NULL,
        $columnCity TEXT NOT NULL,
        $columnCountry TEXT NOT NULL,
        $columnZipCode TEXT NOT NULL
      )
    ''');
}


  // Método para insertar un usuario en la base de datos
  Future<int> insertUser(UserModel user) async {
    Database db = await instance.database;
    return await db.insert(userTable, user.toMap());
  }
 // Método para insertar direcciones
  Future<int> insertAddress(Address address) async {
    Database db = await instance.database;
    return await db.insert(addressTable, address.toMap());
  }
  Future<List<UserModel>> getUsers() async {
    final db = await instance.database;
    final usersMap = await db.query('user_table');
    return usersMap.map((user) => UserModel.fromMap(user)).toList();
  }
  Future<List<Address>> getAddressesByUserId(int userId) async {
  Database db = await instance.database;
  var result = await db.query('address_table', where: 'userId = ?', whereArgs: [userId]);

  // Convertir cada Map en un objeto Address usando el método fromMap.
  List<Address> addresses = result.isNotEmpty
      ? result.map((item) => Address.fromMap(item)).toList()
      : [];
  return addresses;
  }

}
