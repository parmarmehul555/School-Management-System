import 'package:school_management_system/database/SchoolVisitDB.dart';
import 'package:sqflite/sqflite.dart';

class MST_CourseWiseStudents{
  Future<void> insertIntoMST_CourseWiseStudents(Map<String,dynamic> data) async {
    Database db = await SchoolVisitDB().initDatabase();
    String query = ''' Insert into MST_CourseWiseStudents (RRDID,CourseID,TotalStudent)
    values(?,?,?)
    ''';
    await db.rawQuery(query,[data['RRDID'],data['CourseID'],data['TotalStudent']]);
  }
}