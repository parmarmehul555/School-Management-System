import 'package:school_management_system/database/SchoolVisitDB.dart';
import 'package:sqflite/sqflite.dart';

class MST_Course{
  Future<List<dynamic>> selectCourseDDL() async {
    List<dynamic> courseList = [];
    Database db = await SchoolVisitDB().initDatabase();
    String query = '''SELECT CourseID,CourseName FROM MST_Course''';
    courseList = await db.rawQuery(query);
    print(courseList);
    if(courseList.isNotEmpty){
      return courseList;
    }
    return [];
  }
}