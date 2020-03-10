import 'dart:async';

import 'package:momentoo/shared/helper/manager.dart';
import 'package:momentoo/shared/validation/validation.dart';
import 'package:rxdart/rxdart.dart';

class SignInValidationManager with Validation implements Manager {
  final _emailSubject = BehaviorSubject<String>();
  Stream<String> get email$ => _emailSubject.stream.transform(validateEmail);
  Sink<String> get inEmail => _emailSubject.sink;

  final _passwordSubject = BehaviorSubject<String>();
  Stream<String> get password$ =>
      _passwordSubject.stream.transform(validateField);
  Sink<String> get inPassword => _passwordSubject.sink;

  final _checkBoxSubject = BehaviorSubject<bool>.seeded(true);
  Stream<bool> get checkBoxValue$ => _checkBoxSubject.stream;
  void setCheckBoxValue(bool value) {
    _checkBoxSubject.sink.add(value);
  }

  Stream<bool> get isFormValid$ =>
      Rx.combineLatest([email$, password$], (values) => true);

  @override
  dispose() {
    _emailSubject.close();
    _passwordSubject.close();
    _checkBoxSubject.close();
  }
}
