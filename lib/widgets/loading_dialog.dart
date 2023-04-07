import 'package:flutter/material.dart';
import 'package:wechat/constant/color.dart';
import 'package:wechat/constant/dimen.dart';

import '../constant/string.dart';
import 'easy_text.dart';

class LoadingAlertDialogWidget extends StatelessWidget {
  const LoadingAlertDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircularProgressIndicator(),
          SizedBox(
            width: kMp20x,
          ),
          EasyText(
            text: kLoadingText,
            fontWeight: FontWeight.w500,
            fontSize: kFi20x,
            color: kPrimaryTextColor,
          )
        ],
      ),

    );
  }
}