import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomeDropdown extends StatefulWidget {
  List<dynamic> list;
  String? dropdownTitle;
  SingleSelectController? dropdownValue;
  String? targetDropdownValue;
  String? idxToDisplay;
  Function(dynamic)? onChanged;
  String? targetID;
  bool? enable;

  CustomeDropdown(
      {required this.list,
      required this.targetID,
      required this.targetDropdownValue,
      required this.dropdownValue,
      required this.dropdownTitle,
      this.onChanged,
      this.idxToDisplay,this.enable});

  @override
  State<CustomeDropdown> createState() => _CustomeDropdownState();
}

class _CustomeDropdownState extends State<CustomeDropdown> {
  @override
  Widget build(BuildContext context) {
    return CustomDropdown.search(
      enabled: widget.enable ?? true,
      closedHeaderPadding:
          EdgeInsets.symmetric(horizontal: 11.sp, vertical: 13.sp),
      decoration: CustomDropdownDecoration(
          closedBorderRadius: BorderRadius.circular(5),
          closedBorder: Border.all(width: 1)),
      items: widget.list
          .map((e) => widget.idxToDisplay != null
              ? "${e[widget.idxToDisplay]} | ${e[widget.targetDropdownValue]}"
              : e[widget.targetDropdownValue.toString()])
          .toList(),
      hintText: widget.dropdownTitle,
      onChanged: (selectedValue) {
        int selectedID = -1;
          String tempSelectedValue = selectedValue.toString();
        setState(() {
          widget.dropdownValue?.value = selectedValue;
          if(selectedValue.toString().contains(' | ')){
            selectedID = int.parse(selectedValue.toString().split(' | ')[0]);
            selectedValue = selectedValue.toString().split(' | ')[1];
          }
        });
        if (widget.targetID!.isNotEmpty) {
          if(tempSelectedValue.contains(' | ')){
            Map<dynamic, dynamic> tempObj = widget.list.firstWhere((element) =>
            element[widget.targetDropdownValue] == selectedValue && element[widget.targetID] == selectedID);
            widget.onChanged?.call(tempObj);
          }else{
          Map<dynamic, dynamic> tempObj = widget.list.firstWhere((element) =>
              element[widget.targetDropdownValue] == selectedValue);
          widget.onChanged?.call(tempObj);
          }
        }
      },
    );
  }
}
