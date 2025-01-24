import 'package:school_management_system/database/SchoolVisitDB.dart';
import 'package:sqflite/sqflite.dart';

class SeminarConduct {
  Future<int> insertSeminarConduct(Map<String, dynamic> data) async {
    Database db = await SchoolVisitDB().initDatabase();
    String query = '''
      INSERT INTO Seminar_Conduct
          (SeminarID, MemberID, SchoolID, SeminarDate, OtherMember, TotalTeacher, TotalStudent, CarOwner, TotalExpence,RemainingAmount)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?,?)
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
      data['RemainingAmount'],
    ]);
    return id;
  }

  Future<List<dynamic>> seminarConductDDL() async {
    List<dynamic> seminarConductList = [];

    Database db = await SchoolVisitDB().initDatabase();
    String query = '''SELECT
                        S.SeminarID,
                        S.SeminarTitle,
                        SC.SeminarConductID
                      FROM Seminar_Conduct as SC
                      INNER JOIN MST_Seminar as S
                      ON S.SeminarID = SC.SeminarID
                      WHERE SC.RemainingAmount > 0''';
    seminarConductList = await db.rawQuery(query);
    print(seminarConductList);
    if (seminarConductList.isNotEmpty) {
      return seminarConductList;
    }
    return seminarConductList;
  }

  Future<Map<String,dynamic>> selectConductedSeminarDetails(int seminarConductID) async {
    Database db = await SchoolVisitDB().initDatabase();

    String query = '''SELECT 
                        SC.TotalTeacher,
                        SC.TotalStudent,
                        SC.TotalExpence
                      FROM Seminar_Conduct as SC
                      WHERE SC.SeminarConductID = ?''';
    List<Map<String, dynamic>> result = await db.rawQuery(query, [seminarConductID]);
    print(result.first);
    return result.isNotEmpty ? result.first : Map();
  }

  Future<void> updateRemainingAmount(int paidAmount,int seminarConductID) async {
    Database db = await SchoolVisitDB().initDatabase();
    String query = '''UPDATE  Seminar_Conduct
                      SET RemainingAmount = RemainingAmount - ?
                      WHERE Seminar_Conduct.SeminarConductID = ?''';
    await db.rawUpdate(query,[paidAmount,seminarConductID]);
  }
}
