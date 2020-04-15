import 'dart:async';

import 'package:momentoo/shared/helper/manager.dart';
import 'package:momentoo/shared/validation/validation.dart';
import 'package:rxdart/rxdart.dart';

class SignInValidationManager with Validation implements Manager {
  final emailSubject = BehaviorSubject<String>();
  Stream<String> get email$ => emailSubject.stream.transform(validateEmail);
  Sink<String> get inEmail => emailSubject.sink;

  final passwordSubject = BehaviorSubject<String>();
  Stream<String> get password$ =>
      passwordSubject.stream.transform(validateField);
  Sink<String> get inPassword => passwordSubject.sink;

  final _checkBoxSubject = BehaviorSubject<bool>.seeded(true);
  Stream<bool> get checkBoxValue$ => _checkBoxSubject.stream;
  void setCheckBoxValue(bool value) {
    _checkBoxSubject.sink.add(value);
  }

  Stream<bool> get isFormValid$ =>
      Rx.combineLatest([email$, password$], (values) => true);

  @override
  dispose() {
    emailSubject.close();
    passwordSubject.close();
    _checkBoxSubject.close();
  }

  @override
  getData([Map<String, dynamic> map]) {
    return null;
  }
}
