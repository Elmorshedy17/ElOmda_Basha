import 'dart:async';
import 'package:rxdart/rxdart.dart';

class LoginApiBloc {
/////////////// login
  final BehaviorSubject<String> _emailApiSubject =
  BehaviorSubject<String>();

  Stream<String> get EmailApiStream$ => _emailApiSubject.stream;

  Sink<String> get EmailApiSink => _emailApiSubject.sink;

  String get currentEmailApi => _emailApiSubject.value;




  ////////// sign up
  final BehaviorSubject<String> _passwordApiSubject =
  BehaviorSubject<String>();

  Stream<String> get PasswordApiStream$ => _passwordApiSubject.stream;

  Sink<String> get PasswordApiSink => _passwordApiSubject.sink;
  String get currentPassword => _passwordApiSubject.value;

  dispose() {
    _emailApiSubject.close();
    _passwordApiSubject.close();
  }
}
