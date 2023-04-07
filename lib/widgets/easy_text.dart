
import 'package:flutter/material.dart';
import 'package:wechat/constant/color.dart';
import 'package:wechat/constant/dimen.dart';

class EasyText extends StatelessWidget {
  const EasyText({Key? key,
    required this.text,
    this.fontSize = kFi14x,
    this.fontWeight = FontWeight.w400,
    this.color = kSecondaryTextColor,
    this.decoration = TextDecoration.none,
    this.textAlign = TextAlign.left
  }) : super(key: key);

  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextDecoration decoration;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,

      ),
    );
  }
}
