import 'package:school_management_system/database/SchoolVisitDB.dart';
import 'package:sqflite/sqflite.dart';

class Remunerationn {
  Future<void> insertIntoRemuneration(Map<String, dynamic> data) async {
    Database db = await SchoolVisitDB().initDatabase();
    String query = '''INSERT INTO Remuneration (TotalAmount, RemainingAmount, SeminarConductID) VALUES (?, ?, ?)''';
    await db.rawInsert(query, [data['TotalAmount'], data['RemainingAmount'], data['SeminarConductID']]);
  }

  Future<void> insertIntoRemunerationFromRRD(Map<String, dynamic> data) async {
    Database db = await SchoolVisitDB().initDatabase();
    String query = '''INSERT INTO Remuneration (TotalAmount, RemainingAmount, RRDID) VALUES (?, ?, ?)''';
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
    String query = '''SELECT RemainingAmount FROM Remuneration WHERE RRDID = ?''';
    list = await db.rawQuery(query,[RRID]);
    return list.isNotEmpty ? list.first : Map();
  }
}
