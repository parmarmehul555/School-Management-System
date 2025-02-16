import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/rendering.dart';
import 'package:school_management_system/CustomWidget/CustomeDropDown.dart';
import 'package:school_management_system/DB_Helper/MST_Remuneration.dart';
import 'package:school_management_system/DB_Helper/Member.dart';
import 'package:school_management_system/DB_Helper/Remuneration.dart';
import 'package:school_management_system/DB_Helper/Seminar_Conduct.dart';
import 'package:school_management_system/utils/funtions.dart';
import 'package:school_management_system/utils/theme.dart';
import 'package:sizer/sizer.dart';
import 'package:school_management_system/Remuneration.dart' as rmu;

import 'DB_Helper/MST_RR_Distribution.dart';

class Remuneration extends StatefulWidget {
  @override
  State<Remuneration> createState() => _RemunerationState();
}

class RowItem {
  String? dropdownValue;
  TextEditingController numberController = TextEditingController();
}

class _RemunerationState extends State<Remuneration> {
  TextEditingController datePickerController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  String dropdownValue = "";
  bool isLoading = true;
  bool showDetails = false;
  List<dynamic> seminarConductList = [];
  List<dynamic> seminarWiseMembers = [];
  List<dynamic> RRList = [];
  List<dynamic> RRMemberList = [];
  Map<String, dynamic> seminarDetails = Map();
  int seminarConductID = -1;
  int memberID = -1;
  int remainingAmount = 0;
  List<dynamic> filteredSeminarConductList = [];
  Map<String, dynamic> distributionDetail = Map();

  @override
  void initState() {
    _fetchData();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _fetchData() async {
    datePickerController.text = DateTime.now().toString();
    var tempSeminarConductList = await SeminarConduct().seminarConductDDL();
    var temprrlist = await MST_RR_Distribution().selectRRDDL();
    var tempMemberList = await Member().selectMemberDDL()!;
    setState(() {
      seminarConductList = tempSeminarConductList;
      RRList = temprrlist;
      RRMemberList = tempMemberList;
    });
  }

  SingleSelectController seminarConductController = SingleSelectController("");
  SingleSelectController rrcontroller = SingleSelectController("");
  SingleSelectController memberController = SingleSelectController("");
  SingleSelectController rrmemberController = SingleSelectController("");
  int RRID = -1;
  bool isFirstDropdownDisabled = false;
  bool isSecondDropdownDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Remuneration"),
        ),
        body: !isLoading
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    CustomeDropdown(
                      list: RRList,
                      targetDropdownValue: "RRDDate",
                      dropdownTitle: "Select RR Distribution Date",
                      dropdownValue: rrcontroller,
                      targetID: 'RRDID',
                      idxToDisplay: "RRDID",
                      onChanged: (distribution) async {
                        print("RRDID IS ${distribution['RRDID']}");
                        setState(() {
                          isSecondDropdownDisabled =
                              true; // Disable second dropdown
                          isFirstDropdownDisabled =
                              false; // Ensure the first dropdown is enabled
                          setState(() {
                            RRID = distribution['RRDID'];
                          });
                        });

                        var tempDistList =
                            await MST_RR_Distribution().selectAmount(RRID);
                        print(tempDistList);

                        setState(() {
                          distributionDetail = tempDistList;
                          showDetails = true;
                        });
                      },
                      enable:
                          !isFirstDropdownDisabled, // Disable/Enable based on flag
                            ),
                            SizedBox(
                              height: 0.1.h,
                            ),
                            Container(
                              child: Center(
                                  child: Text(
                                    "OR",
                                    style: TextStyle(
                                        fontSize: 19.sp,
                                        color: ColorTheme().PRIMARY_COLOR,
                                        fontWeight: FontWeight.bold),
                      )),
                    ),
                    CustomeDropdown(
                      list: seminarConductList,
                      targetDropdownValue: "SeminarTitle",
                      dropdownTitle: "Select Seminar",
                      dropdownValue: seminarConductController,
                      targetID: 'SeminarConductID',
                      idxToDisplay: "SeminarConductID",
                      onChanged: (seminar) async {
                        setState(() {
                          isFirstDropdownDisabled =
                              true; // Disable first dropdown
                          isSecondDropdownDisabled =
                              false; // Ensure the second dropdown is enabled
                          seminarConductID = seminar['SeminarConductID'];
                        });
                        var tempSeminarDetails = await SeminarConduct()
                            .selectConductedSeminarDetails(seminarConductID);
                        var tempSeminarWiseMembers = await Member()
                            .selectMemberBySeminarConductID(seminarConductID);
                        Map<String, dynamic> data = await Remunerationn()
                            .selectRemainingAmount(seminarConductID);
                        setState(() {
                          seminarDetails = tempSeminarDetails;
                          seminarWiseMembers = tempSeminarWiseMembers;
                          remainingAmount = data['RemainingAmount'];
                          showDetails = true;
                        });
                      },
                      enable:
                          !isSecondDropdownDisabled, // Disable/Enable based on flag
                    ),
                    SizedBox(
                      height: 0.1.h,
                    ),
                    SizedBox(
                      height: 0.1.h,
                    ),
                    isSecondDropdownDisabled
                        ? Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Total Expanse: ",
                                        style: TextStyle(fontSize: 18.sp),
                                      ),
                                      Text(
                                        distributionDetail['TotalExpence']
                                            .toString(),
                                        style: TextStyle(fontSize: 18.sp),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Remaining Amount: ",
                                        style: TextStyle(fontSize: 18.sp),
                                      ),
                                      Text(
                                        distributionDetail['RemainingAmount']
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    isFirstDropdownDisabled
                        ? Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Total Teacher : ",
                                        style: TextStyle(fontSize: 18.sp),
                                      ),
                                      Text(
                                        seminarDetails['TotalTeacher']
                                            .toString(),
                                        style: TextStyle(fontSize: 18.sp),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Total Student: ",
                                        style: TextStyle(fontSize: 18.sp),
                                      ),
                                      Text(
                                        seminarDetails['TotalStudent']
                                            .toString(),
                                        style: TextStyle(fontSize: 18.sp),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Total Expense: ",
                                        style: TextStyle(fontSize: 18.sp),
                                      ),
                                      Text(
                                        seminarDetails['TotalExpence']
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 18.sp, color: Colors.red),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Remaining Amount: ",
                                        style: TextStyle(fontSize: 18.sp),
                                      ),
                                      Text(
                                        remainingAmount.toString(),
                                        style: TextStyle(
                                            fontSize: 18.sp, color: Colors.red),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 0.1.h,
                    ),
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
                      height: 0.1.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Amount Paid : ",
                          style: TextStyle(fontSize: 17.sp),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: TextFormField(
                              controller: amountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: "Paid Amount",
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(),
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                alignLabelWithHint: true,
                              ),
                              textAlignVertical: TextAlignVertical
                                  .center, // Ensures the text is vertically centered
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.1.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Amount Given To : ",
                          style: TextStyle(fontSize: 17.sp),
                        ),
                        Expanded(
                          child: RRID != -1
                              ? CustomeDropdown(
                                  list: RRMemberList,
                                  dropdownValue: rrmemberController,
                                  targetDropdownValue: "MemberName",
                                  dropdownTitle: "Select Member",
                                  targetID: 'MemberID',
                                  onChanged: (memberDetail) {
                                    setState(() {
                                      memberID = memberDetail['MemberID'];
                                    });
                                  },
                                )
                              : CustomeDropdown(
                                  list: seminarWiseMembers,
                                  targetDropdownValue: "MemberName",
                                  dropdownTitle: "Select Member",
                                  dropdownValue: memberController,
                                  targetID: 'MemberID',
                                  onChanged: (member) {
                                    print(member);
                                    setState(() {
                                      memberID = member['MemberID'];
                                    });
                                  },
                                ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.1.h,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          String date = Functions()
                              .formateDate(datePickerController.text);
                          Map<String, dynamic> dataforseminar = {
                            "SeminarConductID": seminarConductID,
                            "RemunerationPaidDate": date,
                            "AmountPaid": amountController.text,
                            "AmountGivenTo": memberID
                          };

                          Map<String, dynamic> dataForRR = {
                            "RRDID": RRID,
                            "RemunerationPaidDate": date,
                            "AmountPaid": amountController.text,
                            "AmountGivenTo": memberID
                          };

                          int totalPaidAmount =
                              int.parse(amountController.text);
                          RRID != -1
                              ? await MST_Remuneration()
                                  .insertInRemunerationForRR(dataForRR)
                              : await MST_Remuneration()
                                  .insertInRemunerationForSeminar(
                                      dataforseminar);
                          RRID == -1
                              ? await SeminarConduct().updateRemainingAmount(
                                  totalPaidAmount, seminarConductID)
                              : await MST_RR_Distribution()
                                  .updateRemainingAmountForRR(
                                      totalPaidAmount, RRID);
                          RRID == -1
                              ? await Remunerationn().updateRemunerationAmount(
                                  seminarConductID, totalPaidAmount)
                              : await Remunerationn()
                                  .updateRemunerationAmountForRR(
                                      RRID, totalPaidAmount);
                          Map<String, dynamic> remainingAmountData = Map();

                          if (RRID == -1) {
                            remainingAmountData = await Remunerationn()
                                .selectRemainingAmount(seminarConductID);
                          } else {
                            var tempDistributionDetail = await Remunerationn()
                                .selectRemainingAmountForRR(RRID);
                            setState(() {
                              distributionDetail = tempDistributionDetail;
                            });
                          }

                          setState(() {
                            remainingAmount =
                                remainingAmountData['RemainingAmount'];
                          });
                        },
                        child: Text("Save"))
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                color: ColorTheme().PRIMARY_COLOR,
              )));
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
