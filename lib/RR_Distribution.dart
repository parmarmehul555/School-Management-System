import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:school_management_system/CustomWidget/CustomeDropDown.dart';
import 'package:school_management_system/DB_Helper/MST_Course.dart';
import 'package:school_management_system/DB_Helper/MST_CourseWiseStudents.dart';
import 'package:school_management_system/DB_Helper/MST_RR_Distribution.dart';
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
  SingleSelectController? dropdownValue;
  TextEditingController numberController = TextEditingController();

  RowItem({this.dropdownValue, TextEditingController? controller})
      : numberController = controller ?? TextEditingController();
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
  List<dynamic> courseDropdownList = [];
  SingleSelectController SingleDropDownValue = SingleSelectController("");
  Map<String, dynamic> collectedData = Map();

  // List to hold rows
  List<RowItem> rowItems = [RowItem(dropdownValue: SingleSelectController(""))];

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

  SingleSelectController purposeController = SingleSelectController("First");
  SingleSelectController schoolController = SingleSelectController("First");
  SingleSelectController reasonController = SingleSelectController("First");
  TextEditingController totalNumberOfCopiesController = TextEditingController();

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
                    dropdownValue: purposeController,
                    targetDropdownValue: "PurposeTitle",
                    targetID: 'PurposeID',
                    onChanged: (PurposeID) {
                      setState(() {
                        collectedData["PurposeID"] = PurposeID;
                      });
                    },
                  ),
                  CustomeDropdown(
                    list: schoolList,
                    dropdownTitle: "Select School",
                    dropdownValue: schoolController,
                    targetDropdownValue: "SchoolShortName",
                    targetID: 'SchoolID',
                    onChanged: (SchoolID) {
                      setState(() {
                        collectedData["SchoolID"] = SchoolID;
                      });
                    },
                  ),
                  CustomeDropdown(
                    list: reasonList,
                    dropdownTitle: "Select Reason",
                    dropdownValue: reasonController,
                    targetDropdownValue: "SeminarTitle",
                    targetID: 'SeminarID',
                    onChanged: (SeminarID) {
                      setState(() {
                        collectedData["SeminarID"] = SeminarID;
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
                                  collectedData["InterestInCampusVisit"] = 1;
                                });
                              },
                              child: Text("YES")),
                          RadioMenuButton(
                              value: "NO",
                              groupValue: radioButtonValue,
                              onChanged: (value) {
                                setState(() {
                                  radioButtonValue = value!;
                                  collectedData["InterestInCampusVisit"] = 0;
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
                      controller: totalNumberOfCopiesController,
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
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          rowItems.add(RowItem(dropdownValue: null));
                        });
                      },
                      child: Text("Add")),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: rowItems.length,
                    itemBuilder: (context, index) {
                      print(rowItems[index].dropdownValue?.value);
                      return Padding(
                        padding: EdgeInsets.only(top: 2.0.pt),
                        child: rowItems.length > 1
                            ? SwipeActionCell(
                                key: ObjectKey(index),
                                trailingActions: <SwipeAction>[
                                  SwipeAction(
                                    performsFirstActionWithFullSwipe: true,
                                    title: "Delete",
                                    onTap: (CompletionHandler handler) async {
                                      setState(() {
                                        courseDropdownList.removeAt(index);
                                        print(
                                            "Removed item from list is $courseDropdownList");
                                        rowItems.removeAt(index);
                                      });
                                    },
                                    color: Colors.red,
                                  ),
                                ],
                                child: Row(
                                  children: [
                                    // Dropdown
                                    Expanded(
                                        flex: 1,
                                        child: CustomeDropdown(
                                          list: courseList,
                                          dropdownTitle: "Std.",
                                          dropdownValue:
                                              rowItems[index].dropdownValue,
                                          targetDropdownValue: "CourseName",
                                          onChanged: (newValue) {
                                            setState(() {
                                              if (index <
                                                  courseDropdownList.length) {
                                                courseDropdownList[index] =
                                                    newValue;
                                              } else {
                                                courseDropdownList
                                                    .add(newValue);
                                              }
                                            });
                                            print(courseDropdownList);
                                          },
                                          targetID: 'CourseID',
                                        )),
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
                                            hintText: "Enter number",
                                            hintStyle: TextStyle(fontSize: 14),
                                            border: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                    horizontal: 8.0),
                                            alignLabelWithHint: true,
                                          ),
                                          onChanged: (value) {
                                            // Optional: Keep track of text changes
                                            rowItems[index]
                                                .numberController
                                                .text = value;
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
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
                                      dropdownValue:
                                          rowItems[index].dropdownValue,
                                      targetDropdownValue: "CourseName",
                                      onChanged: (newValue) {
                                        setState(() {
                                          print(
                                              'aslkdjfal;ksdjlf;jasl;djfl;jas;djlf;j;asdj;fj;alsdjlfj; $newValue');
                                          print(
                                              "Before Update: ${rowItems[index].dropdownValue?.value}");
                                          rowItems[index].dropdownValue =
                                              SingleSelectController(newValue);
                                          print(
                                              "After Update: ${rowItems[index].dropdownValue?.value}");
                                          courseDropdownList[index] = newValue;
                                          print(
                                              'Heloo list is is sis $courseDropdownList');
                                        });
                                      },
                                      targetID: '',
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
                                          hintText: "Enter number",
                                          hintStyle: TextStyle(fontSize: 14),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 13.0.sp,
                                              horizontal: 13.0.sp),
                                          alignLabelWithHint: true,
                                        ),
                                        onChanged: (value) {
                                          rowItems[index]
                                              .numberController
                                              .text = value;
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                ],
                              ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        String date = datePickerController.text.split(" ")[0];
                        var dt = date.split("-");
                        DateTime selectedDate = DateTime(int.parse(dt[0]),
                            int.parse(dt[1]), int.parse(dt[2]));
                        String formattedDate =
                            "${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.year}";
                        print('Splitted date $formattedDate');
                        setState(() {
                          collectedData["TotalNumberOfCopies"] =
                              totalNumberOfCopiesController.text;
                          collectedData["RRDDate"] = formattedDate;
                        });
                        print(collectedData);
                        // print("Value from Dropdown is ${purposeController.value}");
                        // print("Value from Dropdown is ${schoolController.value}");
                        // print("Value from Dropdown is ${reasonController.value}");
                        // var data2 = {
                        //   "RRDDate":datePickerController.text,
                        //   "purpose":purposeController.value,
                        //   "school":schoolController.value,
                        //   "reason":reasonController.value,
                        //   "copies":totalNumberOfCopiesController.text
                        // };
                        print(courseDropdownList);
                        // print("Data is $data2");
                        for (int i = 0; i < rowItems.length; i++) {
                          var data = {
                            "CourseID": courseDropdownList[i],
                            "TotalStudent": rowItems[i].numberController.text
                          };
                          int insertedID = await MST_CourseWiseStudents()
                              .insertIntoMST_CourseWiseStudents(data);
                          setState(() {
                            collectedData['CourseWiseStudentID'] = insertedID;
                          });
                          print(collectedData);
                        await MST_RR_Distribution()
                            .insertIntoMST_RR_Distribution(collectedData);
                        }
                      },
                      child: Text("Save"))
                ],
              )
            : Center(
                child: CircularProgressIndicator(
                color: ColorTheme().PRIMARY_COLOR,
              )),
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
