import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
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
  TextEditingController datePickerController = TextEditingController();
  String radioButtonValue = "YES";

  // List to hold rows
  List<RowItem> rowItems = [RowItem()];

  // List of dropdown items
  List<String> purposeeList = ["10th", "12th-A", "12th-B"];

  @override
  void initState() {
    // TODO: implement initState
    datePickerController.text = DateTime.now().toString();
  }

  List<String> purposeList = ["First", "Second", "Third", "Forth"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_new),
        title: Text("RR Distribution"),
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
                  prefixIcon: Icon(Icons.date_range),
                  isDense: true,
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomDropdown(
              decoration: CustomDropdownDecoration(
                  closedBorderRadius: BorderRadius.circular(5),
                  closedBorder: Border.all(width: 1)),
              items: purposeList,
              hintText: "Select Purpose",
              onChanged: (p0) {},
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomDropdown(
              decoration: CustomDropdownDecoration(
                  closedBorderRadius: BorderRadius.circular(5),
                  closedBorder: Border.all(width: 1)),
              items: purposeList,
              hintText: "Select School",
              onChanged: (p0) {},
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomDropdown(
              decoration: CustomDropdownDecoration(
                  closedBorderRadius: BorderRadius.circular(5),
                  closedBorder: Border.all(width: 1),
                  listItemDecoration:
                      ListItemDecoration(highlightColor: Colors.grey)),
              items: purposeList,
              hintText: "Select Reason",
              onChanged: (p0) {},
            ),
            SizedBox(
              height: 1.h,
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
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: rowItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 2.0.pt),
                  child: Row(
                    children: [
                      // Dropdown
                      Expanded(
                        flex: 1,
                        child: CustomDropdown(
                          decoration: CustomDropdownDecoration(
                              closedBorderRadius: BorderRadius.circular(5),
                              closedBorder: Border.all(width: 1),
                              listItemDecoration: ListItemDecoration(
                                highlightColor: Colors.grey,
                              ),
                              hintStyle: TextStyle(fontSize: 16.sp)),
                          items: purposeeList,
                          hintText: "Std.",
                          onChanged: (value) {
                            setState(() {
                              rowItems[index].dropdownValue = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      // TextFormField for number input
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.white,
                          child: TextFormField(
                            controller: rowItems[index].numberController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter number",
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
            SizedBox(height: 1.h,),
            ElevatedButton(onPressed: () {}, child: Text("Save"))
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
