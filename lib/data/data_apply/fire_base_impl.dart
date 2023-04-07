 import 'package:wechat/data/data_apply/fire_base_abs.dart';
import 'package:wechat/data/vos/chat_vo/chat_vo.dart';
import 'package:wechat/data/vos/user_vo/user_vo.dart';
import 'package:wechat/network/fire_base_auth_data_agent/fire_base_auth_abs.dart';
import 'package:wechat/network/fire_base_auth_data_agent/fire_base_auth_impl.dart';
import 'package:wechat/network/fire_base_fire_store_data_agent/fire_store_abs.dart';
import 'package:wechat/network/fire_base_real_time_data_agent/real_time_database_impl.dart';

import '../../network/fire_base_fire_store_data_agent/fire_store_impl.dart';
import '../../network/fire_base_real_time_data_agent/real_time_database_abs.dart';

class FireBaseApplyIMPL extends FireBaseApply{
  FireBaseApplyIMPL._();
  static final FireBaseApplyIMPL _singleton = FireBaseApplyIMPL._();
  factory FireBaseApplyIMPL()=> _singleton;

 final FireStoreABS _fireStore = FireStoreIMPL();
 final FireBaseAuthABS _fireBaseAuth = FireBaseAuthIMPl();
 final RealTimeDataBaseAbs _realTimeDataBase = RealTimeDataBaseImpl();

  @override
  Future createUser(UserVO userVO) => _fireBaseAuth.registerNewUser(userVO);

  @override
  bool isLoggedIn() => _fireBaseAuth.isLoggedIn();

  @override
  Future logout() => _fireBaseAuth.logout();

  @override
  Future login(String email, String password) => _fireBaseAuth.login(email, password);

  @override
  UserVO getUserInfoFromAuth() => _fireBaseAuth.getLoggedInUserInfo();

  @override
  Future<UserVO?> getUserVO(String qr_code) =>
    _fireStore.getUserVO(qr_code);

  @override
  Future<void> setContactUserVO(String qr_code, UserVO userVO) => _fireStore.setContactUsersVO(qr_code, userVO);

  @override
  Stream<List<UserVO>?> getAllContactUsers(String currentUserId) => _fireStore.getContactUsersVO(currentUserId);

  @override
  Future<void> createChatting(String currentUserId, String chattingUserId, ChatVO chatVO) => _realTimeDataBase.createChatting(currentUserId, chattingUserId, chatVO);

  @override
  Stream<List<ChatVO>?> getChattingMessage(String currentUserId, String chattingUserId)
 => _realTimeDataBase.getChattingMessage(currentUserId, chattingUserId);


}