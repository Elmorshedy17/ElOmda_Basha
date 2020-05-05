import 'dart:async';

import 'package:momentoo/shared/helper/manager.dart';
import 'package:momentoo/shared/validation/validation.dart';
import 'package:rxdart/rxdart.dart';

class SignUpValidationManager with Validation implements Manager {
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

  final firstNameSubject = BehaviorSubject<String>();
  Stream<String> get firstName$ =>
      firstNameSubject.stream.transform(validateField);
  Sink<String> get inFirstName => firstNameSubject.sink;

  final middleNameSubject = BehaviorSubject<String>.seeded('');
  Stream<String> get middleName$ => middleNameSubject.stream;
  Sink<String> get inMiddleName => middleNameSubject.sink;

  final lastNameSubject = BehaviorSubject<String>();
  Stream<String> get lastName$ =>
      lastNameSubject.stream.transform(validateField);
  Sink<String> get inLastName => lastNameSubject.sink;

  final addressSubject = BehaviorSubject<String>();
  Stream<String> get address$ => addressSubject.stream.transform(validateField);
  Sink<String> get inAddress => addressSubject.sink;

  final phoneSubject = BehaviorSubject<String>();
  Stream<String> get phone$ =>
      phoneSubject.stream.transform(validatePhoneField);
  Sink<String> get inPhone => phoneSubject.sink;

  final passwordConfirmationSubject = BehaviorSubject<String>();
  Stream<String> get passwordConfirmation$ =>
      passwordConfirmationSubject.stream.transform(validateField);
  Sink<String> get inPasswordConfirmation => passwordConfirmationSubject.sink;

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
    emailSubject.close();
    passwordSubject.close();
    _checkBoxSubject.close();
    firstNameSubject.close();
    middleNameSubject.close();
    lastNameSubject.close();
    addressSubject.close();
    phoneSubject.close();
    passwordConfirmationSubject.close();
  }
}
