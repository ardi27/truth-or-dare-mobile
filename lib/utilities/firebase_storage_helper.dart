import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageHelper{
  static FirebaseStorage firebaseStorage=FirebaseStorage.instance;
  static Future<String> getUrlFromStorage({String key})async{

    String url=await firebaseStorage.ref(key).getDownloadURL();
    if(url!=null) {
      return url;
    }else{
      return null;
    }
  }
  static Future<String> uploadToStorage({String key,String path})async{
    File file=File(path);
    try{
      await firebaseStorage.ref(key).putFile(file);
      return await getUrlFromStorage(key: key);
    }on FirebaseException catch (e){
      throw Exception(e);
    }
  }
}