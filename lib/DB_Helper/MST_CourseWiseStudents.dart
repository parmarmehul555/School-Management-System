import 'package:school_management_system/database/SchoolVisitDB.dart';
import 'package:sqflite/sqflite.dart';

class MST_CourseWiseStudents{
  Future<int> insertIntoMST_CourseWiseStudents(Map<String,dynamic> data) async {
    Database db = await SchoolVisitDB().initDatabase();
    String query = ''' Insert into MST_CourseWiseStudents (CourseID,TotalStudent)
    values(?,?)
    ''';
    int CourseID = await db.rawInsert(query,[data['CourseID'],data['TotalStudent']]);
    return CourseID;
  }
}