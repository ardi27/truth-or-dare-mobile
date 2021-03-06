part of 'truth_or_dare_bloc.dart';

abstract class TruthOrDareState extends Equatable {
  const TruthOrDareState();
  @override
  List<Object> get props => [];
}

class TruthOrDareInitial extends TruthOrDareState {}
class TodLoading extends TruthOrDareState{}

class TruthLoaded extends TruthOrDareState{
  final TruthModel truthModel;
  final int selectedLevel;
  TruthLoaded({this.truthModel,this.selectedLevel=-1});
  @override
  List<Object> get props => [truthModel];
}
class DareLoaded extends TruthOrDareState{
  final DareModel dareModel;
  final int selectedLevel;
  DareLoaded({this.dareModel,this.selectedLevel=-1 });
  @override
  List<Object> get props => [dareModel];
}
class TodAdded extends TruthOrDareState{}

class TodError extends TruthOrDareState{
  final String errMessage;
  final bool isTruth;
  TodError({this.errMessage,this.isTruth});
  @override
  List<Object> get props => [errMessage,isTruth];
}
