import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:truthordare/utilities/SharedPreferences.dart';
import 'package:truthordare/utilities/local_storage_helper.dart';
import 'package:truthordare/utilities/secure_store.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if(event is AppStarted){
      yield* _mapAppStarted(event);
    }else if (event is UserLoggedIn){
      yield AuthAuthenticated(token: event.token);
    }else if(event is UserLoggedOut){
      yield AuthLoading();
      await SecureStore().deleteAll();
      await Preferences.getDataBool("level");
      await LocalStorageHelper.clearStorage(storageName: StorageName.USER);
      yield AuthUnauthenticated();
    }
  }
  Stream<AuthState> _mapAppStarted(AppStarted event)async*{
    yield AuthLoading();
    try{
      String token=await SecureStore().readValue(key: 'token');
      if(token!=null){
        yield AuthAuthenticated(token: token);
      }else{
        yield AuthUnauthenticated();
      }
    }catch(e){
      print(e.toString());
      yield AuthFailure(message: e.toString()??"An error occured");
    }
  }
}
