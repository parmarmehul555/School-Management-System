import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:school_management_system/Models/SeminarDDL.dart';
import 'package:sizer/sizer.dart';

class CustomeDropdown extends StatefulWidget {
  List<dynamic> list;
  String? dropdownTitle;
  SingleSelectController? dropdownValue;
  String? targetDropdownValue;
  Function(dynamic)? onChanged;
  String? targetID;

  CustomeDropdown(
      {required this.list,
      required this.targetID,
      required this.targetDropdownValue,
      required this.dropdownValue,
      required this.dropdownTitle,
      this.onChanged});

  @override
  State<CustomeDropdown> createState() => _CustomeDropdownState();
}

class _CustomeDropdownState extends State<CustomeDropdown> {
  @override
  Widget build(BuildContext context) {
    String className = widget.targetDropdownValue.toString();
    return CustomDropdown.search(
      closedHeaderPadding:
          EdgeInsets.symmetric(horizontal: 11.sp, vertical: 13.sp),
      decoration: CustomDropdownDecoration(
          closedBorderRadius: BorderRadius.circular(5),
          closedBorder: Border.all(width: 1)),
      items: widget.list
          .map((e) => e[widget.targetDropdownValue.toString()])
          .toList(),
      hintText: widget.dropdownTitle,
      onChanged: (selectedValue) {
        print('from custome widget $selectedValue');
        setState(() {
          widget.dropdownValue?.value = selectedValue;
        });
        if (widget.targetID!.isNotEmpty) {
          Map<dynamic, dynamic> tempObj = widget.list.firstWhere((element) =>
              element[widget.targetDropdownValue] == selectedValue);

          widget.onChanged?.call(tempObj[widget.targetID.toString()]);
        }
      },
    );
  }
}
