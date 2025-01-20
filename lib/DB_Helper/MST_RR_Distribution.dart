import 'package:school_management_system/database/SchoolVisitDB.dart';
import 'package:sqflite/sqflite.dart';

class MST_RR_Distribution {
  Future<int> insertIntoMST_RR_Distribution(Map<String, dynamic> data) async {
    Database db = await SchoolVisitDB().initDatabase();
    String q = ''' INSERT INTO MST_RR_Distribution
                      (PurposeID,SchoolID,SeminarID,InterestInCampusVisit,TotalNumberOfCopies,RRDDate) 
                      values (?,?,?,?,?,?)
    ''';
    int RRDID = await db.rawInsert(q, [
      data['PurposeID'],
      data['SchoolID'],
      data['SeminarID'],
      data['InterestInCampusVisit'],
      data['TotalNumberOfCopies'],
      data['RRDDate'],
    ]);
    return RRDID;
  }
}
