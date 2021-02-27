import 'dart:developer';


import 'package:localstorage/localstorage.dart';
enum StorageName{USER}
class LocalStorageHelper{
  static LocalStorage storage;
  static Future saveToStorage({StorageName storageName, String key,var data})async{
    storage=new LocalStorage("$storageName");
    await storage.ready;
    await storage.setItem(key, data);
    log("data saved to $storageName",name: "Storage");
  }
  static Future getFromStorage({StorageName storageName,String key})async{
    storage=LocalStorage("$storageName");
    await storage.ready;
    var data=await storage.getItem(key);
    return data;
  }
  static Future clearStorage({StorageName storageName})async{
    storage=LocalStorage("$storageName");
    await storage.ready;
    await storage.clear();
    log("$storageName cleared",name: "Storage");
  }
}