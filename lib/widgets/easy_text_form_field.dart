import 'package:flutter/material.dart';
import 'package:wechat/constant/color.dart';

class EasyTextFormField extends StatelessWidget {
  const EasyTextFormField({Key? key,this.color = kPrimaryColor,
    this.maxLine = 1,
    required this.validate, required this.controller, required this.hintText, required this.onTap, required this.onChanged,this.inputBorder = InputBorder.none,this.focusedInputBorder = InputBorder.none,this.hintTextColor = kGreyColor}) : super(key: key);

  final Function (String? value) validate;
  final TextEditingController controller;
  final Color color;
  final String hintText;
  final Function onTap;
  final Function (String text)onChanged;
  final InputBorder inputBorder;
  final Color hintTextColor ;
  final int maxLine;
  final InputBorder focusedInputBorder;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: color
      ),
      maxLines: maxLine,
      validator: (value)=> validate(value),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: hintTextColor),
        border: inputBorder,
        focusedBorder: focusedInputBorder,
      ),
      onTap: ()=> onTap(),
      onChanged: (text)=> onChanged(text),
    );
  }
}
