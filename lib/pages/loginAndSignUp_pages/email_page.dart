import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat/bloc/sign_up_bloc.dart';
import 'package:wechat/constant/color.dart';
import 'package:wechat/pages/loginAndSignUp_pages/login_page.dart';
import 'package:wechat/utils/extension.dart';
import 'package:wechat/widgets/easy_button.dart';

import '../../constant/dimen.dart';
import '../../constant/string.dart';
import '../../widgets/easy_icon.dart';
import '../../widgets/easy_text.dart';
import '../../widgets/easy_text_form_field.dart';
import '../../widgets/loading_dialog.dart';

class EmailPage extends StatelessWidget {
  const EmailPage({Key? key, required this.file, required this.userName, required this.countryName, required this.phoneCode, required this.password}) : super(key: key);

  final String file;
  final String userName;
  final String countryName;
  final String phoneCode;
  final String password;

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<SingUpPageBloc>(
      create: (_)=> SingUpPageBloc(),
      child: Consumer<SingUpPageBloc>(
        builder: (context, bloc, child) =>
       Form(
          key: bloc.getGlobalKey,
          child: Scaffold(
            backgroundColor: kPrimaryBlackColor,
            appBar: AppBar(
              leading: EasyIcon(
              icon: CupertinoIcons.clear,
                iconSize: kFi20x,
              onPressed: (){context.previousScreen(context);},
            ),
            backgroundColor: kPrimaryBlackColor,),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: kMp10x),
                child: SizedBox(
                  width: getWidth(context),
                  height: getHeight(context),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: kWh230x,),
                      EasyText(text: kEnterEmail,fontSize: kFi17x,),
                      SizedBox(height: kMp20x,),
                      EasyTextFormField(
                        validate: (text){
                          if ((text?.isEmpty) ?? true) {
                            return kEmailEmpty;
                          }
                          if (!EmailValidator.validate(text ?? '')) {
                            return kEmailInValidText;
                          }
                          return null;
                        },
                        onTap: (){},
                        controller: bloc.emailController, hintText: kEmailEnter,
                        onChanged: (String text) {
                          context.getSignUpBlocInstance().setEmail = text;
                        },
                      ),
                      SizedBox(height: kWh200x,),
                      Center(
                        child: EasyButton(
                            width: kWh230x,
                            height: kWh50x,
                            onPressed: (){
                          if(bloc.getGlobalKey.currentState?.validate() ?? false){
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => const LoadingAlertDialogWidget());
                            context.getSignUpBlocInstance().register(file, userName, countryName, phoneCode, password).then((value) {
                              context.previousScreen(context);
                              context.nextReplacement(context, const LoginPage());
                            }).catchError((error) {
                              context.previousScreen(context);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: EasyText(
                                  text: error.toString(),
                                  color: kPrimaryTextColor,
                                ),
                                backgroundColor: kSecondaryColor,
                              ));
                            });;

                          }
                        }, color: kSecondaryColor, text: 'Done'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
