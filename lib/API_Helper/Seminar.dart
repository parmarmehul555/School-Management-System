import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:school_management_system/Models/SeminarDDL.dart';
import 'package:school_management_system/utils/APP_Helper.dart';

class Seminar{
  Future<List<dynamic>>? SeminarSelectForDDL() async {
    List<dynamic> seminarDDL = [];
    try{
      var res = await http.get(Uri.parse('${BASE_URL}/Seminar/seminarSelectForDDL'));
      // print('============================= ${res.body}');
      if(res.statusCode == 200){
        var data = jsonDecode(res.body);
        for(var item in data){
          // SeminarDDL seminar = SeminarDDL();
          Map<String,dynamic> seminar = {
            "SeminarID" : item['seminarID'],
            "SeminarTitle" : item['seminarTitle'],
          };
          // seminar.SeminarID = item['seminarID'];
          // seminar.SeminarTitle = item['seminarTitle'];
          // print('${seminar.SeminarID} || ${seminar.SeminarTitle}');
          seminarDDL.add(seminar);
        }
        return seminarDDL;
      }
    }catch(e){
      throw Exception('Failed to load seminar dropdown list.');
    }
    return [];
  }
}