import 'package:school_management_system/database/SchoolVisitDB.dart';
import 'package:sqflite/sqflite.dart';

class MST_Remuneration {
  Future<void> insertInRemuneration(Map<String, dynamic> data) async {
    print("Hello");
    Database db = await SchoolVisitDB().initDatabase();
    String query =
        '''INSERT INTO MST_Remuneration (SeminarConductID,RemunerationPaidDate,AmountPaid,AmountGivenTo) VALUES (?,?,?,?)''';
    await db.rawQuery(query,[data['SeminarConductID'],data['RemunerationPaidDate'],data['AmountPaid'],data['AmountGivenTo']]);
  }
}
