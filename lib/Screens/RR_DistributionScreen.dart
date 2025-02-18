import 'dart:math';

import 'package:flutter/material.dart';
import 'package:school_management_system/CustomWidget/CustomeBottomSheetDropdown.dart';
import 'package:school_management_system/CustomWidget/CustomeTextField.dart';
import 'package:school_management_system/DB_Helper/MST_Course.dart';
import 'package:school_management_system/DB_Helper/MST_CourseWiseStudents.dart';
import 'package:school_management_system/DB_Helper/MST_RR_Distribution.dart';
import 'package:school_management_system/DB_Helper/Member.dart';
import 'package:school_management_system/DB_Helper/Purpose.dart';
import 'package:school_management_system/DB_Helper/School.dart';
import 'package:school_management_system/DB_Helper/Seminar.dart';
import 'package:school_management_system/utils/alertDialog.dart';
import 'package:school_management_system/utils/snackbar.dart';
import 'package:school_management_system/utils/theme.dart';
import 'package:sizer/sizer.dart';

class RrDistributionScreen extends StatefulWidget {
  const RrDistributionScreen({super.key});

  @override
  State<RrDistributionScreen> createState() => _RrDistributionScreenState();
}

class _RrDistributionScreenState extends State<RrDistributionScreen> {
  String? selectedCategory;
  String? courseName;
  String? purposeName;
  String? schoolName;
  String? reasonName;
  int totalStudent = 0;
  int selectedCourseID = 0;

  DateTime? date;

  bool isDataInserting = false;

  final List<String> categories = ["Food", "Travel"];
  List<String> filteredCategories = [];
  List<dynamic> reasonList = [];
  List<dynamic> purposeList = [];
  List<dynamic> schoolList = [];
  List<dynamic> courseList = [];
  List<dynamic> memberList = [];
  List<dynamic> courseDropdownList = [];
  List<dynamic> courseWiseStudent = [];

  bool isLoading = false;
  String radioButtonValue = "YES";
  TextEditingController totalNumberOfCopiesController = TextEditingController();
  TextEditingController selectedDate = TextEditingController();
  TextEditingController courseWiseStudentTotalController =
      TextEditingController();

  Map<String, dynamic> collectedData = {};

  @override
  void initState() {
    super.initState();
    isLoading = true;
    filteredCategories = categories;
    DateTime currentDate = DateTime.now();
    date = currentDate;
    selectedDate.text =
        '${currentDate.day.toString().padLeft(2, '0')}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.year}';
    _loadData();
    isLoading = false;
  }

  String? selectedValue;

  Future<void> _loadData() async {
    var tempMemberList = await Member().selectMemberDDL();
    var tempReasonList = await Seminar().seminarSelectForDDL();
    var tempPurposeList = await Purpose().selectPurposeDDL();
    var tempSchoolList = await School().selectSchoolDDL();
    var tempCourseList = await MST_Course().selectCourseDDL();
    setState(() {
      reasonList = tempReasonList;
      purposeList = tempPurposeList;
      schoolList = tempSchoolList;
      courseList = tempCourseList;
      memberList = tempMemberList;
    });
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RR Distribution"),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: ColorTheme().PRIMARY_COLOR,
            ))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Container(
                    color: Colors.white,
                    child: TextFormField(
                      controller: selectedDate,
                      readOnly: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.date_range_rounded,
                          color: ColorTheme().PRIMARY_COLOR,
                        ),
                        isDense: true,
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                      ),
                      onTap: () {
                        _selectDateRange(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  CustomeBottomSheetDropdown(
                    list: purposeList,
                    selectedValue: purposeName,
                    listAccessName: 'PurposeTitle',
                    listAccessKey: 'PurposeID',
                    bottomSheetTitle: 'Purpose',
                    dropdownTitle: "Select Purpose",
                    icon: Icons.account_tree_outlined,
                    iconColor: ColorTheme().PRIMARY_COLOR,
                    onItemSelected: (purposeDetail) {
                      setState(() {
                        collectedData["PurposeID"] = purposeDetail['PurposeID'];
                        purposeName = purposeDetail["PurposeTitle"];
                      });
                    },
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  CustomeBottomSheetDropdown(
                    list: schoolList,
                    selectedValue: schoolName,
                    listAccessName: 'SchoolWithCity',
                    listAccessKey: 'SchoolID',
                    bottomSheetTitle: 'School',
                    dropdownTitle: "Select School",
                    icon: Icons.apartment,
                    iconColor: ColorTheme().PRIMARY_COLOR,
                    onItemSelected: (schoolDetail) {
                      setState(() {
                        collectedData["SchoolID"] = schoolDetail['SchoolID'];
                        schoolName = schoolDetail["SchoolWithCity"];
                      });
                    },
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  CustomeBottomSheetDropdown(
                    list: reasonList,
                    selectedValue: reasonName,
                    listAccessName: 'SeminarTitle',
                    listAccessKey: 'SeminarID',
                    bottomSheetTitle: 'Reason',
                    dropdownTitle: "Select Reason",
                    icon: Icons.help,
                    iconColor: ColorTheme().PRIMARY_COLOR,
                    onItemSelected: (seminarDetail) {
                      setState(() {
                        collectedData["SeminarID"] = seminarDetail['SeminarID'];
                        reasonName = seminarDetail["SeminarTitle"];
                      });
                    },
                  ),
                  SizedBox(
                    height: 0.5.h,
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
                  SizedBox(
                    height: 0.5.h,
                  ),
                  CustomeTextField(
                    controller: totalNumberOfCopiesController,
                    icon: Icons.numbers,
                    iconColor: ColorTheme().PRIMARY_COLOR,
                    hintText: "Enter Total Number Of Copies",
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Text(
                    "Course Wise Students",
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  SizedBox(
                    width: double.infinity, // Ensures width is defined
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              CustomeBottomSheetDropdown(
                                list: courseList,
                                selectedValue: courseName,
                                listAccessName: 'CourseName',
                                listAccessKey: 'CourseID',
                                bottomSheetTitle: 'Standard',
                                dropdownTitle: "Select Course",
                                icon: Icons.account_tree_outlined,
                                iconColor: ColorTheme().PRIMARY_COLOR,
                                onItemSelected: (courseDetails) {
                                  setState(() {
                                    courseName = courseDetails['CourseName'];
                                    selectedCourseID =
                                        courseDetails['CourseID'];
                                  });
                                },
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              // Add spacing to prevent layout issues
                              CustomeTextField(
                                controller: courseWiseStudentTotalController,
                                icon: Icons.numbers,
                                iconColor: ColorTheme().PRIMARY_COLOR,
                                hintText: "Number of Students",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                          child: InkWell(
                            onTap: () {
                              ShowAlertDialog dialog = ShowAlertDialog();
                              for (var element in courseWiseStudent) {
                                if (element['CourseName'] == courseName) {
                                  dialog.showDialog(context, "Alert",
                                      "$courseName is already selected! Please select another course!");
                                  return;
                                }
                              }
                              if ((courseName == null || courseName == "") &&
                                  courseWiseStudentTotalController
                                      .text.isEmpty) {
                                dialog.showDialog(context, "Alert",
                                    "Please select course and enter it's student!");
                                return;
                              } else if ((courseName != null ||
                                      courseName != "") &&
                                  courseWiseStudentTotalController
                                      .text.isEmpty) {
                                dialog.showDialog(context, "Alert",
                                    "Please enter $courseName's student number!");
                                return;
                              } else if ((courseName == null ||
                                      courseName == "") &&
                                  courseWiseStudentTotalController
                                      .text.isNotEmpty) {
                                dialog.showDialog(
                                    context, "Alert", "Please select course!");
                                return;
                              }
                              setState(() {
                                var temp = {
                                  "CourseName": courseName,
                                  "TotalStu":
                                      courseWiseStudentTotalController.text
                                };
                                courseWiseStudent.add(temp);
                                courseDropdownList.add(selectedCourseID);
                                totalStudent += int.parse(
                                    courseWiseStudentTotalController.text);
                              });
                              setState(() {
                                courseName = null;
                                courseWiseStudentTotalController.clear();
                              });
                            },
                            child: Icon(
                              Icons.add_circle_outline_sharp,
                              color: ColorTheme().PRIMARY_COLOR,
                              size: 25.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isDataInserting = true;
                            });
                            ShowAlertDialog dialog = ShowAlertDialog();
                            bool hasError = false;
                            try {
                              if (purposeName == "" || purposeName == null) {
                                dialog.showDialog(
                                    context, "Alert", "Please Select Purpose!");
                                return;
                              } else if (schoolName == "" ||
                                  schoolName == null) {
                                dialog.showDialog(
                                    context, "Alert", "Please Select School!");
                                return;
                              } else if (reasonName == "" ||
                                  reasonName == null) {
                                dialog.showDialog(
                                    context, "Alert", "Please Select Reason!");
                                return;
                              } else if (totalNumberOfCopiesController
                                  .text.isEmpty) {
                                dialog.showDialog(context, "Alert",
                                    "Please enter total number of copies!");
                                return;
                              } else if (courseWiseStudent.isEmpty ||
                                  courseDropdownList.isEmpty) {
                                dialog.showDialog(context, "Alert",
                                    "Please Enter Course and its student");
                                return;
                              } else if (courseWiseStudent.length !=
                                  courseDropdownList.length) {
                                dialog.showDialog(
                                    context, "Alert", "Please reset the form!");
                                return;
                              }

                              if (radioButtonValue == "NO") {
                                collectedData["InterestInCampusVisit"] = 0;
                              } else {
                                collectedData["InterestInCampusVisit"] = 1;
                              }
                              collectedData["TotalNumberOfCopies"] =
                                  totalNumberOfCopiesController.text;
                              collectedData["RRDDate"] = selectedDate.text;

                              int RRDID = await MST_RR_Distribution()
                                  .insertIntoMST_RR_Distribution(collectedData);

                              for (int i = 0;
                                  i < courseDropdownList.length;
                                  i++) {
                                var data = {
                                  "CourseID": courseDropdownList[i],
                                  "TotalStudent": courseWiseStudent[i]
                                      ['TotalStu'],
                                  "RRDID": RRDID
                                };
                                await MST_CourseWiseStudents()
                                    .insertIntoMST_CourseWiseStudents(data);
                              }
                            } catch (e) {
                              hasError = true;
                            } finally {
                              setState(() {
                                isDataInserting = false;
                              });
                            }
                            Snackbar snackbar = Snackbar();
                            if (!hasError) {
                              snackbar.showSnackbar(
                                  context,
                                  "Data saved Successfully!",
                                  Icons.check_circle,
                                  5,
                                  Colors.green);
                              setState(() {
                                purposeName = null;
                                schoolName = null;
                                reasonName = null;
                                totalNumberOfCopiesController.clear();
                                courseWiseStudent.clear();
                                courseDropdownList.clear();
                                courseName = null;
                                courseWiseStudentTotalController.clear();
                                totalStudent = 0;
                              });
                              return;
                            }
                            snackbar.showSnackbar(
                                context,
                                "Something went wrong!",
                                Icons.close,
                                5,
                                Colors.red);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorTheme().PRIMARY_COLOR,
                            // Green background
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(15), // Rounded edges
                            ),
                          ),
                          child: isDataInserting
                              ? Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Saving...",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Colors.white, // White text color
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                )
                              : Text(
                                  "Save",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white, // White text color
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              purposeName = null;
                              schoolName = null;
                              reasonName = null;
                              totalNumberOfCopiesController.clear();
                              courseWiseStudent.clear();
                              courseDropdownList.clear();
                              courseName = null;
                              courseWiseStudentTotalController.clear();
                              totalStudent = 0;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red, // Green background
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(15), // Rounded edges
                            ),
                          ),
                          child: Text(
                            "Reset",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white, // White text color
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "Total Student : ",
                        style: TextStyle(fontSize: 17.sp),
                      ),
                      Text(
                        totalStudent < 0 ? "0" : totalStudent.toString(),
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: ColorTheme().PRIMARY_COLOR,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: courseWiseStudent.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: Card(
                              color: Colors.white,
                              child: ListTile(
                                title: Text(
                                    courseWiseStudent[index]['CourseName']),
                                subtitle: Text(
                                    'Total Students : ${courseWiseStudent[index]['TotalStu']}'),
                                trailing: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        totalStudent -= int.parse(
                                            courseWiseStudent[index]
                                                ['TotalStu']);
                                        courseDropdownList.removeAt(index);
                                        courseWiseStudent.removeAt(index);
                                      });
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                                dense: true,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _selectDateRange(context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            datePickerTheme: Theme.of(context).datePickerTheme.copyWith(
                  backgroundColor: Colors.white,
                  headerBackgroundColor: ColorTheme().PRIMARY_COLOR,
                  weekdayStyle: TextStyle(
                      color: ColorTheme().PRIMARY_COLOR,
                      fontWeight: FontWeight.bold),
                  headerForegroundColor: ColorTheme().SECONDARY_COLOR,
                  surfaceTintColor: ColorTheme().PRIMARY_COLOR,
                  confirmButtonStyle: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorTheme().PRIMARY_COLOR),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    textStyle: MaterialStateProperty.all(
                      TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  cancelButtonStyle: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    textStyle: MaterialStateProperty.all(
                      TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.all(
                          Radius.circular(5)) // Reduce radius here
                      ),
                ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      date = picked;
      selectedDate.text =
          '${date?.day.toString().padLeft(2, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.year}';
    } else {
      selectedDate.text =
          '${date?.day.toString().padLeft(2, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.year}';
    }
  }
}
