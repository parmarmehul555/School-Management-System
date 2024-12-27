import 'package:school_management_system/database/SchoolVisitDB.dart';
import 'package:sqflite/sqlite_api.dart';

class MST_Purpose{
  Future<List<dynamic>>? selectPurposeDDL() async {
    List<dynamic> purposeList = [];
    Database db = await SchoolVisitDB().initDatabase();
return [];
  }
}