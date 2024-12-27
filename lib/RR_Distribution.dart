import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:school_management_system/CustomWidget/CustomeDropDown.dart';
import 'package:school_management_system/DB_Helper/MST_Course.dart';
import 'package:school_management_system/DB_Helper/Purpose.dart';
import 'package:school_management_system/DB_Helper/School.dart';
import 'package:school_management_system/DB_Helper/Seminar.dart';
import 'package:school_management_system/utils/theme.dart';
import 'package:sizer/sizer.dart';

class RR_Distribution extends StatefulWidget {
  const RR_Distribution({super.key});

  @override
  State<RR_Distribution> createState() => _RR_DistributionState();
}

class RowItem {
  String? dropdownValue;
  TextEditingController numberController = TextEditingController();
}

class _RR_DistributionState extends State<RR_Distribution> {
  bool isLoading = true;
  TextEditingController datePickerController = TextEditingController();
  String radioButtonValue = "YES";
  String dropdownValue = "";
  List<dynamic> reasonList = [];
  List<dynamic> purposeList = [];
  List<dynamic> schoolList = [];
  List<dynamic> courseList = [];

  // List to hold rows
  List<RowItem> rowItems = [RowItem()];

  // List of dropdown items
  // List<String> purposeeList = ["10th", "12th-A", "12th-B"];

  @override
  void initState() {
    // TODO: implement initStatecolor: ColorTheme().PRIMARY_COLOR,
    _loadData();
    print(reasonList);
    datePickerController.text = DateTime.now().toString();
  }

  Future<void> _loadData() async {
    var tempReasonList = await Seminar().seminarSelectForDDL()!;
    var tempPurposeList = await Purpose().selectPurposeDDL();
    var tempSchoolList = await School().selectSchoolDDL();
    var tempCourseList = await MST_Course().selectCourseDDL();
    setState(() {
      reasonList = tempReasonList;
      purposeList = tempPurposeList;
      schoolList = tempSchoolList;
      courseList = tempCourseList;
    });
    isLoading = false;
  }

  SingleSelectController dropdownvalue1 = SingleSelectController("First");
  SingleSelectController dropdownvalue2 = SingleSelectController("First");
  SingleSelectController dropdownvalue3 = SingleSelectController("First");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RR Distribution"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: !isLoading
            ? ListView(
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
                    list: purposeList,
                    dropdownTitle: "Select Purpose",
                    dropdownValue: dropdownvalue1,
                    targetDropdownValue: "PurposeTitle",
                  ),
                  CustomeDropdown(
                    list: schoolList,
                    dropdownTitle: "Select School",
                    dropdownValue: dropdownvalue2,
                    targetDropdownValue: "SchoolShortName",
                  ),
                  CustomeDropdown(
                    list: reasonList,
                    dropdownTitle: "Select Reason",
                    dropdownValue: dropdownvalue3,
                    targetDropdownValue: "SeminarTitle",
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
                        "Interested in campus visit ?",
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      Row(
                        children: [
                          RadioMenuButton(
                              value: "YES",
                              groupValue: radioButtonValue,
                              onChanged: (value) {
                                setState(() {
                                  radioButtonValue = value!;
                                });
                              },
                              child: Text("YES")),
                          RadioMenuButton(
                              value: "NO",
                              groupValue: radioButtonValue,
                              onChanged: (value) {
                                setState(() {
                                  radioButtonValue = value!;
                                });
                              },
                              child: Text("NO")),
                        ],
                      )
                    ],
                  ),
                  Container(
                    color: Colors.white,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Enter total number of copies",
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: rowItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(top: 2.0.pt),
                        child: rowItems.length > 1
                            ? SwipeActionCell(
                                key: ObjectKey(rowItems[index]),
                                trailingActions: <SwipeAction>[
                                  SwipeAction(
                                      performsFirstActionWithFullSwipe: true,
                                      title: "Delete",
                                      onTap: (CompletionHandler handler) async {
                                        rowItems.removeAt(index);
                                        setState(() {});
                                      },
                                      color: Colors.red),
                                ],
                                child: Row(
                                  children: [
                                    // Dropdown
                                    Expanded(
                                      flex: 1,
                                      child: CustomeDropdown(
                                        list: courseList,
                                        dropdownTitle: "Std.",
                                        dropdownValue: dropdownvalue1,
                                        targetDropdownValue: "CourseName",
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    // TextFormField for number input
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        color: Colors.white,
                                        child: TextFormField(
                                          controller:
                                              rowItems[index].numberController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            // Makes the TextField more compact
                                            hintText: "Enter number",
                                            hintStyle: TextStyle(fontSize: 14),
                                            // Adjusts the font size of the hint text
                                            border: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(),
                                            // Defines the border when focused
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                    horizontal: 8.0),
                                            // Adjust padding to control height
                                            alignLabelWithHint:
                                                true, // Aligns the label with the hint text
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    // + Button
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        setState(() {
                                          rowItems.insert(index + 1, RowItem());
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : Row(
                                children: [
                                  // Dropdown
                                  Expanded(
                                    flex: 2,
                                    child: CustomeDropdown(
                                      list: courseList,
                                      dropdownTitle: "Std.",
                                      dropdownValue: dropdownvalue1,
                                      targetDropdownValue: "CourseName",
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  // TextFormField for number input
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      color: Colors.white,
                                      child: TextFormField(
                                        controller:
                                            rowItems[index].numberController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          // Makes the TextField more compact
                                          hintText: "Enter number",
                                          hintStyle: TextStyle(fontSize: 14),
                                          // Adjusts the font size of the hint text
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(),
                                          // Defines the border when focused
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 13.0.sp,
                                              horizontal: 13.0.sp),
                                          // Adjust padding to control height
                                          alignLabelWithHint:
                                              true, // Aligns the label with the hint text
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  // + Button
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        rowItems.insert(index + 1, RowItem());
                                      });
                                    },
                                  ),
                                ],
                              ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        print("Value from Dropdown is ${dropdownvalue1.value}");
                        print("Value from Dropdown is ${dropdownvalue2.value}");
                        print("Value from Dropdown is ${dropdownvalue3.value}");
                      },
                      child: Text("Save"))
                ],
              )
            : Center(child: CircularProgressIndicator(color: ColorTheme().PRIMARY_COLOR,)),
      ),
    );
  }

  Future<void> showDateDialog() async {
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
