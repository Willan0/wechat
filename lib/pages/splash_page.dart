import 'package:flutter/material.dart';
import 'package:wechat/constant/dimen.dart';
import 'package:wechat/constant/string.dart';
import 'package:wechat/pages/loginAndSignUp_pages/login_singUp_page.dart';
import 'package:wechat/pages/nav_pages/bottom_nav_page.dart';
import 'package:wechat/utils/extension.dart';

import '../constant/color.dart';
import '../constant/duration.dart';
import '../data/data_apply/fire_base_abs.dart';
import '../data/data_apply/fire_base_impl.dart';
import '../widgets/easy_text.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FireBaseApply _fireBaseApply = FireBaseApplyIMPL();
  @override
  void initState() {
    Future.delayed(Duration(seconds: kSplashTime)).then((value) {
      context.nextReplacement(context, _fireBaseApply.isLoggedIn()?BottomNavigationPage():LoginAndSignUpPage());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SizedBox(
        width: getWidth(context),
        height: getHeight(context),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: kMp100x),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(kWechatLogo,width: kWh200x,height: kWh150x,),),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: kMp100x),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: EasyText(
                  color: kPrimaryBlackColor,
                  text: kAppName,
                  fontSize: kFi30x,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: kMp80x),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: EasyText(
                  color:kPrimaryBlackColor,
                  text: kAppVersion,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
