import 'package:school_management_system/database/SchoolVisitDB.dart';
import 'package:sqflite/sqflite.dart';

class Remunerationn {
  Future<void> insertIntoRemuneration(Map<String, dynamic> data) async {
    Database db = await SchoolVisitDB().initDatabase();
    String query = '''INSERT INTO Remuneration (TotalExpence, RemainingAmount, SeminarConductID) VALUES (?, ?, ?)''';
    await db.rawInsert(query, [data['TotalAmount'], data['RemainingAmount'], data['SeminarConductID']]);
  }

  Future<void> insertIntoRemunerationFromRRD(Map<String, dynamic> data) async {
    Database db = await SchoolVisitDB().initDatabase();
    String query = '''INSERT INTO Remuneration (TotalExpence, RemainingAmount, RRDID) VALUES (?, ?, ?)''';
    await db.rawInsert(query, [data['TotalAmount'], data['RemainingAmount'], data['RRDID']]);
  }

  Future<void> updateRemunerationAmount(int seminarConductID, int paidAmount) async {
    Database db = await SchoolVisitDB().initDatabase();
    String query = '''UPDATE Remuneration
                      SET RemainingAmount = RemainingAmount - ?,
                          PaidAmount = PaidAmount + ?
                      WHERE SeminarConductID = ?''';
    await db.rawUpdate(query, [paidAmount, paidAmount, seminarConductID]);
  }

  Future<void> updateRemunerationAmountForRR(int RRID, int paidAmount) async {
    Database db = await SchoolVisitDB().initDatabase();
    String query = '''UPDATE Remuneration
                      SET RemainingAmount = RemainingAmount - ?,
                          PaidAmount = PaidAmount + ?
                      WHERE RRDID = ?''';
    await db.rawUpdate(query, [paidAmount, paidAmount, RRID]);
  }

  Future<Map<String,dynamic>> selectRemainingAmount(int seminarConductID) async {
    Database db = await SchoolVisitDB().initDatabase();
    List<Map<String,dynamic>> list = [];
    String query = '''SELECT RemainingAmount FROM Remuneration WHERE SeminarConductID = ?''';
    list = await db.rawQuery(query,[seminarConductID]);
    return list.isNotEmpty ? list.first : Map();
  }

  Future<Map<String,dynamic>> selectRemainingAmountForRR(int RRID) async {
    Database db = await SchoolVisitDB().initDatabase();
    List<Map<String,dynamic>> list = [];
    String query = '''SELECT RemainingAmount,TotalExpence FROM Remuneration WHERE RRDID = ?''';
    list = await db.rawQuery(query,[RRID]);
    return list.isNotEmpty ? list.first : Map();
  }

  Future<List<dynamic>> selectSeminarWisePendingRemuneration() async {
    List<dynamic> seminarWisePendingRemuneration = [];
    Database db = await SchoolVisitDB().initDatabase();
    String query = '''SELECT 
                          Seminar_Conduct.SeminarDate,
                          Seminar_Conduct.SeminarConductID,
                          MST_Seminar.SeminarTitle,
                          MST_School.SchoolName,
                          Remuneration.RemunerationID,
                          Remuneration.SeminarConductID,
                          Remuneration.TotalExpence,
                          Remuneration.PaidAmount,
                          Remuneration.RemainingAmount
                      FROM Seminar_Conduct
                      INNER JOIN Remuneration
                      ON Seminar_Conduct.SeminarConductID = Remuneration.SeminarConductID
                      INNER JOIN MST_Seminar
                      ON Seminar_Conduct.SeminarID = MST_Seminar.SeminarID
                      INNER JOIN MST_School
                      ON Seminar_Conduct.SchoolID = MST_School.SchoolID
                      WHERE Remuneration.RemainingAmount > 0
                      ORDER BY Seminar_Conduct.SeminarDate DESC''';
    seminarWisePendingRemuneration = await db.rawQuery(query);
    if(seminarWisePendingRemuneration.isNotEmpty){
      return seminarWisePendingRemuneration;
    }
    return seminarWisePendingRemuneration;
  }

  Future<List<dynamic>> selectRRDistributionWisePendingRemuneration() async {
    List<dynamic> distributionWisePendingRemuneration = [];
    Database db = await SchoolVisitDB().initDatabase();
    String query = '''SELECT 
                          MST_RR_Distribution.RRDDate,
                          MST_RR_Distribution.RRDID,
                          MST_RR_Distribution.PurposeID,
                          MST_RR_Distribution.SchoolID,
                          MST_Purpose.PurposeTitle,
                          MST_School.SchoolName,
                          Remuneration.RemunerationID,
                          Remuneration.SeminarConductID,
                          Remuneration.TotalExpence,
                          Remuneration.PaidAmount,
                          Remuneration.RemainingAmount
                      FROM Remuneration
                      INNER JOIN MST_RR_Distribution
                      ON Remuneration.RRDID = MST_RR_Distribution.RRDID
                      INNER JOIN MST_Purpose
                      ON MST_RR_Distribution.PurposeID = MST_Purpose.PurposeID
                      INNER JOIN MST_School
                      ON MST_RR_Distribution.SchoolID = MST_School.SchoolID
                      WHERE Remuneration.RemainingAmount > 0 
                      ORDER BY MST_RR_Distribution.RRDDate DESC''';
    distributionWisePendingRemuneration = await db.rawQuery(query);
    print(distributionWisePendingRemuneration);
    if(distributionWisePendingRemuneration.isNotEmpty){
      return distributionWisePendingRemuneration;
    }
    return distributionWisePendingRemuneration;
  }
}
