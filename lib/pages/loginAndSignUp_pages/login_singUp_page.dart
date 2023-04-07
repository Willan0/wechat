import 'package:flutter/material.dart';
import 'package:wechat/constant/color.dart';
import 'package:wechat/constant/dimen.dart';
import 'package:wechat/constant/string.dart';
import 'package:wechat/pages/loginAndSignUp_pages/login_page.dart';
import 'package:wechat/pages/loginAndSignUp_pages/sign_up_page.dart';
import 'package:wechat/utils/extension.dart';
import 'package:wechat/widgets/easy_button.dart';

class LoginAndSignUpPage extends StatelessWidget {
  const LoginAndSignUpPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(kLoginAndSingUpBackgroundImage,fit: BoxFit.cover,),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: kMp20x,left: kMp20x,right: kMp20x),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: LoginAndSignUpButtons(),
            ),
          )
        ],
      ),
    );
  }
}

class LoginAndSignUpButtons extends StatelessWidget {
  const LoginAndSignUpButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        EasyButton(
          width:kWh130x,
            height: kWh50x,
            onPressed: (){
            context.nextScreen(context, const LoginPage());
            },
            color: kSecondaryColor,
            text: kLogin,
        ),
        Spacer(),
        EasyButton(
          width: kWh130x,
            height: kWh50x,
            onPressed: (){
            showBottomSheet(
              context: context,
              builder: (context) => Container(
                color: Colors.black,
                width: getWidth(context),
                height: kWh200x,
                child: Column(
                    children: [
                      Expanded(child: EasyButton(width:getWidth(context), onPressed: (){
                        context.previousScreen(context);
                        context.nextScreen(context, const SignUpPage());
                      }, color: kPrimaryBlackShadowColor, text: kSignUpMethodMobile,textColor: kSecondaryTextColor,)),
                      Expanded(child: EasyButton(width:getWidth(context), onPressed: (){
                        context.previousScreen(context);
                      }, color: kPrimaryBlackShadowColor, text: kSignUpMethodFacebook,textColor: kSecondaryTextColor,)),
                      SizedBox(height: kMp20x,),
                      Expanded(child: EasyButton(width:getWidth(context), onPressed: (){
                        context.previousScreen(context);
                      }, color: kPrimaryBlackShadowColor, text: kCancel,textColor: kSecondaryTextColor,)),
                    ],
                  ),
              )
              ,);
            },
            color: kPrimaryBlackColor,
            text: kSingUp,
        )
      ],
    );
  }
}
