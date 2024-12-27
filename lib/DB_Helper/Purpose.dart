import 'package:school_management_system/database/SchoolVisitDB.dart';
import 'package:sqflite/sqflite.dart';

class Purpose{
  Future<List<dynamic>> selectPurposeDDL() async {
    List<dynamic> purposeList = [];
    Database db = await SchoolVisitDB().initDatabase();
    String query = '''SELECT PurposeID, PurposeTitle from MST_Purpose''';
    purposeList = await db.rawQuery(query);
    if(purposeList.isNotEmpty){
      return purposeList;
    }
    return [];
  }
}