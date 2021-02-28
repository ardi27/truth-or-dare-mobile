import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:truthordare/model/UserDareModel.dart';
import 'package:truthordare/model/UserTruthModel.dart';
import 'package:truthordare/repositories/truth_repository.dart';

part 'user_tod_event.dart';
part 'user_tod_state.dart';

class UserTodBloc extends Bloc<UserTodEvent, UserTodState> {
  final TruthOrDareRepository truthOrDareRepository;
  UserTodBloc({this.truthOrDareRepository}) : super(UserTodInitial());
  List<UserDare> userDare;
  List<UserTruth> userTruth;
  @override
  Stream<UserTodState> mapEventToState(
    UserTodEvent event,
  ) async* {
    if(event is GetUserDare){
       userDare=[];
      yield* _getUserDareToState(event);
    }else if(event is GetUserTruth){
      userTruth=[];
      yield* _getUserTruthToState(event);
    }else if(event is DeleteUserTod){
      yield* _deleteUserTodToState(event);
    }else if(event is GetMoreUserTruth){
      yield* _getMoreUserTruthToState(event);
    }else if(event is GetMoreUserDare){
      yield* _getMoreUserDareToState(event);
    }
  }
  Stream<UserTodState> _getUserTruthToState(GetUserTruth event)async* {
    yield UserTodLoading();
    try{

      int currentPage=1;
      bool hasReachedMax=false;
      UserTruthModel userTruthModel=await truthOrDareRepository.getUserTod(type: "truth",page:currentPage);
      if(userTruthModel.results.lastPage==currentPage){
        hasReachedMax=true;
      }
      userTruthModel.results.data.forEach((element) {
        userTruth.add(element);
      });
      yield UserTruthLoaded(userTruth: userTruth,hasReachedMax: hasReachedMax,currentPage: currentPage);
    }catch(e){
      yield UserTodFailure(message: e.toString()??"an error occured");
    }
  }
  Stream<UserTodState> _getUserDareToState(GetUserDare event)async* {
    yield UserTodLoading();
    try{
      int currentPage=1;
      bool hasReachedMax=false;
      UserDareModel userDareModel=await truthOrDareRepository.getUserTod(type: "dare",page:currentPage);
      if(userDareModel.results.lastPage==currentPage){
        hasReachedMax=true;
      }
      userDareModel.results.data.forEach((element) {
        userDare.add(element);
      });
      yield UserDareloaded(userDare: userDare,hasReachedMax: hasReachedMax,currentPage: currentPage);
    }catch(e){
      yield UserTodFailure(message: e.toString()??"an error occured");
    }
  }
  Stream<UserTodState> _deleteUserTodToState(DeleteUserTod event)async*{
    try{
      int statusCode=await truthOrDareRepository.deleteUserTod(uuid: event.uuid,type: event.type);
      if(statusCode==200){
        if(event.type=='truth'){
          yield TodDeleted();
          yield* _getUserTruthToState(GetUserTruth());
        }else{
          yield TodDeleted();
          yield* _getUserDareToState(GetUserDare());
        }
      }
    }catch(e){
      yield UserTodFailure(message: e.toString()??"an error occured");
    }
  }

  Stream _getMoreUserTruthToState(GetMoreUserTruth event)async* {
    try{
      int currentPage=event.currentPage;
      bool hasReachedMax=false;
      UserTruthModel userTruthModel=await truthOrDareRepository.getUserTod(type: "truth",page:currentPage+=1);
      if(userTruthModel.results.lastPage==currentPage){
        hasReachedMax=true;
      }
      userTruthModel.results.data.forEach((element) {
        userTruth.add(element);
      });
      yield UserTruthLoaded(userTruth: userTruth,hasReachedMax: hasReachedMax,currentPage: currentPage);
    }catch(e){
      yield UserTodFailure(message: e.toString()??"an error occured");
    }
  }

  Stream _getMoreUserDareToState(GetMoreUserDare event)async* {
    try{
      int currentPage=event.currentPage;
      bool hasReachedMax=false;
      UserDareModel userDareModel=await truthOrDareRepository.getUserTod(type: "dare",page:currentPage+=1);
      if(userDareModel.results.lastPage==currentPage){
        hasReachedMax=true;
      }
      userDareModel.results.data.forEach((element) {
        userDare.add(element);
      });
      yield UserDareloaded(userDare: userDare,hasReachedMax: hasReachedMax,currentPage: currentPage);
    }catch(e){
      yield UserTodFailure(message: e.toString()??"an error occured");
    }
  }
}
