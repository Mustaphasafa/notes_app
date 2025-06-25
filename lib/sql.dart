import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sql {

  static Database? _db;

  Future<Database?> get db async{
    if(_db==null){
      _db = await initDb();
      return _db;
    }else{
      return _db;
    }
  }

// this function is responsible for opening or modifying the database path
 initDb() async {
  String path = await getDatabasesPath();
  String fullpath =  join(path,'notes.db');
  Database mydb = await openDatabase(fullpath,onCreate: _onCreate,version: 1,onUpgrade: _onUpgrade);
  return mydb;
 }

// this function is responsible for creating the table inside the database
 _onCreate(Database db ,int version)async{
  await db.execute('''
CREATE TABLE 'notes'(
id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
'title' TEXT ,
'note' TEXT ,
'type' TEXT
)
''');
 }

 //this function is responsible for update something in the table that we have create 'notes',(it only work when we change 'version')
 _onUpgrade(Database db ,int oldversion,int newversion)async{
  await db.execute('');
 }
 
// function to display columns
readData(sql)async{
  Database? mydb = await db;
  List<Map> response = await mydb!.rawQuery(sql);
  return response;
}

// function to create new columns
insertData(sql)async{
  Database? mydb = await db;
  int response = await mydb!.rawInsert(sql);
  return response;
}

// function to update columns
updateData(sql)async{
  Database? mydb = await db;
  int response = await mydb!.rawUpdate(sql);
  return response;
}

// function to delete columns
deleteData(sql)async{
  Database? mydb = await db;
  int response = await mydb!.rawDelete(sql);
  return response;
}

// This function is responsible for deleting the database by the path (data/<package_name>/databases/notes.db)
onDeleteDatabase()async{
String path = await getDatabasesPath();
  String fullpath =  join(path,'notes.db');
  await deleteDatabase(fullpath);
}

}