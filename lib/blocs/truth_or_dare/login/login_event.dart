part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}
class LoginPressed extends LoginEvent{
  final String username;
  final String password;
  LoginPressed({this.username,this.password});
  @override
  List<Object> get props => [username,password];
}
class RegisterPressed extends LoginEvent{
  final String username;
  final String nama;
  final String email;
  final String password;
  RegisterPressed({this.username,this.email,this.nama,this.password});
  @override
  List<Object> get props => [username,password,email,nama];
}