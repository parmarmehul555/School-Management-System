import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:school_management_system/CustomWidget/CustomeDropDown.dart';
import 'package:sizer/sizer.dart';

class Remuneration extends StatefulWidget{
  @override
  State<Remuneration> createState() => _RemunerationState();
}

class RowItem {
  String? dropdownValue;
  TextEditingController numberController = TextEditingController();
}

class _RemunerationState extends State<Remuneration> {

  TextEditingController datePickerController = TextEditingController();
  String dropdownValue = "";

  @override
  void initState() {
    datePickerController.text = DateTime.now().toString();
  }

  List<String> eventList = ["First", "Second", "Third", "Forth"];
  SingleSelectController dropdownvalue1 = SingleSelectController("First");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Remuneration"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Container(
              color: Colors.white,
              child: TextFormField(
                onTap: showDateDialog,
                controller: datePickerController,
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.date_range),
                  isDense: true,
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            CustomeDropdown(list: eventList,targetDropdownValue: "SeminarTitle",dropdownTitle:"Event",dropdownValue: dropdownvalue1,),

            SizedBox(
              height: 0.1.h,
            ),

            SizedBox(
              height: 0.1.h,
            ),
            Container(
              color: Colors.white,
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "Paid Amount",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  hintStyle: TextStyle(
                    fontSize: 14,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  alignLabelWithHint: true,
                ),
                textAlignVertical: TextAlignVertical.center, // Ensures the text is vertically centered
              ),
            ),
            SizedBox(height: 1.h,),
            ElevatedButton(onPressed: () {
              print("Value from Dropdown is ${dropdownvalue1.value}");
            }, child: Text("Save"))
          ],
        ),
      ),
    );
  }

  Future<void> showDateDialog() async {
    print("hellpw frpm funtion");
    DateTime? selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        datePickerController.text = selectedDate.toString();
      });
    }
  }
}











//
// import 'package:flutter/material.dart';
// import 'package:animated_custom_dropdown/custom_dropdown.dart';
// import 'package:school_management_system/CustomWidget/CustomeDropDown.dart';
// import 'package:sizer/sizer.dart';
//
// class Remuneration extends StatefulWidget {
//   @override
//   State<Remuneration> createState() => _RemunerationState();
// }
//
// class RowItem {
//   String? dropdownValue;
//   TextEditingController numberController = TextEditingController();
// }
//
// class _RemunerationState extends State<Remuneration> {
//   TextEditingController datePickerController = TextEditingController();
//   List<String> eventList = ["First", "Second", "Third", "Forth"];
//   SingleSelectController dropdownvalue1 = SingleSelectController("First");
//
//
//   bool showDetailsContainer = false;
//
//   @override
//   void initState() {
//     super.initState();
//     datePickerController.text = DateTime.now().toString();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Remuneration"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView(
//           children: [
//             Container(
//               color: Colors.white,
//               child: TextFormField(
//                 onTap: showDateDialog,
//                 controller: datePickerController,
//                 readOnly: true,
//                 decoration: InputDecoration(
//                   contentPadding:
//                   EdgeInsets.symmetric(vertical: 0, horizontal: 0),
//                   alignLabelWithHint: true,
//                   prefixIcon: Icon(Icons.date_range),
//                   isDense: true,
//                   border: OutlineInputBorder(),
//                   focusedBorder: OutlineInputBorder(),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 0.5.h,
//             ),
//             CustomeDropdown(
//               list: eventList,
//               dropdownTitle: "Event",
//               dropdownValue: dropdownvalue1,
//               onChanged: (value) {
//                 setState(() {
//                   dropdownvalue1.value = value;
//                   showDetailsContainer = true;
//                 });
//               },
//             ),
//             SizedBox(
//               height: 0.1.h,
//             ),
//             Container(
//               color: Colors.white,
//               child: TextFormField(
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   isDense: true,
//                   hintText: "Paid Amount",
//                   border: OutlineInputBorder(),
//                   focusedBorder: OutlineInputBorder(),
//                   hintStyle: TextStyle(
//                     fontSize: 14,
//                   ),
//                   contentPadding:
//                   EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                   alignLabelWithHint: true,
//                 ),
//                 textAlignVertical:
//                 TextAlignVertical.center
//               ),
//             ),
//             SizedBox(
//               height: 1.h,
//             ),
//             if (showDetailsContainer)
//               Container(
//                 padding: EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(
//                   color: Colors.blue.shade50,
//                   border: Border.all(color: Colors.blue.shade700),
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Event Details",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 16),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.close, color: Colors.red),
//                           onPressed: () {
//                             setState(() {
//                               showDetailsContainer = false;
//                             });
//                           },
//                         )
//                       ],
//                     ),
//                     SizedBox(height: 8.0),
//                     Text("Selected Event: ${dropdownvalue1.value}"),
//                     Text("Amount Paid: --"),
//                     Text("Date: ${datePickerController.text}"),
//                   ],
//                 ),
//               ),
//             ElevatedButton(
//               onPressed: () {
//                 print("Value from Dropdown is ${dropdownvalue1.value}");
//               },
//               child: Text("Save"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> showDateDialog() async {
//     DateTime? selectedDate = await showDatePicker(
//       context: context,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//       initialDate: DateTime.now(),
//     );
//     if (selectedDate != null) {
//       setState(() {
//         datePickerController.text = selectedDate.toString();
//       });
//     }
//   }
// }
