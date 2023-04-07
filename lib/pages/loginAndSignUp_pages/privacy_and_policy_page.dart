import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat/constant/color.dart';
import 'package:wechat/constant/string.dart';
import 'package:wechat/pages/loginAndSignUp_pages/email_page.dart';
import 'package:wechat/utils/extension.dart';
import 'package:wechat/widgets/easy_button.dart';
import 'package:wechat/widgets/easy_text.dart';

import '../../constant/dimen.dart';
import '../../widgets/easy_icon.dart';

class PrivacyAndPolicyPage extends StatefulWidget {
  const PrivacyAndPolicyPage({Key? key, required this.file, required this.userName, required this.countryName, required this.phoneCode, required this.password}) : super(key: key);
  final String file;
  final String userName;
  final String countryName;
  final String phoneCode;
  final String password;


  @override
  State<PrivacyAndPolicyPage> createState() => _PrivacyAndPolicyPageState();
}

class _PrivacyAndPolicyPageState extends State<PrivacyAndPolicyPage> {
  bool isAgree = false;

  @override
  Widget build(BuildContext context) {
    print(isAgree);
    return Scaffold(
      backgroundColor: kPrimaryBlackColor,
      appBar: AppBar(
        backgroundColor: kPrimaryBlackColor,
        title: EasyText(text: kPrivacyTitle,color: kPrimaryColor,fontSize: kFi17x,),
        centerTitle: true,
        leading: EasyIcon(
        icon: CupertinoIcons.clear,iconSize: kFi20x,
        onPressed: (){
          context.previousScreen(context);
        },
      ),
        actions:  [ EasyIcon(icon: Icons.more_horiz,iconSize: kFi25x, onPressed: (){})],
      ),
      body: Column(
        children: [
          Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kMp10x),
            child: ListView(
              children: [
                Center(child: EasyText(text: 'WECHAT PRIVACY POLICY',fontSize: kFi17x,)),
                SizedBox(height: kMp10x,),
                EasyText(text: 'Last Updated 2023-03-3',fontSize: kFi12x,color: kGreyColor,),
                SizedBox(height: kMp10x,),
                EasyText(text: kSummaryTitle,fontSize: kFi17x,),
                SizedBox(height: kMp10x,),
                EasyText(text: kSummaryText,color: kGreyColor,),
                SizedBox(height: kMp10x,),
                EasyText(text: kAskPrivacy,fontSize: kFi17x,),
                SizedBox(height: kMp10x,),
                EasyText(text: kAskPrivacy2,color: kGreyColor,)
              ],
            ),
          )),
          SizedBox(
            height: kWh200x,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kMp20x),
              child: Column(
                children: [
                  SizedBox(height: kWh50x,),
                  GestureDetector(
                    onTap: (){
                      if(isAgree== false){
                        isAgree = true;
                      }else{
                        isAgree = false;
                      }
                      if(mounted){
                        setState(() {});
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Icon(isAgree?Icons.check_circle:Icons.check_circle_outline,color: isAgree?kSecondaryColor:kGreyColor,),
                      SizedBox(width: kMp5x,),
                      EasyText(text: kAcceptPrivacy,fontSize: kFi12x,color: kGreyColor,)
                    ],),
                  ),
                  SizedBox(height: kMp20x,),
                  EasyButton(
                      onPressed: (){
                        context.nextScreen(context, EmailPage(file: widget.file, userName: widget.userName, countryName: widget.countryName, phoneCode: widget.phoneCode, password: widget.password));
                      },
                      color: isAgree?kSecondaryColor:kPrimaryBlackShadowColor,
                      text: kNext,
                    height: kWh50x,
                    width: kWh230x,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
