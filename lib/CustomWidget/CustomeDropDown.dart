import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomeDropdown extends StatefulWidget {
  List<String> list;
  String? dropdownTitle;
  SingleSelectController? dropdownValue;
  CustomeDropdown({required this.list,required this.dropdownValue,required this.dropdownTitle});

  @override
  State<CustomeDropdown> createState() => _CustomeDropdownState();
}

class _CustomeDropdownState extends State<CustomeDropdown> {
  @override
  Widget build(BuildContext context) {
    return CustomDropdown.search(
      closedHeaderPadding: EdgeInsets.symmetric(horizontal: 11.sp,vertical: 13.sp),
      decoration: CustomDropdownDecoration(
          closedBorderRadius: BorderRadius.circular(5),
          closedBorder: Border.all(width: 1)),
      items: widget.list,
      hintText: widget.dropdownTitle,
      onChanged: (p0) {
        setState(() {
          print(p0);
          widget.dropdownValue!.value = p0;
        });
      },
    );
  }
}
