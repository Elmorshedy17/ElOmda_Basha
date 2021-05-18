import 'dart:async';
import 'package:rxdart/rxdart.dart';

class UserTypeBloc {
/////////////// USER TYPE
  final BehaviorSubject<String> _UserTypeSubject =
  BehaviorSubject<String>();

//  Stream<String> get UserTypeApiStream$ => _UserTypeSubject.stream;

  Sink<String> get UserTypeSink => _UserTypeSubject.sink;

  String get currentUserType => _UserTypeSubject.value;
  dispose() {
    _UserTypeSubject.close();
  }
}
