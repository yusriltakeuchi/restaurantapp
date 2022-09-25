import 'package:flutter/material.dart';
import 'package:restaurantapp/ui/constant/constant.dart';

class CustomTextField extends StatelessWidget {
  final Function(String)? onChange;
  final Function(String)? onSubmit;
  final TextEditingController controller;
  final bool readOnly;
  final bool autoFocus;
  final String hintText;
  const CustomTextField({
    Key? key,
    required this.controller,
    this.onChange,
    this.onSubmit,
    this.readOnly = false,
    required this.autoFocus,
    required this.hintText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: grayColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
          controller: controller,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          readOnly: readOnly,
          autofocus: autoFocus,
          style: TextStyle(
            fontSize: setFontSize(40),
            color: Colors.black54,
            fontWeight: FontWeight.w600,
          ),
          onChanged: (value) => onChange != null ? onChange!(value) : {},
          onSubmitted: (value) => onSubmit != null ? onSubmit!(value) : {},
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
