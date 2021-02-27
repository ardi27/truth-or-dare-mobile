import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:truthordare/blocs/truth_or_dare/authentication/auth_bloc.dart';
import 'package:truthordare/blocs/truth_or_dare/login/login_bloc.dart';
import 'package:truthordare/blocs/truth_or_dare/profile/profile_bloc.dart';
import 'package:truthordare/blocs/truth_or_dare/truth_or_dare_bloc.dart';
import 'package:truthordare/blocs/truth_or_dare/user_tod/user_tod_bloc.dart';
import 'package:truthordare/repositories/dare_repository.dart';
import 'package:truthordare/repositories/truth_or_dare/login_repository.dart';
import 'package:truthordare/repositories/truth_or_dare/profile_repository.dart';
import 'package:truthordare/repositories/truth_or_dare/user_repository.dart';
import 'package:truthordare/repositories/truth_repository.dart';

final sl=GetIt.instance;
void init(){
  //util
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  GoogleSignIn googleSignIn=GoogleSignIn();

  //repository
  sl.registerLazySingleton(() => UserRepository());

  sl.registerLazySingleton(() => TruthOrDareRepository());
  sl.registerLazySingleton(() => LoginRepository(firebaseAuth: firebaseAuth,googleSignIn: googleSignIn));
  sl.registerLazySingleton(() => ProfileRepository(userRepository: sl.call()));
  //
  //bloc
  sl.registerFactory(() => AuthBloc());
  sl.registerFactory(() => TruthOrDareBloc(truthRepository: sl.call()));
  sl.registerFactory(() => LoginBloc(loginRepository: sl.call(),authBloc: sl.call()));
  sl.registerFactory(() => ProfileBloc(profileRepository: sl.call()));
  sl.registerFactory(() => UserTodBloc(truthOrDareRepository: sl.call()));
}
