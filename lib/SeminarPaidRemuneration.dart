import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SeminarPaidRemuneration extends StatefulWidget {
  String? from;
  String? to;
  SeminarPaidRemuneration({required this.from,required this.to});

  @override
  State<SeminarPaidRemuneration> createState() => _SeminarPaidRemunerationState();
}

class _SeminarPaidRemunerationState extends State<SeminarPaidRemuneration> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("From date is ${widget.from} && To date is ${widget.to}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 1,
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
                      'Seminar Date : Nothing}',
                      style: TextStyle(fontSize: 17.sp),
                    ),
                    Text(
                      'School : Nothing}',
                      style: TextStyle(fontSize: 17.sp),
                    ),
                    Text(
                      'Seminar Title : Nothing}',
                      style: TextStyle(
                        fontSize: 17.sp,
                      ),
                    ),
                    Text(
                      'Total Amount : Nothing}',
                      style: TextStyle(
                        fontSize: 17.sp,
                      ),
                    ),
                    Text(
                      'Paid Amount : Nothing}',
                      style: TextStyle(
                          fontSize: 17.sp,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Remaining Amount : Nothing}',
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
    );
  }
}
