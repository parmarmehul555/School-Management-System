import 'package:school_management_system/database/SchoolVisitDB.dart';
import 'package:sqflite/sqflite.dart';

class School{
  Future<List<dynamic>> selectSchoolDDL() async {
    List<dynamic> schoolList = [];
    Database db = await SchoolVisitDB().initDatabase();
    String query = '''SELECT 
                        SchoolID, SchoolShortName || ' - ' || CityName AS SchoolWithCity
                      FROM MST_School
                      INNER JOIN LOC_City
                      ON LOC_City.CityID = MST_School.CityID''';
    schoolList = await db.rawQuery(query);
    print(schoolList);
    if(schoolList.isNotEmpty){
      return schoolList;
    }
    return [];
  }
}