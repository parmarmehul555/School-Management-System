import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:school_management_system/CustomWidget/CustomeDropDown.dart';
import 'package:sizer/sizer.dart';

class PaidRemuneration extends StatefulWidget {
  const PaidRemuneration({super.key});

  @override
  State<PaidRemuneration> createState() => _PaidRemunerationState();
}

class _PaidRemunerationState extends State<PaidRemuneration> {
  TextEditingController datePickerController = TextEditingController();
  SingleSelectController dropdownvalue = SingleSelectController("First");

  @override
  void initState() {
    // TODO: implement initState
    datePickerController.text = DateTime.now().toString();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> list = [
      {"fac": "NRV", "total": "25,000", "paid": "20,000", "remaining": "5,000"},
      {"fac": "NRV", "total": "25,000", "paid": "20,000", "remaining": "5,000"},
      {"fac": "NRV", "total": "25,000", "paid": "20,000", "remaining": "5,000"},
      {"fac": "NRV", "total": "25,000", "paid": "20,000", "remaining": "5,000"},
      {"fac": "NRV", "total": "25,000", "paid": "20,000", "remaining": "5,000"},
      {"fac": "NRV", "total": "25,000", "paid": "20,000", "remaining": "5,000"},
      {"fac": "NRV", "total": "25,000", "paid": "20,000", "remaining": "5,000"},
      {"fac": "NRV", "total": "25,000", "paid": "20,000", "remaining": "5,000"},
      {"fac": "NRV", "total": "25,000", "paid": "20,000", "remaining": "5,000"},
      {"fac": "NRV", "total": "25,000", "paid": "20,000", "remaining": "5,000"},
      {"fac": "NRV", "total": "25,000", "paid": "20,000", "remaining": "5,000"},
      {"fac": "NRV", "total": "25,000", "paid": "20,000", "remaining": "5,000"},
      {"fac": "NRV", "total": "25,000", "paid": "20,000", "remaining": "5,000"},
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Paid Remuneration"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              children: [
                Text("From : ",style: TextStyle(fontSize: 18.sp),),
                SizedBox(width: 1.w,),
                Expanded(
                  child: Container(
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
                ),
              ],
            ),
            SizedBox(height: 1.h,),
            Row(
              children: [
                Text("To : ",style: TextStyle(fontSize: 18.sp),),
                SizedBox(width: 7.w,),
                Expanded(
                  child: Container(
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
                ),
              ],
            ),
            SizedBox(height: 1.h,),
            Row(
              children: [
                Text("Status : ",style: TextStyle(fontSize: 17.sp),),
                Expanded(child: CustomeDropdown(dropdownValue: dropdownvalue,dropdownTitle: "Status",list: ["Paid","Remaining"],)),
              ],
            ),
            SizedBox(height: 1.h,),
            Container(
              color: Colors.white,
              child: Table(
                border: TableBorder.all(), // Optional: Add borders for clarity
                children: [
                  // Static TableRow for column headers
                  const TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Faculty',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Total',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Paid',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Remaining',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),

                  // Dynamically generated rows
                  ...list.map((e) {
                    return TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(e["fac"]),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(e["total"]),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            e["paid"],
                            style: TextStyle(
                                color: Colors.green, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            e["remaining"],
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            )
          ],
        ),
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
