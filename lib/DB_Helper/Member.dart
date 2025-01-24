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

  Future<List<dynamic>> selectMemberBySeminarConductID(int seminarConductID) async {
    List<dynamic> memberList = [];
    Database db = await SchoolVisitDB().initDatabase();
    String query = '''SELECT 
                        MST_Member.MemberID,
                        MST_Member.MemberName,
                        MST_SeminarWiseMembers.SeminarConductID
                      FROM MST_SeminarWiseMembers
                      INNER JOIN MST_Member
                      ON MST_SeminarWiseMembers.MemberID = MST_Member.MemberID
                      WHERE MST_SeminarWiseMembers.SeminarConductID = ?''';
    memberList = await db.rawQuery(query,[seminarConductID]);
    if(memberList.isNotEmpty){
      return memberList;
    }
    return memberList;
  }
}