import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:school_management_system/CustomWidget/CustomeDropDown.dart';
import 'package:sizer/sizer.dart';

class Seminar_Conduct extends StatefulWidget{
  @override
  State<Seminar_Conduct> createState() => _Seminar_ConductState();
}

class RowItem {
  String? dropdownValue;
  TextEditingController numberController = TextEditingController();
}

class _Seminar_ConductState extends State<Seminar_Conduct> {
  TextEditingController datePickerController = TextEditingController();
  String radioButtonValue = "YES";
  String dropdownValue = "";

  List<RowItem> rowItems = [RowItem()];

  // List of dropdown items
  List<String> purposeeList = ["10th", "12th-A", "12th-B"];

  @override
  void initState() {
    datePickerController.text = DateTime.now().toString();
  }

  List<String> speakerList = ["First", "Second", "Third", "Forth"];
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
            CustomeDropdown(list: speakerList,dropdownTitle:"Topic",dropdownValue: dropdownvalue1,),
            CustomeDropdown(list: speakerList,dropdownTitle:"Speaker1",dropdownValue: dropdownvalue2,),
            CustomeDropdown(list: speakerList,dropdownTitle:"Speaker2",dropdownValue: dropdownvalue3,),
            CustomeDropdown(list: speakerList,dropdownTitle:"School",dropdownValue: dropdownvalue4,),

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
            CustomeDropdown(list: speakerList,dropdownTitle:"member1",dropdownValue: dropdownvalue5,),
            CustomeDropdown(list: speakerList,dropdownTitle:"member2",dropdownValue: dropdownvalue6,),
            CustomeDropdown(list: speakerList,dropdownTitle:"member3",dropdownValue: dropdownvalue7,),
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
                  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  alignLabelWithHint: true,
                ),
                textAlignVertical: TextAlignVertical.center, // Ensures the text is vertically centered
              ),
            ),
            SizedBox(height: 1.h,),
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
                  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  alignLabelWithHint: true,
                ),
                textAlignVertical: TextAlignVertical.center, // Ensures the text is vertically centered
              ),
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
                  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  alignLabelWithHint: true,
                ),
                textAlignVertical: TextAlignVertical.center, // Ensures the text is vertically centered
              ),
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
                  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  alignLabelWithHint: true,
                ),
                textAlignVertical: TextAlignVertical.center, // Ensures the text is vertically centered
              ),
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
                  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  alignLabelWithHint: true,
                ),
                textAlignVertical: TextAlignVertical.center, // Ensures the text is vertically centered
              ),
            ),
            ElevatedButton(onPressed: () {
              print("Value from Dropdown is ${dropdownvalue1.value}");
              print("Value from Dropdown is ${dropdownvalue2.value}");
              print("Value from Dropdown is ${dropdownvalue3.value}");
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