import 'package:firebase_auth/firebase_auth.dart';
import 'package:wechat/data/vos/user_vo/user_vo.dart';
import 'package:wechat/network/fire_base_auth_data_agent/fire_base_auth_abs.dart';
import 'package:wechat/network/fire_base_fire_store_data_agent/fire_store_impl.dart';

import '../fire_base_fire_store_data_agent/fire_store_abs.dart';

class FireBaseAuthIMPl extends FireBaseAuthABS{
  FireBaseAuthIMPl._();
  static final FireBaseAuthIMPl _singleton = FireBaseAuthIMPl._();
  factory FireBaseAuthIMPl() => _singleton;

  var auth = FirebaseAuth.instance;
  final FireStoreABS _fireStore = FireStoreIMPL();
  @override
  bool isLoggedIn() {
    return auth.currentUser !=null;
  }

  @override
  Future<void> login(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> logout() {
   return auth.signOut();
  }

  @override
  Future<void> registerNewUser(UserVO newUser) {
    return auth.createUserWithEmailAndPassword(
        email: newUser.email ?? '', password: newUser.password ?? '').
    then((credential) {
      User? user = credential.user;
      if(user!= null){
        user.updateDisplayName(newUser.userName).then((_) {
          final User? user = auth.currentUser;
          newUser.id = user?.uid;
          newUser.qr_code = user?.uid;
          _fireStore.createUser(newUser);
        });
      }
    });
  }

  @override
  UserVO getLoggedInUserInfo() {
   return UserVO(
       auth.currentUser?.uid.toString(),
       auth.currentUser?.photoURL.toString(),
       auth.currentUser?.displayName.toString(),
       '',
       '',
       'password',
       'email',
       auth.currentUser?.uid.toString());
  }

}