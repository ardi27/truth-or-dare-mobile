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
      yield ProfileLoading();
      try{
        UserModel user=await profileRepository.getUserData();
        yield ProfileLoaded(user: user);
      }catch(e){
        yield ProfileFailure();
      }
    }
  }
}
