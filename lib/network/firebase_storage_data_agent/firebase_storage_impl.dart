import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:wechat/constant/string.dart';

import 'firebase_storage_abs.dart';

class FirebaseStorageStoreImpl extends FirebaseStorageStore{
  FirebaseStorageStoreImpl._();
  static final FirebaseStorageStoreImpl _singleton = FirebaseStorageStoreImpl._();
  factory FirebaseStorageStoreImpl()=> _singleton;

  final _firebaseStorage = FirebaseStorage.instance;
  @override
  Future<String> uploadFileToFireStorage(File? image) =>
    _firebaseStorage.ref(kPathForImage).child(DateTime.now().toString()).putFile(image!).then((takeSnapshot) => takeSnapshot.ref.getDownloadURL());

}