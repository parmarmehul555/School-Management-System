import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomeTextField extends StatelessWidget {
  TextEditingController controller;
  Color iconColor;
  String hintText;
  IconData icon;

  CustomeTextField({
    Key? key,
    required this.controller,
    required this.iconColor,
    required this.hintText,
    required this.icon
}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            isDense: true,
            prefixIcon: Icon(icon,size: 17.sp,color: iconColor,),
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder()
          ),
        ),
      ),
    );
  }
}
