import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:truthordare/config/url.dart';
import 'package:truthordare/constants/Strings.dart';
import 'package:truthordare/model/JwtModel.dart';
import 'package:truthordare/utilities/http.dart';
import 'package:truthordare/utilities/local_storage_helper.dart';
import 'package:truthordare/utilities/secure_store.dart';

class LoginRepository{
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  LoginRepository({this.googleSignIn,this.firebaseAuth});
  Future<String> login({String username,String password})async{
    try{
      final loginBody={
        'username':username,
        'password':password
      };
      print(loginBody);
      Response response=await dio.post("$baseUrl/auth/login",data: loginBody,options: Options(contentType: Headers.formUrlEncodedContentType));
      String token=response.data['results'];
      JwtModel jwtModel =jwtModelFromJson(ascii.decode(base64.decode(base64.normalize(token.split(".")[1]))));
      print(jsonEncode(jwtModel.sub));
      await LocalStorageHelper.saveToStorage(storageName: StorageName.USER,key: Strings.userStorageKey,data: jsonEncode(jwtModel.sub));
      await SecureStore()
          .writeValue(key: "token", value: token);
      return token;
    }catch(e){
      throw Exception(e);
    }
  }
  Future<bool> register({String nama,String email,String username, String password})async{
   try{
     final registerBody={
       "username":username,
       "name":nama,
       "email":email,
       "password":password
     };
     Response response = await dio.post("$baseUrl/auth/register",data: registerBody);
     if(response.statusCode==201){
       return true;
     }else{
       return false;
     }
   }catch(e){
     throw Exception(e);
   }

  }

  Future<User> signInWithGoogle()async{
    final GoogleSignInAccount googleSignInAccount=await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication=await googleSignInAccount.authentication;
    final AuthCredential credential=GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken
    );
    final UserCredential authResult=await firebaseAuth.signInWithCredential(credential);
    final User user=authResult.user;
    if(user!=null){
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = firebaseAuth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      return user;
    }
    return null;
  }
  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    print("User Signed Out");
  }
}