import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:truthordare/config/url.dart';
import 'package:truthordare/constants/Strings.dart';
import 'package:truthordare/model/UserModel.dart';
import 'package:truthordare/utilities/http.dart';
import 'package:truthordare/utilities/local_storage_helper.dart';

class UserRepository{
  Future getUser()async{
    Response data=await dio.get("$baseUrl/users/profile",options: Options(headers: {"requireToken":true}));
    UserModel userModel=userModelFromJson(jsonEncode(data.data));
    return userModel;
  }
}