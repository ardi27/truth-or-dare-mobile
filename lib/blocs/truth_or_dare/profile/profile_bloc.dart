import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:truthordare/constants/Strings.dart';
import 'package:truthordare/model/UserModel.dart';
import 'package:truthordare/repositories/truth_or_dare/profile_repository.dart';
import 'package:truthordare/utilities/local_storage_helper.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  ProfileBloc({this.profileRepository}) : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if(event is LoadProfile){
      yield* _loadProfileToState(event);
    }else if (event is UpdateProfile){
      yield*  _updateProfileToState(event);
    }
  }

   Stream<ProfileState> _updateProfileToState(UpdateProfile event)async* {
    yield ProfileLoading();
    try{
      int statusCode=await profileRepository.updateProfile(data: event.data);
      if(statusCode==200){
        yield ProfileUpdated();
        yield* _loadProfileToState(LoadProfile());
      }
    }catch(e){
      yield ProfileFailure();
    }
   }

  Stream<ProfileState> _loadProfileToState(LoadProfile event) async*{
    yield ProfileLoading();
    try{
      UserModel user=await profileRepository.getUserData();
      yield ProfileLoaded(user: user);
    }catch(e){
      yield ProfileFailure();
    }
  }
}
