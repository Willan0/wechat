import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:wechat/data/data_apply/fire_base_abs.dart';
import 'package:wechat/data/vos/user_vo/user_vo.dart';

import '../data/data_apply/fire_base_impl.dart';

class SingUpPageBloc extends ChangeNotifier {
  // state variable
  bool _isDispose = false;
  bool _isVisibility = true;
  bool _isAgree = false;

  // user info
  String _file = '';
  String _userName = '';
  String _countryName = '';
  String _phoneCode = '';
  String _password = '';
  String _email = '';
  final GlobalKey<FormState> _globalKey = GlobalKey();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _regionController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  File? _selectFile;
  String? _filePath;

  bool get isDispose => _isDispose;

  // getter
  // user info
  String get email => _email;
  String get getCountryName => _countryName;
  String get getPhoneCode => _phoneCode;
  String get file => _file;
  String get userName => _userName;
  String get password => _password;
  bool get getIsVisibility => _isVisibility;
  bool get getIsAgree => _isAgree;
  GlobalKey<FormState> get getGlobalKey => _globalKey;
  TextEditingController get getNameController => _nameController;
  TextEditingController get getPhoneController => _phoneController;
  TextEditingController get getPasswordController => _passwordController;
  TextEditingController get getRegionController => _regionController;
  TextEditingController get emailController => _emailController;
  File? get getSelectFile => _selectFile;
  String? get getFilePath => _filePath;

  // setter
  set file(String file) => _file = file;
  set setUserName(String username) => _userName = username;

  set setCountryName(String countryName) => _countryName = countryName;
  set setPhoneCode(String phoneCode) => _phoneCode = phoneCode;

  set setPassword(String password) => _password = password;

  set setEmail(String email) => _email = email;

  // state instance

  final FireBaseApply _fireBaseApply = FireBaseApplyIMPL();

  Future register(String file, String userName, String countryName,
      String phoneCode, String password) {
    UserVO userVO = UserVO(
        'id', file, userName, countryName, phoneCode, password, _email, '');
    return _fireBaseApply.createUser(userVO);
  }

  void setVisibility() {
    if (_isVisibility == true) {
      _isVisibility = false;
    } else {
      _isVisibility = true;
    }
    notifyListeners();
  }

  void setAgree() {
    if (_isAgree == false) {
      _isAgree = true;
    } else {
      _isAgree = false;
    }
    notifyListeners();
  }

  void setSelectFile(File? file) {
    if (file != null) {
      _selectFile = file;
      _file = _selectFile.toString();
      // _post=true;
      notifyListeners();
    }
  }

  void getCountry(context) {
    showCountryPicker(
      context: context,
      onSelect: (value) {
        _countryName = value.displayName;
        _phoneCode = '+${value.phoneCode}';
        _regionController = TextEditingController(text: _countryName);
        _phoneController = TextEditingController(text: _phoneCode);
        notifyListeners();
      },
    );
  }

  @override
  void notifyListeners() {
    if (!_isDispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _isDispose = true;
    _nameController.dispose();
    _phoneController.dispose();
    _regionController.dispose();
    _passwordController.dispose();
  }
}
