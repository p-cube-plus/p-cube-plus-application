import 'package:sqflite/sqflite.dart';

class LocalDb {
  //final _dbName = "p_cube_plus_db";
  late Database db;

  Future<void> initialize() async {
    // db = await openDatabase(
    //   path.join(await getDatabasesPath(), _dbName),
    //   onCreate: (db, version) async {
    //     await GetIt.I.get<AttendanceLocalDatasource>().createTable(db);
    //   },
    //   version: 1,
    // );
  }
}
