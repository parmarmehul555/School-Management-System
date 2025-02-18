import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomeBottomSheetDropdown extends StatefulWidget {
  final List<dynamic> list;
  final String listAccessName;
  final String listAccessKey;
  final String bottomSheetTitle;
  final Function(dynamic)? onItemSelected;
  final String dropdownTitle;
  final IconData icon;
  final Color iconColor;
  String? selectedValue;

  CustomeBottomSheetDropdown({
    required this.list,
    required this.listAccessName,
    required this.listAccessKey,
    required this.bottomSheetTitle,
    this.onItemSelected,
    required this.dropdownTitle,
    required this.icon,
    required this.iconColor,
    this.selectedValue,
  });

  @override
  State<CustomeBottomSheetDropdown> createState() =>
      CustomeBottomSheetDropdownState();
}

class CustomeBottomSheetDropdownState
    extends State<CustomeBottomSheetDropdown> {
  List<dynamic> filteredList = [];
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
    filteredList = List.from(widget.list);
  }

  void _filterList(String value) {
    setState(() {
      if (value.isEmpty) {
        filteredList = widget.list;
      } else {
        filteredList = widget.list
            .where((element) => element[widget.listAccessName]
                .toString()
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();
      }
    });
  }

  void _openModalBottomSheet(BuildContext context) {
    setState(() {
      filteredList = List.from(widget.list);
    });
    showModalBottomSheet(
        builder: (context) {
          return AnimatedPadding(
            duration: Duration(milliseconds: 200),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom * 0.4,
            ),
            child: Container(
              height: 50.h,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.bottomSheetTitle,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.sp),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.close,
                            size: 22.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: TextFormField(
                      onChanged: (value) => _filterList(value),
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          hintText: "Search",
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          isDense: true),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 0.1.h,
                        );
                      },
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          dense: true,
                          title: Text(
                            filteredList[index][widget.listAccessName],
                            maxLines: 3,
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          onTap: () {
                            widget.onItemSelected?.call(filteredList[index]);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: GestureDetector(
        onTap: () {
          _openModalBottomSheet(context);
        },
        child: InputDecorator(
          decoration: InputDecoration(
            isDense: true,
            prefixIcon: Icon(widget.icon, color: widget.iconColor),
            suffixIcon: const Icon(Icons.arrow_drop_down, size: 25),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(widget.selectedValue ?? widget.dropdownTitle),
        ),
      ),
    );
  }
}
