part of 'user_tod_bloc.dart';

abstract class UserTodEvent extends Equatable {
  const UserTodEvent();
  @override
  List<Object> get props => [];
}
class GetUserTruth extends UserTodEvent{}
class GetMoreUserTruth extends UserTodEvent{
  final int currentPage;

  GetMoreUserTruth({this.currentPage});
  @override
  List<Object> get props => [currentPage];

}
class DeleteUserTod extends UserTodEvent{
  final String type;
  final String uuid;

  DeleteUserTod({this.type, this.uuid});
  @override
  List<Object> get props => [type,uuid];
}
class GetUserDare extends UserTodEvent{}
class GetMoreUserDare extends UserTodEvent{
  final int currentPage;
  GetMoreUserDare({this.currentPage});
  @override
  List<Object> get props => [currentPage];
}
