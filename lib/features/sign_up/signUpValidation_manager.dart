import 'dart:async';

import 'package:momentoo/shared/helper/manager.dart';
import 'package:momentoo/shared/validation/validation.dart';
import 'package:rxdart/rxdart.dart';

class SignUpValidationManager with Validation implements Manager {
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

  final _firstNameSubject = BehaviorSubject<String>();
  Stream<String> get firstName$ =>
      _firstNameSubject.stream.transform(validateField);
  Sink<String> get inFirstName => _firstNameSubject.sink;

  final _middleNameSubject = BehaviorSubject<String>.seeded('');
  Stream<String> get middleName$ => _middleNameSubject.stream;
  Sink<String> get inMiddleName => _middleNameSubject.sink;

  final _lastNameSubject = BehaviorSubject<String>();
  Stream<String> get lastName$ =>
      _lastNameSubject.stream.transform(validateField);
  Sink<String> get inLastName => _lastNameSubject.sink;

  final _addressSubject = BehaviorSubject<String>();
  Stream<String> get address$ =>
      _addressSubject.stream.transform(validateField);
  Sink<String> get inAddress => _addressSubject.sink;

  final _phoneSubject = BehaviorSubject<String>();
  Stream<String> get phone$ => _phoneSubject.stream.transform(validateField);
  Sink<String> get inPhone => _phoneSubject.sink;

  final _passwordConfirmationSubject = BehaviorSubject<String>();
  Stream<String> get passwordConfirmation$ =>
      _passwordConfirmationSubject.stream.transform(validateField);
  Sink<String> get inPasswordConfirmation => _passwordConfirmationSubject.sink;

  Stream<bool> get isFormValid$ => Rx.combineLatest([
        email$,
        password$,
        firstName$,
        lastName$,
        address$,
        phone$,
        passwordConfirmation$,
      ], (values) => true);

  @override
  dispose() {
    _emailSubject.close();
    _passwordSubject.close();
    _checkBoxSubject.close();
    _firstNameSubject.close();
    _middleNameSubject.close();
    _lastNameSubject.close();
    _addressSubject.close();
    _phoneSubject.close();
    _passwordConfirmationSubject.close();
  }
}
