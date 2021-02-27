part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {

}
class AuthAuthenticated extends AuthState{
  final String token;
  AuthAuthenticated({this.token});
  @override
  List<Object> get props => [token];
}
class AuthUnauthenticated extends AuthState{

}
class AuthLoading extends AuthState{}

class AuthFailure extends AuthState{
  final String message;

  AuthFailure({this.message});
  @override
  List<Object> get props => [message];

}
