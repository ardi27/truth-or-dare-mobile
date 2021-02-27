import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:truthordare/model/DareModel.dart';
import 'package:truthordare/model/TruthModel.dart';
import 'package:truthordare/repositories/dare_repository.dart';
import 'package:truthordare/repositories/truth_repository.dart';

part 'truth_or_dare_event.dart';
part 'truth_or_dare_state.dart';

class TruthOrDareBloc extends Bloc<TruthOrDareEvent, TruthOrDareState> {
  final TruthOrDareRepository truthRepository;
  TruthOrDareBloc({this.truthRepository}) : super(TruthOrDareInitial());
  @override
  Stream<TruthOrDareState> mapEventToState(
    TruthOrDareEvent event,
  ) async* {
    if(event is GetDare){
      yield* _getDareToState(event);
    }else if(event is GetTruth){
      yield* _getTruthToState(event);
    }else if(event is SubmitTruthOrDare){
      yield* _submitTodToState(event);
    }
  }

  Stream<TruthOrDareState> _getDareToState(TruthOrDareEvent event) async*{
    yield TodLoading();
    try{
      DareModel dareModel=await truthRepository.getRandomDare();
      yield DareLoaded(dareModel: dareModel);
    }catch(e){
      yield TodError(errMessage: e.toString()??"An error occured",isTruth: false);
    }
  }

  Stream<TruthOrDareState> _getTruthToState(TruthOrDareEvent event) async*{
    yield TodLoading();
    try{
      TruthModel truthModel=await truthRepository.getRandomTruth();
      yield TruthLoaded(truthModel: truthModel);
    }catch(e){
      yield TodError(errMessage: e.toString()??"An error occured",isTruth: true);
    }
  }

  Stream<TruthOrDareState> _submitTodToState(SubmitTruthOrDare event) async*{
    yield TodLoading();
    try{
      int statusCode= await truthRepository.submitTod(type: event.type,value: event.value,level: event.level);

      if(statusCode==201){
        yield TodAdded();
      }else{
        yield TodError(errMessage: "An error occured");
      }
    }catch(e){
      yield TodError(errMessage: e.toString()??"Am error occured");
    }
  }

}
