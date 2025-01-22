import 'package:school_management_system/database/SchoolVisitDB.dart';
import 'package:sqflite/sqflite.dart';

class SeminarWiseMemberDB {
  Future<void> insertSeminarWiseMember(Map<String, dynamic> data) async {
    Database db = await SchoolVisitDB().initDatabase();
    String query = '''
      INSERT INTO MST_SeminarWiseMembers
          (SeminarConductID, MemberID)
      VALUES (?, ?)
    ''';
    await db.rawInsert(query, [
      data['SeminarConductID'],
      data['MemberID'],
    ]);
  }
}
