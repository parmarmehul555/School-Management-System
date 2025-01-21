import 'package:school_management_system/database/SchoolVisitDB.dart';
import 'package:sqflite/sqflite.dart';

class SeminarConduct{
  Future<int> insertSeminarConduct(Map<String, dynamic> data) async {
    Database db = await SchoolVisitDB().initDatabase();
    String query = '''
      INSERT INTO Seminar_Conduct
          (SeminarID, MemberID, SchoolID, SeminarDate, OtherMember, TotalTeacher, TotalStudent, CarOwner, TotalExpence)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''';
    int id = await db.rawInsert(query, [
      data['SeminarID'],
      data['MemberID'],
      data['SchoolID'],
      data['SeminarDate'],
      data['OtherMember'],
      data['TotalTeacher'],
      data['TotalStudent'],
      data['CarOwner'],
      data['TotalExpence'],
    ]);
    return id;
  }
}
