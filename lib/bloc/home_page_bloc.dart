import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:wechat/data/data_apply/fire_base_abs.dart';
import 'package:wechat/data/data_apply/fire_base_impl.dart';
import 'package:wechat/data/vos/user_vo/user_vo.dart';
import 'package:wechat/network/fire_base_real_time_data_agent/real_time_database_abs.dart';
import 'package:wechat/network/fire_base_real_time_data_agent/real_time_database_impl.dart';

class HomePageBloc extends ChangeNotifier{
  bool _isDispose = false;

  List<Object?> contactUsersId = [];

  RealTimeDataBaseAbs _realTimeDataBase = RealTimeDataBaseImpl();
  FireBaseApply _realtimeApply = FireBaseApplyIMPL();
  HomePageBloc(){
    UserVO userVO = _realtimeApply.getUserInfoFromAuth();
    _realTimeDataBase.getChattingMessageContactId(userVO.id ?? '').listen((event) {
      contactUsersId = event;
      print('object=====================> $contactUsersId');
    });
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