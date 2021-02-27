import 'package:truthordare/constants/Strings.dart';
import 'package:truthordare/model/UserModel.dart';
import 'package:truthordare/utilities/local_storage_helper.dart';

class UserRepository{
  Future getUser()async{
    var data=await LocalStorageHelper.getFromStorage(storageName: StorageName.USER,key: Strings.userStorageKey);
    UserModel userModel=userModelFromJson(data);
    return userModel;
  }
}