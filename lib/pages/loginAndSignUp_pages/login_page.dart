import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat/bloc/sign_in_bloc.dart';
import 'package:wechat/utils/extension.dart';

import '../../constant/color.dart';
import '../../constant/dimen.dart';
import '../../constant/string.dart';
import '../../view_items/sing_in_view_item.dart';
import '../../widgets/easy_icon.dart';
import '../../widgets/easy_text.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (_)=> SignInBloc(),
      child: Consumer<SignInBloc>(
        builder: (context, bloc, child) => Form(
          key: bloc.getGlobalKey,
          child: Scaffold(
            backgroundColor: kPrimaryBlackColor,
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
            body:  SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kMp10x),
                child: Column(
                  children: [
                    SizedBox(height: kWh100x,),
                    Center(child: EasyText(text: kSignUpMethodEmail,fontSize: kFi17x,)),
                    SizedBox(height: kWh50x,),
                    SignInTextFieldView(),
                    SizedBox(height: kWh230x,),
                    EasyText(text: kNoteEmail,color: kGreyColor,),
                    SizedBox(height: kMp20x,),
                    SignInButtonView(globalKey: bloc.getGlobalKey,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}




