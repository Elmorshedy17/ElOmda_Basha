import 'dart:async';
import 'package:rxdart/rxdart.dart';

class UserIdBloc {
/////////////// USER TYPE
  final BehaviorSubject _UserIdSubject =
  BehaviorSubject();

//  Stream get UserTypeApiStream$ => _UserTypeSubject.stream;

  Sink get UserIdSink => _UserIdSubject.sink;

  String get currentUserId => _UserIdSubject.value;
  dispose() {
    _UserIdSubject.close();
  }
}
