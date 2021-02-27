import 'package:dio/dio.dart';
import 'package:truthordare/config/url.dart';
import 'package:truthordare/model/UserModel.dart';
import 'package:truthordare/repositories/truth_or_dare/user_repository.dart';
import 'package:truthordare/utilities/http.dart';

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
  Future updateProfile({Map data})async{
    try{
      print(data);
      Response  response=await dio.patch("$baseUrl/users/update_profile",data: data,options: Options(headers: {'requireToken':true}));
      return response.statusCode;
    }catch(e){
      throw Exception(e);
    }
  }
}