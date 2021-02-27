import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:truthordare/blocs/truth_or_dare/authentication/auth_bloc.dart';
import 'package:truthordare/repositories/truth_or_dare/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  final AuthBloc authBloc;
  LoginBloc( {this.loginRepository,this.authBloc}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is LoginPressed){
      yield* _mapLoginPressed(event);
    }else if(event is RegisterPressed){
      yield* _mapRegisterPressed(event);
    }
  }

  Stream<LoginState> _mapLoginPressed(LoginPressed event) async* {
    yield LoginLoading();
    try{
      String token=await loginRepository.login(username: event.username,password: event.password);
      print(token);
      authBloc.add(UserLoggedIn(token: token));
      yield LoginSuccess();
    }catch(e){
      print(e.message);
      yield LoginFailure(message: e.toString()??"an error occured");
    }
  }

  Stream<LoginState> _mapRegisterPressed(RegisterPressed event) async*{
    yield LoginLoading();
    try{
      bool validateRegister=await loginRepository.register(nama: event.nama,email: event.email,username: event.username,password: event.password);
      if(validateRegister){
        yield RegisterSuccess();
      }else{
        yield LoginFailure(message: "Registrasi gagal");
      }
    }catch(e){
      print(e.message);
      yield LoginFailure(message: e.toString()??"an error occured");
    }
  }
}
