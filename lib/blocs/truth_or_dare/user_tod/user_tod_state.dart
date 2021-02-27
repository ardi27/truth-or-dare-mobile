part of 'user_tod_bloc.dart';

abstract class UserTodState extends Equatable {
  const UserTodState();
  @override
  List<Object> get props => [];
}

class UserTodInitial extends UserTodState {

}
class UserTodLoading extends UserTodState{}
class UserTodFailure extends UserTodState{
  final String message;


  UserTodFailure({this.message});

  @override
  List<Object> get props => [];
}
class UserTruthLoaded extends UserTodState{
  final List<UserTruth> userTruth;
  final bool hasReachedMax;
  final int currentPage;

  UserTruthLoaded({this.userTruth, this.hasReachedMax, this.currentPage});

  @override
  List<Object> get props => [];
}
class UserDareloaded extends UserTodState{
  final List<UserDare> userDare;
  final bool hasReachedMax;
  final int currentPage;

  UserDareloaded({this.userDare, this.hasReachedMax, this.currentPage});
  @override
  List<Object> get props => [];
}
