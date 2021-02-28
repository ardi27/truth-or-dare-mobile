part of 'user_tod_bloc.dart';

abstract class UserTodState extends Equatable {
  const UserTodState();

  @override
  List<Object> get props => [];
}

class UserTodInitial extends UserTodState {}

class UserTodLoading extends UserTodState {}

class TodDeleted extends UserTodState {}

class UserTodFailure extends UserTodState {
  final String message;

  UserTodFailure({this.message});

  @override
  List<Object> get props => [];
}

class UserTruthLoaded extends UserTodState {
  final List<UserTruth> userTruth;
  final bool hasReachedMax;
  final int currentPage;

  UserTruthLoaded({this.userTruth, this.hasReachedMax, this.currentPage});

  UserTruthLoaded copyWith({
    List<UserTruth> userTruth,
    bool hasReachedMax,
    int currentPage,
  }) {
    return UserTruthLoaded(
      userTruth: userTruth ?? this.userTruth,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [userTruth,hasReachedMax,currentPage];
}

class UserDareLoaded extends UserTodState {
  final List<UserDare> userDare;
  final bool hasReachedMax;
  final int currentPage;

  UserDareLoaded({this.userDare, this.hasReachedMax, this.currentPage});
  UserDareLoaded copyWith({
    List<UserDare> userDare,
    bool hasReachedMax,
    int currentPage,
  }) {
    return UserDareLoaded(
      userDare: userDare ?? this.userDare,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }
  @override
  List<Object> get props => [];
}
