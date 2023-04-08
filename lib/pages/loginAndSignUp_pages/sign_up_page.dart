import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat/bloc/sign_up_bloc.dart';
import 'package:wechat/constant/color.dart';
import 'package:wechat/constant/dimen.dart';
import 'package:wechat/constant/string.dart';
import 'package:wechat/utils/extension.dart';
import 'package:wechat/widgets/easy_icon.dart';
import 'package:wechat/widgets/easy_text.dart';

import '../../view_items/sign_up_view_item.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SingUpPageBloc>(
      create: (_)=> SingUpPageBloc(),
      child: Consumer<SingUpPageBloc>(
        builder: (context, bloc, child) =>  Form(
          key: bloc.getGlobalKey,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryBlackColor,
              elevation: 0,
              leading: EasyIcon(
                  icon: CupertinoIcons.clear,iconSize: kFi20x,
                onPressed: (){
                    context.previousScreen(context);
                },
              ),
            ),
            backgroundColor: kPrimaryBlackColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Center(child: EasyText(text: kSignUpTitle,fontSize: kFi17x,)),
                  SizedBox(height: kMp10x,),
                  SelectFileView(),
                  SizedBox(height: kMp20x,),
                  SingUpTextFieldView(),
                  SizedBox(height: kMp20x,),
                  PrivacyAndPolicy(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




