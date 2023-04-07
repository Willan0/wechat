import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wechat/data/vos/user_vo/user_vo.dart';
import 'package:wechat/network/fire_base_fire_store_data_agent/fire_store_abs.dart';

import '../../constant/string.dart';

class FireStoreIMPL extends FireStoreABS{
  FireStoreIMPL._();
  static final FireStoreIMPL _singleton = FireStoreIMPL._();
  factory FireStoreIMPL()=> _singleton;

  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  @override
  Future<void> createUser(UserVO userVO) {
    return _firebaseFireStore
        .collection(kRootNodeForUser)
        .doc(userVO.id)
        .set(userVO.toJson());
  }

  @override
  Stream<List<UserVO>?> getContactUsersVO(String currentUserId) {
   return _firebaseFireStore.collection(kRootNodeForUser)
       .doc(currentUserId)
       .collection(kRootNodeForContacts)
        .snapshots().map((querySnapshot) {
          return querySnapshot.docs.map((document) {
            return UserVO.fromJson(document.data());
          }).toList();
   });
  }

  @override
  Future<UserVO?> getUserVO(String qr_code) {
    return _firebaseFireStore.collection(kRootNodeForUser).doc(qr_code).get()
    .asStream().map((snapshotData) => UserVO.fromJson(snapshotData.data() ?? {}))
        .first;
  }

  @override
  Future<void> setContactUsersVO(String qr_code,UserVO userVO) {
    return _firebaseFireStore.collection(kRootNodeForUser).doc(qr_code).collection(kRootNodeForContacts)
        .doc(userVO.id).set(userVO.toJson());
  }

}