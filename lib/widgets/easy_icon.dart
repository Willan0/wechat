import 'package:flutter/material.dart';
import 'package:wechat/constant/color.dart';
import 'package:wechat/constant/dimen.dart';

class EasyIcon extends StatelessWidget {
  const EasyIcon({Key? key,
    required this.icon,
    this.color = kPrimaryColor,
    this.iconSize = kFi14x,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final double iconSize;
  final Color color;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      color: color,
      iconSize: iconSize,
      onPressed: () => onPressed(),
    );
  }
}
