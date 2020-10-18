import 'dart:async';

import 'package:momentoo/shared/helper/manager.dart';
import 'package:momentoo/shared/validation/validation.dart';
import 'package:rxdart/rxdart.dart';

class EditProfileValidationManager with Validation implements Manager {


  final firstNameSubject = BehaviorSubject<String>();
  Stream<String> get firstName$ =>
      firstNameSubject.stream.transform(validateField);
  Sink<String> get inFirstName => firstNameSubject.sink;



  final lastNameSubject = BehaviorSubject<String>();
  Stream<String> get lastName$ =>
      lastNameSubject.stream.transform(validateField);
  Sink<String> get inLastName => lastNameSubject.sink;



  final phoneSubject = BehaviorSubject<String>();
  Stream<String> get phone$ =>
      phoneSubject.stream.transform(validatePhoneField);
  Sink<String> get inPhone => phoneSubject.sink;



  Stream<bool> get isFormValid$ => Rx.combineLatest([
    firstName$,
    lastName$,
    phone$,
  ], (values) => true);

  @override
  dispose() {
    firstNameSubject.close();
    lastNameSubject.close();
    phoneSubject.close();
  }
}
