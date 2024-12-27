import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:school_management_system/CustomWidget/CustomeDropDown.dart';
import 'package:school_management_system/DB_Helper/Seminar.dart';
import 'package:school_management_system/utils/theme.dart';
import 'package:sizer/sizer.dart';

class Seminar_Conduct extends StatefulWidget {
  @override
  State<Seminar_Conduct> createState() => _Seminar_ConductState();
}

class RowItem {
  String? dropdownValue;
}

class _Seminar_ConductState extends State<Seminar_Conduct> {
  bool isLoading = true;
  TextEditingController datePickerController = TextEditingController();
  String radioButtonValue = "YES";
  String dropdownValue = "";
  List<dynamic> seminarList = [];

  List<RowItem> rowItems = [RowItem()];

  // List of dropdown items
  List<String> purposeeList = ["10th", "12th-A", "12th-B"];

  @override
  void initState() {
    datePickerController.text = DateTime.now().toString();
    _loadData();
  }

  Future<void> _loadData() async {
    var tempPurposeList = await Seminar().seminarSelectForDDL()!;
    setState(() {
      seminarList = tempPurposeList;
    });
    isLoading = false;
  }

  // List<String> seminarList = ["First", "Second", "Third", "Forth"];
  SingleSelectController dropdownvalue1 = SingleSelectController("First");
  SingleSelectController dropdownvalue2 = SingleSelectController("First");
  SingleSelectController dropdownvalue3 = SingleSelectController("First");
  SingleSelectController dropdownvalue4 = SingleSelectController("First");
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
              list: seminarList,targetDropdownValue: "SeminarTitle",
              dropdownTitle: "Topic",
              dropdownValue: dropdownvalue1,
            ),
            CustomeDropdown(
              list: seminarList,targetDropdownValue: "SeminarTitle",
              dropdownTitle: "Speaker1",
              dropdownValue: dropdownvalue2,
            ),
            CustomeDropdown(
              list: seminarList
              ,targetDropdownValue: "SeminarTitle",
              dropdownTitle: "School",
              dropdownValue: dropdownvalue4,
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
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: rowItems.length,
              itemBuilder: (context, index) {
                return rowItems.length > 1
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
                            Expanded(
                              flex: 2,
                              child: Container(
                                  child: CustomeDropdown(
                                list: seminarList,
                                targetDropdownValue: "SeminarTitle",
                                dropdownTitle: "Member ${index + 1}",
                                dropdownValue: dropdownvalue5,
                              )),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    rowItems.insert(index + 1, RowItem());
                                  });
                                },
                                icon: Icon(Icons.add))
                          ],
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                                child: CustomeDropdown(
                              list: seminarList,
                              dropdownTitle: "Member ${index + 1}",
                              dropdownValue: dropdownvalue5,
                              targetDropdownValue: "SeminarTitle",
                            )),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  rowItems.insert(index + 1, RowItem());
                                });
                              },
                              icon: Icon(Icons.add))
                        ],
                      );
              },
            ),
            // CustomeDropdown(list: seminarList,dropdownTitle:"member1",dropdownValue: dropdownvalue5,),
            // CustomeDropdown(list: seminarList,dropdownTitle:"member2",dropdownValue: dropdownvalue6,),
            // CustomeDropdown(list: seminarList,dropdownTitle:"member3",dropdownValue: dropdownvalue7,),
            Container(
              color: Colors.white,
              child: TextFormField(
                keyboardType: TextInputType.number,
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
            Container(
              color: Colors.white,
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "Car Owners",
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
                onPressed: () {
                  print("Value from Dropdown is ${dropdownvalue1.value}");
                  print("Value from Dropdown is ${dropdownvalue2.value}");
                  print("Value from Dropdown is ${dropdownvalue3.value}");
                },
                child: Text("Save"))
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
