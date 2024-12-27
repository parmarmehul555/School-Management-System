import 'package:school_management_system/database/SchoolVisitDB.dart';
import 'package:sqflite/sqflite.dart';

class School{
  Future<List<dynamic>> selectSchoolDDL() async {
    List<dynamic> schoolList = [];
    Database db = await SchoolVisitDB().initDatabase();
    String query = '''SELECT SchoolID,SchoolShortName FROM MST_School''';
    schoolList = await db.rawQuery(query);
    print(schoolList);
    if(schoolList.isNotEmpty){
      return schoolList;
    }
    return [];
  }
}