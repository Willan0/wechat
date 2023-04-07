import 'package:wechat/data/vos/user_vo/user_vo.dart';

abstract class FireBaseAuthABS{

  Future<void> registerNewUser(UserVO newUser);

  Future<void> login(String email,String password);

  bool isLoggedIn();

  Future<void> logout();

  UserVO getLoggedInUserInfo();
}