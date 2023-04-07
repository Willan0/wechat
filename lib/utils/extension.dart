import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat/bloc/profile_bloc.dart';
import 'package:wechat/bloc/sign_in_bloc.dart';
import 'package:wechat/bloc/sign_up_bloc.dart';

import 'enum.dart';

extension ContextExtension on BuildContext{
  void nextScreen(context,widget){
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget,));
  }

  void previousScreen(context){
    Navigator.pop(context);
  }

  void nextReplacement(context,widget){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => widget,)
    );
  }

  SingUpPageBloc getSignUpBlocInstance() => read<SingUpPageBloc>();
  SignInBloc getSignInBlocInstance() => read<SignInBloc>();
  // ProfileBloc getProfileBlocInstance() => read<ProfileBloc>();


}

extension FileExtension on File{
  FileType getFileType() {
    if ((path.endsWith(".png") ) ||
        (path.endsWith(".jpg") ) ||
        (path.endsWith(".jpeg") )) {
      return FileType.image;
    }
    if ((path.endsWith(".mkv") ) ||
        (path.endsWith(".mp4") ) ||
        (path.endsWith(".mov") )) {
      return FileType.video;
    }
    if ((path.endsWith(".pdf") ) || (path.endsWith(".txt") )) {
      return FileType.file;
    }
    return FileType.none;
  }
}