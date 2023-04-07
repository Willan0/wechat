
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat/bloc/sign_up_bloc.dart';
import 'package:wechat/constant/color.dart';
import 'package:wechat/pages/loginAndSignUp_pages/privacy_and_policy_page.dart';
import 'package:wechat/utils/extension.dart';
import 'package:wechat/widgets/easy_button.dart';

import '../constant/dimen.dart';
import '../constant/string.dart';
import '../utils/file_picker_util.dart';
import '../widgets/easy_image.dart';
import '../widgets/easy_text.dart';
import '../widgets/easy_text_form_field.dart';

class SelectFileView extends StatelessWidget {
  const SelectFileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<SingUpPageBloc,File?>(
      selector: (_,target)=> target.getSelectFile,
        builder: (context, selectFile, child) =>
        GestureDetector(
          onTap: (){
            getFiles().then((file) {
              context.getSignUpBlocInstance().setSelectFile(file);
            });
          },
            child: Selector<SingUpPageBloc,String?>(
              selector: (_,target)=> target.getFilePath,
                builder: (_,filePath,__){
                if(selectFile== null){
                  return  EasyImage(image: kSelectImage,isNetwork: false,);
                }
                return  SelectFileViewItem(
                  selectFile: selectFile,
                  // type: selectFile.getFileType(),
                );
                }

            )
        )
    );
  }
}

class SelectFileViewItem extends StatelessWidget {
  const SelectFileViewItem({
    Key? key, required this.selectFile,
    // required this.type,
  }) : super(key: key);

  final File selectFile;
  // final FileType type;
  @override
  Widget build(BuildContext context) {
    return Image.file(selectFile,
    width: kWh100x,
      fit: BoxFit.cover,
      height: kWh100x,
    );
  }
}

class SingUpTextFieldView extends StatelessWidget {
  const SingUpTextFieldView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kMp10x),
      child: Column(
        children: [
          // Name
          SingUpTextFieldViewItem(title: kName,hintText: kHintName, validation: (String? validate) {
            if(validate?.isEmpty ?? false){
              return kNameValidate;
            }
            return null;
          }, controller: context.getSignUpBlocInstance().getNameController, onTap: (){},
            onChanged: (String text) {
            context.getSignUpBlocInstance().setUserName = text;
            }
            ,),

          // Region
          Selector<SingUpPageBloc,String>(
            selector: (_,selector)=> selector.getCountryName,
            builder: (_,regionName,__)=>SingUpTextFieldViewItem(title: kRegion,hintText: kRegionSelect, validation: (String? validate) {
              if(validate?.isEmpty ?? false){
                return kRegionValidate;
              }
              return null;
            },
              controller: context.getSignUpBlocInstance().getRegionController,
              onTap: ()=> context.getSignUpBlocInstance().getCountry(context),
              onChanged: (String text) {
                context.getSignUpBlocInstance().setCountryName = text;
              },),
          ),

          // Phone
          Selector<SingUpPageBloc,String>(
            selector: (_,selector)=> selector.getPhoneCode,
            builder: (_,phoneCode,__)=>SingUpTextFieldViewItem(title: kPhone,hintText: kEnterPhone, validation: (String? validate) {
              if(validate?.isEmpty ?? false){
                return kPhoneValidate;
              }
              return null;
            }, controller: context.getSignUpBlocInstance().getPhoneController, onTap: (){},
              onChanged: (String text) {
                context.getSignUpBlocInstance().setPhoneCode = text;
              },),
          ),

          // Password
          SingUpTextFieldViewItem(isPassword:true,title: kPassword,hintText: kPasswordHint, validation: (String? validate) {
            if(validate?.isEmpty ?? false){
              return kPasswordValidate;
            }
            if(validate!.length < 8){
            return kPasswordValidate1;
            }
            return null;
          }, controller: context.getSignUpBlocInstance().getPasswordController, onTap: (){},
            onChanged: (String text) {
              context.getSignUpBlocInstance().setPassword = text;
            },),
        ],
      ),
    );
  }
}

class SingUpTextFieldViewItem extends StatelessWidget {
  const SingUpTextFieldViewItem({Key? key, required this.title,
    required this.hintText, required this.validation,this.isPassword = false, required this.controller, required this.onTap, required this.onChanged
  }) : super(key: key);

  final String title;
  final Function (String? validate) validation;
  final Function (String text) onChanged;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            width: kWh100x,
            child: EasyText(text: title,fontSize: kFi17x,)),
        isPassword?
        Expanded(child:
            Selector<SingUpPageBloc,bool>(
              selector: (_,selector)=> selector.getIsVisibility,
              builder: (_,visibility,__)=> TextFormField(
                style: TextStyle(
                  color: kPrimaryColor,
                ),
                validator: (validate)=> validation(validate),
                decoration: InputDecoration(
                    hintText: hintText,
                    hoverColor: kPrimaryColor,
                    hintStyle: TextStyle(color: kGreyColor),
                    suffixIcon: IconButton(icon: Icon(visibility?Icons.visibility_off:Icons.visibility,color: visibility?kGreyColor:kPrimaryColor,),onPressed: ()=> context.getSignUpBlocInstance().setVisibility(),)
                ),
                obscureText: visibility,
                onChanged: (text) => onChanged(text),
                controller: controller,
              ),
            )
        ):
        Expanded(
          child: EasyTextFormField(
            validate: (validate)=> validation(validate),
            hintText: hintText,
            controller: controller,
            onTap: ()=> onTap(),
            onChanged: (String text) => onChanged(text),
          ),
        )
      ],
    );
  }
}

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kWh40x),
      child: Selector<SingUpPageBloc,bool>(
        selector: (_,selector)=> selector.getIsAgree,
        builder: (_,isAgree,__)=>  Column(
          children: [
            GestureDetector(
              onTap: (){
                context.getSignUpBlocInstance().setAgree();
              },
              child: Row(
                children: [
                  Icon(Icons.check_circle_outline,color: isAgree?kSecondaryColor:kGreyColor,size: kFi25x,),
                  SizedBox(width: kMp10x,),
                  Flexible(child: EasyText(text: kPrivacyAndPolicy,color: kGreyColor,)),
                ],
              ),
            ),
            const SizedBox(height: kMp10x,),
            EasyText(text: kPrivacyNote,color: kGreyColor,),
            SizedBox(height: kMp20x,),
            EasyButton(width:kWh230x,height: kWh50x,onPressed: isAgree?(){
              var globalKey = context.getSignUpBlocInstance().getGlobalKey;
              if(globalKey.currentState?.validate() ?? false){
                context.nextScreen(context, PrivacyAndPolicyPage(file: context.getSignUpBlocInstance().file, userName: context.getSignUpBlocInstance().userName, countryName: context.getSignUpBlocInstance().getCountryName, phoneCode: context.getSignUpBlocInstance().getPhoneCode, password: context.getSignUpBlocInstance().password,));
              }
            }:(){}, color: isAgree?kSecondaryColor:kPrimaryBlackShadowColor, text: kAcceptButton)
          ],
        ),
      ),
    );
  }
}