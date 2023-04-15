import 'dart:io';

abstract class FirebaseStorageStore{
  Future<String> uploadFileToFireStorage(File? file);
}