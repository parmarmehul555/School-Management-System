import 'package:school_management_system/database/SchoolVisitDB.dart';
import 'package:sqflite/sqflite.dart';

class MST_RR_Distribution {
  Future<void> insertIntoMST_RR_Distribution(Map<String, dynamic> data) async {
    Database db = await SchoolVisitDB().initDatabase();
    String q = ''' INSERT INTO MST_RR_Distribution
                      (PurposeID,SchoolID,SeminarID,InterestInCampuseVisit,TotalNumberOfCopies,CourseWiseStudentID) 
                      values (?,?,?,?,?,?)
    ''';
    await db.rawQuery(q, [
      data['PurposeID'],
      data['SchoolID'],
      data['SeminarID'],
      data['InterestInCampuseVisit'],
      data['TotalNumberOfCopies'],
      data['CourseWiseStudentID']
    ]);
  }
}
