import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:truthordare/config/url.dart';
import 'package:truthordare/model/DareModel.dart';
import 'package:truthordare/model/TruthModel.dart';
import 'package:truthordare/model/UserDareModel.dart';
import 'package:truthordare/model/UserTruthModel.dart';
import 'package:truthordare/screen/truth_or_dare/user_truth.dart';
import 'package:truthordare/utilities/http.dart';

class TruthOrDareRepository{
  Future getRandomTruth() async{
    try{
      Response response = await dio.get(
        '$baseUrl/truth/random',
      );
      final dynamic data = response.data;
      final TruthModel record = truthModelFromJson(jsonEncode(data));
      return record;
    }catch(e){
      throw Exception(e);
    }
  }
  Future getRandomDare() async{
    try{
      Response response = await dio.get(
        '$baseUrl/dare/random',
      );
      final dynamic data = response.data;
      final DareModel record = dareModelFromJson(jsonEncode(data));
      return record;
    }catch(e){
      throw Exception(e);
    }
  }
  Future getUserTod({String type,int page}) async{
    try{
      Response response = await dio.get(
        '$baseUrl/$type/by_user?page=$page',options: Options(headers: {'requireToken':true})
      );
      final dynamic data = response.data;
      if(type=='dare'){
        final UserDareModel record = userDareModelFromJson(jsonEncode(data));
        return record;
      }else if(type=='truth'){
        final UserTruthModel record = userTruthModelFromJson(jsonEncode(data));
        return record;
      }
      return null;
    }catch(e){
      throw Exception(e);
    }
  }
  Future submitTod({String type,String value,String level})async{
    try{
      Response response = await dio.post("$baseUrl/$type/store",data: {
        type:value,
        'level':level
      },options: Options(headers: {"requireToken":true}));
      return response.statusCode;
    }catch(e){
      throw Exception(e);
    }
  }
  Future deleteUserTod({String uuid,String type})async{
    try{
      Response response = await dio.delete("$baseUrl/$type/delete/$uuid",options: Options(headers: {"requireToken":true}));
      return response.statusCode;
    }catch(e){
      throw Exception(e);
    }
  }
}