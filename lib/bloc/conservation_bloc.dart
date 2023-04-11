
import 'package:flutter/material.dart';

import '../data/data_apply/fire_base_abs.dart';
import '../data/data_apply/fire_base_impl.dart';
import '../data/vos/chat_vo/chat_vo.dart';
import '../data/vos/user_vo/user_vo.dart';

class ConservationPageBloc extends ChangeNotifier{
 bool _isDispose = false;
 List<ChatVO> chatMessages = [];
 List<ChatVO> chatContacts = [];
 UserVO? currentUser;
 String contactUserId = '';
 String currentUserId = '';
 bool _sendMessageCheck = false;
 String _message = '';
 String _lastMessage = '';
 TextEditingController _chatController = TextEditingController();

 bool get sendMessageCheck => _sendMessageCheck;
 String get lastMessage => _lastMessage;
 TextEditingController get chatController => _chatController;


  final FireBaseApply _fireBaseApply = FireBaseApplyIMPL();
 ConservationPageBloc(contactUserId){
   this.contactUserId = contactUserId;
   UserVO? user = _fireBaseApply.getUserInfoFromAuth();
   currentUserId = user.id ?? '';
   _fireBaseApply
       .getUserVO(currentUserId)
       .then((value) => currentUser = value);

   _fireBaseApply
       .getChattingMessage(currentUserId, contactUserId)
       .listen((event) {
     chatMessages = event ?? [];
     notifyListeners();
     });
 }
 void sendMessage() {
     ChatVO chatVO = ChatVO(
         DateTime.now().microsecondsSinceEpoch.toString(),
         '',
         _message,
         currentUser?.userName ?? '',
         currentUser?.file ?? '',
         DateTime.now().toString(),
         currentUserId,
         'video_file');
     _fireBaseApply.createChatting(
         currentUserId, contactUserId, chatVO);
     _fireBaseApply.createChatting(
         contactUserId, currentUserId, chatVO);
   _chatController.clear();
   _sendMessageCheck = false;
   notifyListeners();
 }

 void checkMessage(text) {
 if (text.isNotEmpty) {
 _sendMessageCheck = true;
 } else {
   _sendMessageCheck = false;
 }
 _message = text;
 notifyListeners();
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
    _chatController.dispose();
  }
}