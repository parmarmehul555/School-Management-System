import 'package:flutter/material.dart';
import 'package:school_management_system/CustomWidget/CustomeBottomSheetDropdown.dart';
import 'package:school_management_system/CustomWidget/CustomeTextField.dart';
import 'package:school_management_system/DB_Helper/MST_Course.dart';
import 'package:school_management_system/DB_Helper/Member.dart';
import 'package:school_management_system/DB_Helper/Purpose.dart';
import 'package:school_management_system/DB_Helper/School.dart';
import 'package:school_management_system/DB_Helper/Seminar.dart';
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
  TextEditingController controller = TextEditingController();
  TextEditingController selectedDate = TextEditingController();
  TextEditingController courseWiseStudentTotal = TextEditingController();

  Map<String, dynamic> collectedData = Map();

  @override
  void initState() {
    super.initState();
    isLoading = true;
    filteredCategories = categories;
    DateTime currentDate = DateTime.now();
    selectedDate.text =
        '${currentDate.day.toString().padLeft(2, '0')}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.year}';
    ;
    _loadData();
    isLoading = false;
  }
  String? selectedCourse;

  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose(); // Clean up controller
    super.dispose();
  }
  String? selectedValue;

  Future<void> _loadData() async {
    var tempMemberList = await Member().selectMemberDDL()!;
    var tempReasonList = await Seminar().seminarSelectForDDL()!;
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
    print(reasonList);
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
                          color: Colors.purpleAccent,
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
                    selectedValue: selectedValue,
                    listAccessName: 'PurposeTitle',
                    listAccessKey: 'PurposeID',
                    bottomSheetTitle: 'Purpose',
                    dropdownTitle: "Select Purpose",
                    icon: Icons.account_tree_outlined,
                    iconColor: Colors.red,
                    onItemSelected: (purposeDetail) {
                      setState(() {
                        collectedData["PurposeID"] = purposeDetail['PurposeID'];
                      });
                    },
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  CustomeBottomSheetDropdown(
                    list: schoolList,
                    selectedValue: selectedValue,
                    listAccessName: 'SchoolShortName',
                    listAccessKey: 'SchoolID',
                    bottomSheetTitle: 'School',
                    dropdownTitle: "Select School",
                    icon: Icons.apartment,
                    iconColor: Colors.green,
                    onItemSelected: (schoolDetail) {
                      setState(() {
                        collectedData["SchoolID"] = schoolDetail['SchoolID'];
                      });
                    },
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  CustomeBottomSheetDropdown(
                    list: reasonList,
                    selectedValue: selectedValue,
                    listAccessName: 'SeminarTitle',
                    listAccessKey: 'SeminarID',
                    bottomSheetTitle: 'Reason',
                    dropdownTitle: "Select Reason",
                    icon: Icons.help,
                    iconColor: Colors.orangeAccent,
                    onItemSelected: (seminarDetail) {
                      setState(() {
                        collectedData["SeminarID"] = seminarDetail['SeminarID'];
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
                    controller: controller,
                    icon: Icons.numbers,
                    iconColor: Colors.cyan,
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
                                selectedValue: selectedCourse,
                                listAccessName: 'CourseName',
                                listAccessKey: 'CourseID',
                                bottomSheetTitle: 'Standard',
                                dropdownTitle: "Select Course",
                                icon: Icons.account_tree_outlined,
                                iconColor: Colors.red,
                                onItemSelected: (courseDetails) {
                                  setState(() {
                                    courseName = courseDetails['CourseName'];
                                    selectedCourse = courseDetails['CourseName'];
                                    courseDropdownList
                                        .add(courseDetails['CourseID']);
                                  });
                                },
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              // Add spacing to prevent layout issues
                              CustomeTextField(
                                controller: courseWiseStudentTotal,
                                icon: Icons.numbers,
                                iconColor: Colors.cyan,
                                hintText: "Number of Students",
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 15.w,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                var temp = {
                                  "CourseName": courseName,
                                  "TotalStu": courseWiseStudentTotal.text
                                };
                                courseWiseStudent.add(temp);
                              });
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: Duration(milliseconds: 300),
                                  // Smooth scroll effect
                                  curve: Curves.easeOut,
                                );
                              });
                              setState(() {
                                selectedCourse = null;
                                courseName = "";
                                courseWiseStudentTotal.clear();
                              });
                              print(
                                  "After Insertinon : $courseWiseStudent && $courseDropdownList");
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
                  ElevatedButton(
                    onPressed: () {
                      // Add your onPressed action here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Green background
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Rounded edges
                      ),
                    ),
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white, // White text color
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  ListView.builder(
                    controller: _scrollController,
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
                                        courseDropdownList.removeAt(index);
                                        courseWiseStudent.removeAt(index);
                                        print(
                                            "After Deletion : $courseWiseStudent && $courseDropdownList");
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
        initialDate: DateTime.now());

    selectedDate.text =
        '${picked?.day.toString().padLeft(2, '0')}-${picked?.month.toString().padLeft(2, '0')}-${picked?.year}';
    //
    // if (picked != null) {
    //   print("Selected Range: ${picked.start} - ${picked.end}");
    // }
  }
}
