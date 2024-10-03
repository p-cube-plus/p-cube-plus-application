import 'package:data/local/local_db/attendance/attendance_dao.dart';
import 'package:data/local/local_db/local_db.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class AttendanceLocalDatasource {
  final _localDb = GetIt.I.get<LocalDb>();
  final _tableName = "Attendance";

  Future<void> createTable(Database db) async {
    db.execute("""
CREATE TABLE $_tableName(
  id INTEGER PRIMARY KEY,
  sequenceNumber INTEGER,
  attendanceDateString TEXT,
  attendanceStatusIndex INTEGER,
)
""");
  }

  Future<void> insertAttendance(AttendanceDao data) async {
    await _localDb.db.insert(
      _tableName,
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<AttendanceDao?> getAttendanceData(int id) async {
    final resultMap = await _localDb.db.query(_tableName, where: "id = $id");
    final result = resultMap.firstOrNull;
    if (result == null) return null;
    return AttendanceDao.fromMap(result);
  }
}
