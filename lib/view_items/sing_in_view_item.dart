import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat/bloc/sign_in_bloc.dart';
import 'package:wechat/utils/extension.dart';
import 'package:wechat/widgets/easy_text.dart';

import '../constant/color.dart';
import '../constant/dimen.dart';
import '../constant/string.dart';
import '../pages/nav_pages/bottom_nav_page.dart';
import '../widgets/easy_button.dart';
import '../widgets/easy_text_form_field.dart';
import '../widgets/loading_dialog.dart';

class SignInTextFieldView extends StatelessWidget {
  const SignInTextFieldView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SignInTextFieldViewItem(
          validate: (text){
            if ((text?.isEmpty) ?? true) {
              return kEmailEmpty;
            }
            if (!EmailValidator.validate(text ?? '')) {
              return kEmailInValidText;
            }
            return null;
          }, title: kEmail, hintText: kEmailEnter,
          onChanged: (String text) {  context.getSignInBlocInstance().email = text;},
        ),
        Row(
          children: [
            SizedBox(width:kWh100x,child: EasyText(text: kPassword)),
            Selector<SignInBloc,bool>(
              selector: (_,selector)=> selector.getIsVisibility,
              builder: (_,visibility,__)=> Expanded(
                child: TextFormField(
                  style: TextStyle(
                    color: kPrimaryColor,
                  ),
                  validator: (text){
                    if(text?.isEmpty ?? false){
                      return kPasswordValidate;
                    }
                    if(text!.length <8){
                      return kPasswordValidate1;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: kPassword,
                      hoverColor: kPrimaryColor,
                      hintStyle: TextStyle(color: kGreyColor),
                      suffixIcon: IconButton(icon: Icon(visibility?Icons.visibility_off:Icons.visibility,color: visibility?kGreyColor:kPrimaryColor,),onPressed: ()=> context.getSignUpBlocInstance().setVisibility(),)
                  ),
                  obscureText: visibility,
                  onChanged: (text){
                    context.getSignInBlocInstance().password = text;
                  },
                  controller: context.getSignInBlocInstance().getPasswordController,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}


class SignInTextFieldViewItem extends StatelessWidget {
  const SignInTextFieldViewItem({
    Key? key, required this.validate, required this.title, required this.hintText, required this.onChanged,
  }) : super(key: key);

  final Function (String? text) validate;
  final String title;
  final String hintText;
  final Function (String text) onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width:kWh100x,child: EasyText(text: title)),
        Expanded(child: EasyTextFormField(validate: (text)=> validate(text), controller: context.getSignInBlocInstance().getEmailController, hintText: hintText, onTap: (){}, onChanged: (text)=> onChanged(text))),
      ],
    );
  }
}
class SignInButtonView extends StatelessWidget {
  const SignInButtonView({
    Key? key, required this.globalKey,
  }) : super(key: key);

  final GlobalKey<FormState> globalKey;

  @override
  Widget build(BuildContext context) {
    return EasyButton(
        width: kWh200x,
        height: kWh50x,
        onPressed: (){
          if (globalKey.currentState?.validate() ?? false) {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => const LoadingAlertDialogWidget());
            context.getSignInBlocInstance().Login().then((value) {
              context.previousScreen(context);
              context.nextReplacement(context, const BottomNavigationPage());
            }).catchError((error) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: EasyText(
                  text: error.toString(),
                  color: kPrimaryTextColor,
                ),
                backgroundColor: kPrimaryColor,
              ));
            });
            context.getSignInBlocInstance().getEmailController.clear();
            context.getSignInBlocInstance().getPasswordController.clear();
          } else {}
        }, color: kSecondaryColor, text: kAcceptButton);
  }
}
