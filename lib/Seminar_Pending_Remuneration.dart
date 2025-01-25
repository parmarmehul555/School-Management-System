import 'package:flutter/material.dart';
import 'package:school_management_system/CustomWidget/CustomeDropDown.dart';
import 'package:school_management_system/DB_Helper/Remuneration.dart';
import 'package:school_management_system/utils/theme.dart';
import 'package:sizer/sizer.dart';

class SeminarPendingRemuneration extends StatefulWidget {
  const SeminarPendingRemuneration({super.key});

  @override
  State<SeminarPendingRemuneration> createState() =>
      _SeminarPendingRemunerationState();
}

class _SeminarPendingRemunerationState
    extends State<SeminarPendingRemuneration> {
  List<dynamic> seminarWisePendingRemuneration = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  Future<dynamic> _loadData() async {
    var tempSeminarWisePendingRemuneration =
        await Remunerationn().selectSeminarWisePendingRemuneration();
    setState(() {
      seminarWisePendingRemuneration = tempSeminarWisePendingRemuneration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: seminarWisePendingRemuneration.isNotEmpty
            ? ListView.builder(
                itemCount: seminarWisePendingRemuneration.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 0),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(12.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Seminar Date : ${seminarWisePendingRemuneration[index]['SeminarDate']}',
                              style: TextStyle(fontSize: 17.sp),
                            ),
                            Text(
                              'School : ${seminarWisePendingRemuneration[index]['SchoolName']}',
                              style: TextStyle(fontSize: 17.sp),
                            ),
                            Text(
                              'Seminar Title : ${seminarWisePendingRemuneration[index]['SeminarTitle']}',
                              style: TextStyle(
                                  fontSize: 17.sp,),
                            ),
                            Text(
                              'Total Amount : ${seminarWisePendingRemuneration[index]['TotalAmount']}',
                              style: TextStyle(
                                fontSize: 17.sp,
                              ),
                            ),
                            Text(
                              'Paid Amount : ${seminarWisePendingRemuneration[index]['PaidAmount']}',
                              style: TextStyle(
                                fontSize: 17.sp,
                                color: Colors.green,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              'Remaining Amount : ${seminarWisePendingRemuneration[index]['RemainingAmount']}',
                              style: TextStyle(
                                  fontSize: 17.sp,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(
                color: ColorTheme().PRIMARY_COLOR,
              )));
  }
}
