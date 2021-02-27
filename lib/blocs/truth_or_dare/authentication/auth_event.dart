part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}
class AppStarted extends AuthEvent{}
class UserLoggedIn extends AuthEvent {
  final token;

  UserLoggedIn({@required this.token});

  @override
  List<Object> get props => [token];
}

// Fired when the user has logged out
class UserLoggedOut extends AuthEvent {}
