part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}
class LoadProfile extends ProfileEvent{
}
class UpdateProfile extends ProfileEvent{
  final Map data;
  UpdateProfile({this.data});
  @override
  List<Object> get props => [data];
}
