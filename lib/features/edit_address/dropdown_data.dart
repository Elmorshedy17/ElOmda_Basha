import 'dart:async';
import 'package:rxdart/rxdart.dart';

class EditDrobDownBloc{

  final BehaviorSubject _DrobDownBlocSubject =
  BehaviorSubject();

  Stream get DrobDownBlocStream$ => _DrobDownBlocSubject.stream;
  Sink get DrobDownBlocSink => _DrobDownBlocSubject.sink;
  get currentDrobDownBloc => _DrobDownBlocSubject.value;



  final BehaviorSubject _DrobDownvalueSubject =
  BehaviorSubject.seeded("");

  Stream get DrobDownvalueStream$ => _DrobDownvalueSubject.stream;
  Sink get DrobDownvalueSink => _DrobDownvalueSubject.sink;
  get currentDrobDownvalue => _DrobDownvalueSubject.value;

  dispose() {
    _DrobDownBlocSubject.close();
    _DrobDownvalueSubject.close();
  }
}
