part of 'truth_or_dare_bloc.dart';

abstract class TruthOrDareEvent extends Equatable {
  const TruthOrDareEvent();
  @override
  List<Object> get props => [];
}
class GetTruth extends TruthOrDareEvent{

}
class GetDare extends TruthOrDareEvent{

}

class SubmitTruthOrDare extends TruthOrDareEvent{
  final String type;
  final String value;
  final String level;

  SubmitTruthOrDare({this.type, this.value, this.level});
  @override
  List<Object> get props => [type,value,level];
}
