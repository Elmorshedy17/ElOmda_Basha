import 'dart:async';
import 'package:rxdart/rxdart.dart';

class DliveryUpdateDetailsBloc {
/////////////// USER TYPE
  final BehaviorSubject _dliveryUpdateDetailsBloc =
  BehaviorSubject();

  Stream get DliveryUpdateDetailsStream$ => _dliveryUpdateDetailsBloc.stream;

  Sink get DliveryUpdateDetailsSink => _dliveryUpdateDetailsBloc.sink;

   get currentDliveryUpdateDetails => _dliveryUpdateDetailsBloc.value;
  dispose() {
    _dliveryUpdateDetailsBloc.close();
  }
}
