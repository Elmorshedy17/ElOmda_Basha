import 'dart:async';
import 'package:rxdart/rxdart.dart';

class FilterScreenBloc {
/////////////// USER TYPE
  final BehaviorSubject _filterSubject =
  BehaviorSubject();

//  Stream get UserTypeApiStream$ => _UserTypeSubject.stream;

  Sink get filterSink => _filterSubject.sink;

  String get currentFilter => _filterSubject.value;
  dispose() {
    _filterSubject.close();
  }
}
