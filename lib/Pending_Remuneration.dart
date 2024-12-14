import 'package:flutter/material.dart';
import 'package:school_management_system/Remuneration.dart';
import 'package:sizer/sizer.dart';
import 'package:sizer/sizer.dart';
import 'package:sizer/sizer.dart';
import 'package:sizer/sizer.dart';

class Pending_Remuneration extends StatelessWidget{
  List<Map<String,dynamic>> list = [
    {
      "title":"05-05-2005 | Modi | 10th",
      "total":"25,000 (NRV)",
      "paid":"20,000 (AVB)",
      "remaining":"5000"
    },
    {
      "title":"05-05-2005 | Raj | 10th",
      "total":"25,000 (NRV)",
      "paid":"20,000 (AVB)",
      "remaining":"5000"
    },
    {
      "title":"05-05-2005 | Bhushan | 10th",
      "total":"25,000 (NRV)",
      "paid":"20,000 (AVB)",
      "remaining":"5000"
    },
    {
      "title":"05-05-2005 | Shubham | 10th",
      "total":"25,000 (NRV)",
      "paid":"20,000 (AVB)",
      "remaining":"5000"
    },
    {
      "title":"05-05-2005 | Shubham | 10th",
      "total":"25,000 (NRV)",
      "paid":"20,000 (AVB)",
      "remaining":"5000"
    },
    {
      "title":"05-05-2005 | Shubham | 10th",
      "total":"25,000 (NRV)",
      "paid":"20,000 (AVB)",
      "remaining":"5000"
    },
    {
      "title":"05-05-2005 | Shubham | 10th",
      "total":"25,000 (NRV)",
      "paid":"20,000 (AVB)",
      "remaining":"5000"
    },
    {
      "title":"05-05-2005 | Shubham | 10th",
      "total":"25,000 (NRV)",
      "paid":"20,000 (AVB)",
      "remaining":"5000"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Remuneration"),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Remuneration(),)),
              child: Card(
                elevation: 5,
                shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(12.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Title : ${list[index]["title"]}',style: TextStyle(fontSize: 17.sp),),
                      Text('Total : ${list[index]["total"]}',style: TextStyle(fontSize: 17.sp),),
                      Text('Paid : ${list[index]["paid"]}',style: TextStyle(fontSize: 17.sp,color: Colors.green,fontWeight: FontWeight.bold),),
                      Text('Remaining : ${list[index]["remaining"]}',style: TextStyle(fontSize: 17.sp,color: Colors.red,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}