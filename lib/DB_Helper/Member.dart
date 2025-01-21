import 'package:school_management_system/database/SchoolVisitDB.dart';
import 'package:sqflite/sqflite.dart';

class Member{
  Future<List<dynamic>> selectMemberDDL() async {
    List<dynamic> memberList = [];
    Database db = await SchoolVisitDB().initDatabase();
    String query = '''select MemberID,MemberName from MST_Member''';
    memberList = await db.rawQuery(query);
    if(memberList.isNotEmpty){
      return memberList;
    }
    return [];
  }
}