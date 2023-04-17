import 'package:flutter/material.dart';
import 'package:wechat/data/data_apply/fire_base_abs.dart';
import 'package:wechat/data/data_apply/fire_base_impl.dart';
import 'package:wechat/data/vos/chat_vo/chat_vo.dart';
import 'package:wechat/data/vos/user_vo/user_vo.dart';


class HomePageBloc extends ChangeNotifier{
  bool _isDispose = false;

  List<String> contactUsersId = [];
  List<UserVO> chatting = [];
  List<String> userNameList = [];
  List<String> lastChatIds = [];
  List<ChatVO> lastChatVOs = [];
  String finalMessage = '';

  FireBaseApply _realtimeApply = FireBaseApplyIMPL();
  HomePageBloc(){
    UserVO userVO = _realtimeApply.getUserInfoFromAuth();
    String currentUserId = userVO.id ?? '';

   _realtimeApply.getChattingMessageContactId(currentUserId).listen((event) {
     var temp = event;
    for(var contactId in temp){
      if(!(contactUsersId.contains(contactId))){
        contactUsersId.add(contactId);
        // print('===================> $contactUsersId');
      }
    }
    for(var id in contactUsersId){

      // get user name and profile
      _realtimeApply.getUserVO(id).then((value){
        var uid = value?.id;
        if(!(userNameList.contains(uid))){
          userNameList.add(uid!);
          chatting.add(value!);
          // print('=====================> $chatting');
          notifyListeners();
        }
      });

      // get last message
      _realtimeApply.getChattingMessage(currentUserId, id).listen((event) {
        var lastChatVO = event?.last;
        var lastChatId = event?.last.id;
        if(!(lastChatIds.contains(lastChatId))){
          lastChatIds.add(lastChatId!);
          //print('===============> $lastChatIds');
          lastChatVOs.add(lastChatVO!);
          //print('==============> $lastChatVOs');
          notifyListeners();
        }
      });
    }
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