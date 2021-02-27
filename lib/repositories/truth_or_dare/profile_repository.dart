import 'package:truthordare/model/UserModel.dart';
import 'package:truthordare/repositories/truth_or_dare/user_repository.dart';

class ProfileRepository{
  final UserRepository userRepository;
  ProfileRepository({this.userRepository});
  Future getUserData()async{
    try{
      UserModel userModel=await userRepository.getUser();
      return userModel;
    }catch(e){
      throw Exception(e);
    }
  }
}