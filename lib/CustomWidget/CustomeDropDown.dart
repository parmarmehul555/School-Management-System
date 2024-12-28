import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:school_management_system/Models/SeminarDDL.dart';
import 'package:sizer/sizer.dart';

class CustomeDropdown extends StatefulWidget {
  List<dynamic> list;
  String? dropdownTitle;
  SingleSelectController? dropdownValue;
  String? targetDropdownValue;
  Function(String?)? onChanged;
  CustomeDropdown(
      {required this.list,
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
      onChanged: (p0) {
        setState(() {
          widget.dropdownValue?.value = p0;
        });
      },
    );
  }
}
