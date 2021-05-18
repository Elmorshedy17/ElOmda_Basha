import 'dart:async';
import 'package:rxdart/rxdart.dart';

class StatusMessageBloc {
/////////////// StatusMessageBloc
  final BehaviorSubject<String> _statusMessageSubject =
  BehaviorSubject<String>();

  Stream<String> get statusMessageStream$ => _statusMessageSubject.stream;

  Sink<String> get statusMessageSink => _statusMessageSubject.sink;

  String get currentStatusMessage => _statusMessageSubject.value;

/////////////// Status
  final BehaviorSubject<String> _statusSubject =
  BehaviorSubject<String>.seeded("agree");

  Stream<String> get UserTypeApiStream$ => _statusSubject.stream;

  Sink<String> get statusSink => _statusSubject.sink;

  String get currentStatus => _statusSubject.value;
  dispose() {
    _statusMessageSubject.close();
    _statusSubject.close();
  }
}
