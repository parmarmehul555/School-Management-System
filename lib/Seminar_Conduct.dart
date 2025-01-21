import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:school_management_system/CustomWidget/CustomeDropDown.dart';
import 'package:school_management_system/DB_Helper/Member.dart';
import 'package:school_management_system/DB_Helper/School.dart';
import 'package:school_management_system/DB_Helper/Seminar.dart';
import 'package:school_management_system/utils/theme.dart';
import 'package:sizer/sizer.dart';

import 'DB_Helper/SeminarWiseMember.dart';
import 'DB_Helper/Seminar_Conduct.dart';

class Seminar_Conduct extends StatefulWidget {
  @override
  State<Seminar_Conduct> createState() => _Seminar_ConductState();
}

class RowItem {
  SingleSelectController? dropdownValue;
  TextEditingController numberController = TextEditingController();

  RowItem({this.dropdownValue, TextEditingController? controller})
      : numberController = controller ?? TextEditingController();
}

class _Seminar_ConductState extends State<Seminar_Conduct> {
  bool isLoading = true;
  TextEditingController datePickerController = TextEditingController();
  String dropdownValue = "";
  List<dynamic> seminarList = [];
  List<dynamic> memberList = [];
  List<dynamic> schoolList = [];
  List<dynamic> memberDropdownLIst = [];
  List<dynamic> seminarWiseMember = [];
  bool isDataInserting = false;
  Map<String, dynamic> collectedData = Map();

  TextEditingController otherMemberController = TextEditingController();
  TextEditingController totalTeacherController = TextEditingController();
  TextEditingController totalStudentController = TextEditingController();
  TextEditingController totalExpenceController = TextEditingController();



  TextEditingController valueController = TextEditingController();
  SingleSelectController SingleDropDownValue = SingleSelectController("");

  List<RowItem> rowItems = [RowItem()];

  @override
  void initState() {
    datePickerController.text = DateTime.now().toString();
    _loadData();
  }

  Future<void> _loadData() async {
    var tempPurposeList = await Seminar().seminarSelectForDDL()!;
    var tempMemberList = await Member().selectMemberDDL()!;
    var tempSchoolList = await School().selectSchoolDDL()!;
    setState(() {
      seminarList = tempPurposeList;
      memberList=tempMemberList;
      schoolList=tempSchoolList;
    });
    isLoading = false;
  }

  SingleSelectController topicController = SingleSelectController("First");
  SingleSelectController memberController = SingleSelectController("First");
  SingleSelectController schoolController = SingleSelectController("First");
  SingleSelectController carOwnerController = SingleSelectController("First");
  SingleSelectController dropdownvalue5 = SingleSelectController("First");
  SingleSelectController dropdownvalue6 = SingleSelectController("First");
  SingleSelectController dropdownvalue7 = SingleSelectController("First");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seminar Conduct"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: !isLoading ?  ListView(
          children: [
            Container(
              color: Colors.white,
              child: TextFormField(
                onTap: showDateDialog,
                controller: datePickerController,
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
            SizedBox(
              height: 0.5.h,
            ),
            CustomeDropdown(
              list: seminarList,
              dropdownValue: topicController,
              targetDropdownValue: "SeminarTitle",
              dropdownTitle: "Topic",
              targetID: 'SeminarID',
              onChanged: (topicDetail) {
                setState(() {
                  collectedData["SeminarID"] = topicDetail['SeminarID'];
                });
              },
            ),
            CustomeDropdown(
              list: memberList,
              dropdownValue: memberController,
              targetDropdownValue: "MemberName",
              dropdownTitle: "Speaker",
              targetID: 'MemberID',
              onChanged: (speakerDetail) {
                setState(() {
                  collectedData["MemberID"] = speakerDetail['MemberID'];
                });
              },
            ),
            CustomeDropdown(
              list: schoolList,
              dropdownValue: schoolController,
              targetDropdownValue: "SchoolShortName",
              dropdownTitle: "School",
              targetID: 'SchoolID',
              onChanged: (schoolDetail) {
                setState(() {
                  collectedData["SchoolID"] = schoolDetail['SchoolID'];
                });
              },
            ),

            SizedBox(
              height: 0.1.h,
            ),

            SizedBox(
              height: 0.1.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Members",
                  style: TextStyle(fontSize: 18.sp),
                ),
              ],
            ),
            Row(
              children: [
                // Dropdown
                Expanded(
                    flex: 2,
                    child: CustomeDropdown(
                      list: memberList,
                      dropdownTitle: "Member",
                      dropdownValue: SingleDropDownValue.value == null
                          ? SingleSelectController("")
                          : SingleDropDownValue,
                      targetDropdownValue: "MemberName",
                      onChanged: (memberDetail) {
                        print("From dropdown $memberDetail");
                        memberDropdownLIst.add(memberDetail['MemberID']);
                      },
                      targetID: 'MemberID',
                    )),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      var temp = {
                        "MemberName": SingleDropDownValue.value,
                      };
                      seminarWiseMember.add(temp);
                      print('After Clicking Add:: $seminarWiseMember && $memberDropdownLIst');
                      SingleDropDownValue.value = "";
                      valueController.text = "";
                    });
                  },
                  child: Icon(Icons.add),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: seminarWiseMember.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      child: Card(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(seminarWiseMember[index]['MemberName']),
                          trailing: GestureDetector(
                              onTap: () {
                                setState(() {
                                  memberDropdownLIst.removeAt(index);
                                  seminarWiseMember.removeAt(index);
                                  print(
                                      "After Deletion : $seminarWiseMember && $memberDropdownLIst");
                                });
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                          dense: true,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            Container(
              color: Colors.white,
              child: TextFormField(
                controller: otherMemberController,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "Other Members",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  hintStyle: TextStyle(
                    fontSize: 14,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  alignLabelWithHint: true,
                ),
                textAlignVertical: TextAlignVertical
                    .center, // Ensures the text is vertically centered
              ),
            ),
            SizedBox(
              height: 0.3.h,
            ),
            Container(
              color: Colors.white,
              child: TextFormField(
                controller: totalTeacherController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "Total Teacher",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  hintStyle: TextStyle(
                    fontSize: 14,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  alignLabelWithHint: true,
                ),
                textAlignVertical: TextAlignVertical
                    .center, // Ensures the text is vertically centered
              ),
            ),
            SizedBox(
              height: 0.3.h,
            ),
            Container(
              color: Colors.white,
              child: TextFormField(
                controller: totalStudentController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "Total Student",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  hintStyle: TextStyle(
                    fontSize: 14,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  alignLabelWithHint: true,
                ),
                textAlignVertical: TextAlignVertical
                    .center, // Ensures the text is vertically centered
              ),
            ),
            SizedBox(
              height: 0.3.h,
            ),
            // Container(
            //   color: Colors.white,
            //   child: TextFormField(
            //     keyboardType: TextInputType.number,
            //     decoration: InputDecoration(
            //       isDense: true,
            //       hintText: "Car Owners",
            //       border: OutlineInputBorder(),
            //       focusedBorder: OutlineInputBorder(),
            //       hintStyle: TextStyle(
            //         fontSize: 14,
            //       ),
            //       contentPadding:
            //           EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            //       alignLabelWithHint: true,
            //     ),
            //     textAlignVertical: TextAlignVertical
            //         .center, // Ensures the text is vertically centered
            //   ),
            // ),
            CustomeDropdown(
              list: memberList,
              dropdownValue: carOwnerController,
              targetDropdownValue: "MemberName",
              dropdownTitle: "Car Owner",
              targetID: 'MemberID',
              onChanged: (speakerDetail) {
                setState(() {
                  collectedData["CarOwner"] = speakerDetail['MemberID'];
                });
              },
            ),
            SizedBox(
              height: 0.3.h,
            ),
            Container(
              color: Colors.white,
              child: TextFormField(
                controller: totalExpenceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "total expense",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  hintStyle: TextStyle(
                    fontSize: 14,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  alignLabelWithHint: true,
                ),
                textAlignVertical: TextAlignVertical
                    .center, // Ensures the text is vertically centered
              ),
            ),
            SizedBox(
              height: 0.3.h,
            ),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isDataInserting = true;
                  });
                  String date = datePickerController.text.split(" ")[0];
                  var dt = date.split("-");
                  DateTime selectedDate = DateTime(int.parse(dt[0]),
                      int.parse(dt[1]), int.parse(dt[2]));
                  String formattedDate =
                      "${selectedDate.day.toString().padLeft(
                      2, '0')}-${selectedDate.month.toString().padLeft(
                      2, '0')}-${selectedDate.year}";
                  setState(() {
                    collectedData["SeminarDate"] = formattedDate;
                    collectedData["OtherMember"] = otherMemberController.text;
                    collectedData["TotalTeacher"] = totalTeacherController.text;
                    collectedData["TotalStudent"] = totalStudentController.text;
                    collectedData["TotalExpence"] = totalExpenceController.text;
                  });

                  print("+++++++++++++${collectedData}");


                  int seminarID = await SeminarConduct().insertSeminarConduct(collectedData);
                  var snackBar;
                  for (int i = 0; i < memberDropdownLIst.length; i++) {
                    try {
                      var data = {
                        "SeminarConduct": seminarID,
                        "MemberID":memberDropdownLIst[i]
                      };
                      await SeminarWiseMemberDB().insertSeminarWiseMember(data);
                      snackBar = SnackBar(
                        content: Text("Record Saved Successfully..!"),);
                    } catch (e) {
                      snackBar = SnackBar(content: Text("Something Went Worng..!"),);
                      setState(() {
                        isDataInserting = false;
                      });
                    }
                  }
                  setState(() {
                    isDataInserting = false;
                  });
                  if (!isDataInserting) {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: isDataInserting ? CircularProgressIndicator(
                  color: ColorTheme().PRIMARY_COLOR,) : Text("Save"))
          ],
        ) : Center(child: CircularProgressIndicator(color: ColorTheme().PRIMARY_COLOR,)),
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
