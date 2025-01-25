import 'package:school_management_system/database/SchoolVisitDB.dart';
import 'package:sqflite/sqflite.dart';

class MST_RR_Distribution {
  Future<int> insertIntoMST_RR_Distribution(Map<String, dynamic> data) async {
    Database db = await SchoolVisitDB().initDatabase();
    String q = ''' INSERT INTO MST_RR_Distribution
                      (PurposeID,SchoolID,SeminarID,InterestInCampusVisit,TotalNumberOfCopies,RRDDate,CarOwner,TotalExpence,RemainingAmount) 
                      values (?,?,?,?,?,?,?,?,?)
    ''';
    int RRDID = await db.rawInsert(q, [
      data['PurposeID'],
      data['SchoolID'],
      data['SeminarID'],
      data['InterestInCampusVisit'],
      data['TotalNumberOfCopies'],
      data['RRDDate'],
      data['CarOwner'],
      data['TotalExpence'],
      data['TotalExpence'],
    ]);
    return RRDID;
  }

  Future<List<dynamic>> selectRRDDL() async {
    List<dynamic> RRList = [];
    Database db = await SchoolVisitDB().initDatabase();
    String query = '''select RRDID,RRDDate from MST_RR_Distribution''';
    RRList = await db.rawQuery(query);
    if(RRList.isNotEmpty){
      return RRList;
    }
    return [];
  }

  Future<Map<String,dynamic>> selectAmount(int RRDID) async {
    List<dynamic> AmountList = [];
    Database db = await SchoolVisitDB().initDatabase();
    String query = '''select RRDID,TotalExpence,RemainingAmount from MST_RR_Distribution where RRDID=?''';
    AmountList = await db.rawQuery(query,[RRDID]);
    return AmountList.isNotEmpty?AmountList.first:Map();
  }

  Future<void> inserRRIDtIntoRemuneration(int RRDID) async {
    Database db = await SchoolVisitDB().initDatabase();
    await db.rawInsert('INSERT INTO Remuneration (RRDID) VALUES (?)', [RRDID]);
  }

  Future<void> updateRemainingAmountForRR(int paidAmount,int RRID) async {
    Database db = await SchoolVisitDB().initDatabase();
    String query = '''UPDATE  MST_RR_Distribution
                      SET RemainingAmount = RemainingAmount - ?
                      WHERE MST_RR_Distribution.RRDID = ?''';
    await db.rawUpdate(query,[paidAmount,RRID]);
  }
}
