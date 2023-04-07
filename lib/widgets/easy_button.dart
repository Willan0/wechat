import 'package:flutter/material.dart';
import 'package:wechat/constant/color.dart';
import 'package:wechat/constant/dimen.dart';
import 'package:wechat/widgets/easy_text.dart';

class EasyButton extends StatelessWidget {
  const EasyButton({Key? key,
    required this.onPressed,
    this.width = 0,
    this.height = kWh40x,
    required this.color,
    this.textColor = kSecondaryTextColor,
    required this.text
  }) : super(key: key);

  final Function? onPressed;
  final double height;
  final double width;
  final Color color;
  final Color textColor;
  final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: ()=> onPressed!(),
      height: height,
      minWidth: width,
      color: color,
      child: EasyText(text: text,color: textColor,),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(kRi10x))
      ),
    );
  }
}
