import 'package:flutter/material.dart';
import 'package:school_management_system/CustomWidget/CustomeDropDown.dart';
import 'package:school_management_system/DB_Helper/Remuneration.dart';
import 'package:sizer/sizer.dart';

class RRDistributionPendingRemuneration extends StatefulWidget {
  const RRDistributionPendingRemuneration({super.key});

  @override
  State<RRDistributionPendingRemuneration> createState() => _RRDistributionPendingRemunerationState();
}

class _RRDistributionPendingRemunerationState extends State<RRDistributionPendingRemuneration> {
  List<dynamic> RRDistributionWisePendingRemuneration = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    var tempDistributionWisePending = await Remunerationn().selectRRDistributionWisePendingRemuneration();
  setState(() {
    RRDistributionWisePendingRemuneration = tempDistributionWisePending;
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RRDistributionWisePendingRemuneration.isNotEmpty
          ? ListView.builder(
        itemCount: RRDistributionWisePendingRemuneration.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(12.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RR Dist. Date : ${RRDistributionWisePendingRemuneration[index]['RRDDate']}',
                      style: TextStyle(fontSize: 17.sp),
                    ),
                    Text(
                      'School : ${RRDistributionWisePendingRemuneration[index]['SchoolName']}',
                      style: TextStyle(fontSize: 17.sp),
                    ),
                    Text(
                      'Purpose Title : ${RRDistributionWisePendingRemuneration[index]['PurposeTitle']}',
                      style: TextStyle(
                        fontSize: 17.sp,
                      ),
                    ),
                    Text(
                      'Total Amount : ${RRDistributionWisePendingRemuneration[index]['TotalExpence']}',
                      style: TextStyle(
                        fontSize: 17.sp,
                      ),
                    ),
                    Text(
                      'Paid Amount : ${RRDistributionWisePendingRemuneration[index]['PaidAmount']}',
                      style: TextStyle(
                          fontSize: 17.sp,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Remaining Amount : ${RRDistributionWisePendingRemuneration[index]['RemainingAmount']}',
                      style: TextStyle(
                          fontSize: 17.sp,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )
          : Center(
          child:Text("No Data Found!")
      ),
    );
  }
}
