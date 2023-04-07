import 'package:wechat/data/vos/user_vo/user_vo.dart';

abstract class FireStoreABS{

  Future<UserVO?> getUserVO(String qr_code);

  Future<void> setContactUsersVO(String qr_code,UserVO userVO);

  Stream<List<UserVO>?> getContactUsersVO(String currentUserId);

  Future<void> createUser(UserVO userVO);
}