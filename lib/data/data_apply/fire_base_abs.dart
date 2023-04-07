import '../vos/chat_vo/chat_vo.dart';
import '../vos/user_vo/user_vo.dart';

abstract class FireBaseApply{
  Future createUser(UserVO userVO);

  bool isLoggedIn();

  Future logout();

  Future login(String email,String password);

  UserVO getUserInfoFromAuth();

  Future<UserVO?> getUserVO(String qr_code);

  Future<void> setContactUserVO(String qr_code,UserVO userVO);

  Stream<List<UserVO>?> getAllContactUsers(String currentUserId);

  Future<void> createChatting(String currentUserId,String chattingUserId,ChatVO chatVO);

  Stream<List<ChatVO>?> getChattingMessage(String currentUserId,String chattingUserId);

}