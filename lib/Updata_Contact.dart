// import 'package:animated_custom_dropdown/custom_dropdown.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'CustomWidget/CustomeDropDown.dart';
//
// class Updata_Contact extends StatefulWidget{
//   @override
//   State<Updata_Contact> createState() => _Updata_ContactState();
// }
//
// class _Updata_ContactState extends State<Updata_Contact> {
//   TextEditingController datePickerController = TextEditingController();
//   String dropdownValue = "";
//
//   @override
//   void initState() {
//     datePickerController.text = DateTime.now().toString();
//   }
//
//   List<String> schoolList = ["modi", "shubham", "dholakiya"];
//   SingleSelectController dropdownvalue1 = SingleSelectController("First");
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
//             CustomeDropdown(list: schoolList,dropdownTitle:"School",dropdownValue: dropdownvalue1,),
//             SizedBox(height: 1.h,),
//             ElevatedButton(onPressed: () {
//               print("Value from Dropdown is ${dropdownvalue1.value}");
//             }, child: Text("Save"))
//           ],
//         ),
//       ),
//     );
//   }
// }














import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'CustomWidget/CustomeDropDown.dart';

class Updata_Contact extends StatefulWidget {
  @override
  State<Updata_Contact> createState() => _Updata_ContactState();
}

class _Updata_ContactState extends State<Updata_Contact> {
  TextEditingController datePickerController = TextEditingController();
  bool showDetailsContainer = false;

  List<String> schoolList = ["modi", "shubham", "dholakiya"];
  SingleSelectController dropdownvalue1 = SingleSelectController("First");

  // TextField controllers
  TextEditingController staffController = TextEditingController(text: "abc");
  TextEditingController clerkController = TextEditingController(text: "xyz");

  // Read-only control
  bool isStaffEditable = false;
  bool isClerkEditable = false;

  @override
  void initState() {
    super.initState();
    datePickerController.text = DateTime.now().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade700,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            CustomeDropdown(
              list: schoolList,
              dropdownTitle: "School",
              dropdownValue: dropdownvalue1,targetDropdownValue: "SeminarTitle",
            ),
            SizedBox(height: 1.h),
            if (!showDetailsContainer) ...[
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue.shade700),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Staff Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Staff:",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: TextField(
                            controller: staffController,
                            readOnly: !isStaffEditable,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white70,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade600,
                          ),
                          onPressed: () {
                            setState(() {
                              isStaffEditable = !isStaffEditable;
                            });
                          },
                          child: Text(
                            isStaffEditable ? "Save" : "Edit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Clerk:",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: TextField(
                            controller: clerkController,
                            readOnly: !isClerkEditable,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white70,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade600,
                          ),
                          onPressed: () {
                            setState(() {
                              isClerkEditable = !isClerkEditable;
                            });
                          },
                          child: Text(
                            isClerkEditable ? "Save" : "Edit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: 1.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                padding: EdgeInsets.symmetric(vertical: 1.5.h),
              ),
              onPressed: () {
                // setState(() {
                //   showDetailsContainer = true; // Show container on Save
                // });
              },
              child: Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
