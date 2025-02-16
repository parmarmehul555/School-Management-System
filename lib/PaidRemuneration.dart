import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:school_management_system/CustomWidget/CustomeDropDown.dart';
import 'package:school_management_system/RRDistributionPaidRemuneration.dart';
import 'package:school_management_system/SeminarPaidRemuneration.dart';
import 'package:school_management_system/utils/theme.dart';
import 'package:sizer/sizer.dart';

import 'RR_Distribution_Pending_Remuneration.dart';
import 'Seminar_Pending_Remuneration.dart';

class PaidRemuneration extends StatefulWidget {
  const PaidRemuneration({super.key});

  @override
  State<PaidRemuneration> createState() => _PaidRemunerationState();
}

class _PaidRemunerationState extends State<PaidRemuneration>
    with TickerProviderStateMixin {
  TextEditingController datePickerController = TextEditingController();
  SingleSelectController dropdownvalue = SingleSelectController("First");

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  late final TabController _tabController;

  DateTime? fromDate;
  DateTime? toDate;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    fromDate = DateTime.now();
    toDate = DateTime.now();
    fromDateController.text = fromDate.toString().split(' ')[0];
    toDateController.text = toDate.toString().split(' ')[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paid Remuneration"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "From : ",
                  style: TextStyle(fontSize: 18.sp),
                ),
                SizedBox(
                  width: 1.w,
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: TextFormField(
                      onTap: () {
                        showDateDialog(true);
                      },
                      controller: fromDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                        alignLabelWithHint: true,
                        prefixIcon: Icon(Icons.date_range),
                        isDense: true,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              children: [
                Text(
                  "To : ",
                  style: TextStyle(fontSize: 18.sp),
                ),
                SizedBox(
                  width: 7.w,
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: TextFormField(
                      onTap: () {
                        showDateDialog(false);
                      },
                      controller: toDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                        alignLabelWithHint: true,
                        prefixIcon: Icon(Icons.date_range),
                        isDense: true,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: ColorTheme().SECONDARY_COLOR,
              indicatorColor: Colors.red,
              controller: _tabController,
              tabs: [
                Text(
                  "Seminar",
                  style: TextStyle(fontSize: 18.sp),
                ),
                Text(
                  "RR Distribution",
                  style: TextStyle(fontSize: 18.sp),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  SeminarPaidRemuneration(
                      from: fromDateController.text, to: toDateController.text),
                  RRDistributionPaidRemuneration(
                      from: fromDateController.text, to: toDateController.text),
                  // SeminarPendingRemuneration(),
                  // RRDistributionPendingRemuneration()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showDateDialog(bool isFromDate) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        if (isFromDate) {
          fromDateController.text = selectedDate.toString();
        } else {
          toDateController.text = selectedDate.toString();
        }
      });
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:school_management_system/RRDistributionPaidRemuneration.dart';
// import 'package:school_management_system/RR_Distribution_Pending_Remuneration.dart';
// import 'package:school_management_system/SeminarPaidRemuneration.dart';
// import 'package:school_management_system/Seminar_Pending_Remuneration.dart';
// import 'package:school_management_system/utils/theme.dart';
// import 'package:sizer/sizer.dart';
//
// class PaidRemuneration extends StatefulWidget {
//   const PaidRemuneration({super.key});
//
//   @override
//   State<PaidRemuneration> createState() => _PaidRemunerationState();
// }
//
// class _PaidRemunerationState extends State<PaidRemuneration>
//     with TickerProviderStateMixin {
//   TextEditingController fromDateController = TextEditingController();
//   TextEditingController toDateController = TextEditingController();
//   late final TabController _tabController;
//
//   DateTime? fromDate;
//   DateTime? toDate;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     fromDate = DateTime.now();
//     toDate = DateTime.now();
//     fromDateController.text = fromDate.toString().split(' ')[0];
//     toDateController.text = toDate.toString().split(' ')[0];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Paid Remuneration"),
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorSize: TabBarIndicatorSize.tab,
//           labelColor: ColorTheme().SECONDARY_COLOR,
//           indicatorColor: Colors.red,
//           tabs: [
//             Text("Seminar", style: TextStyle(fontSize: 18.sp)),
//             Text("RR Distribution", style: TextStyle(fontSize: 18.sp)),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 buildDatePickerRow("From: ", fromDateController, (selectedDate) {
//                   setState(() {
//                     fromDate = selectedDate;
//                     fromDateController.text = selectedDate.toString().split(' ')[0];
//                   });
//                 }),
//                 SizedBox(height: 1.h),
//                 buildDatePickerRow("To: ", toDateController, (selectedDate) {
//                   setState(() {
//                     toDate = selectedDate;
//                     toDateController.text = selectedDate.toString().split(' ')[0];
//                   });
//                 }),
//               ],
//             ),
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 SeminarPaidRemuneration(from: fromDateController.text, to: toDateController.text),
//                 RRDistributionPaidRemuneration(from: fromDateController.text, to: toDateController.text),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildDatePickerRow(
//       String label, TextEditingController controller, Function(DateTime) onDateSelected) {
//     return Row(
//       children: [
//         Text(label, style: TextStyle(fontSize: 18.sp)),
//         SizedBox(width: 2.w),
//         Expanded(
//           child: TextFormField(
//             onTap: () async {
//               DateTime? selectedDate = await showDatePicker(
//                 context: context,
//                 firstDate: DateTime(2000),
//                 lastDate: DateTime(2100),
//                 initialDate: DateTime.now(),
//               );
//               if (selectedDate != null) {
//                 onDateSelected(selectedDate);
//               }
//             },
//             controller: controller,
//             readOnly: true,
//             decoration: InputDecoration(
//               prefixIcon: Icon(Icons.date_range),
//               border: OutlineInputBorder(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
