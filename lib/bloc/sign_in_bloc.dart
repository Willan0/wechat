import 'package:flutter/material.dart';
import 'package:wechat/data/data_apply/fire_base_abs.dart';
import 'package:wechat/data/data_apply/fire_base_impl.dart';

class SignInBloc extends ChangeNotifier{
  bool _isDispose= false;
  bool _isVisibility = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey();
  String _email = '';
  String _password = '';

  bool get getIsVisibility => _isVisibility;
  TextEditingController get getEmailController => _emailController;
  TextEditingController get getPasswordController => _passwordController;
  GlobalKey<FormState> get getGlobalKey => _globalKey;


  set password(String password) =>
    _password = password;

  set email(String email) =>
    _email = email;

  // state instance
  final FireBaseApply _fireBaseApply = FireBaseApplyIMPL();

  Future Login(){
    return _fireBaseApply.login(_email, _password);
  }


  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    if(!_isDispose){
      super.notifyListeners();
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _isDispose = true;
  }


}