import 'dart:async';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:momentoo/shared/validation/validation.dart';
import 'package:rxdart/rxdart.dart';

class HelpSupportValidationManager with Validation implements Manager {
  final emailSubject = BehaviorSubject<String>();
  Stream<String> get email$ => emailSubject.stream.transform(validateEmail);
  Sink<String> get inEmail => emailSubject.sink;



  final firstNameSubject = BehaviorSubject<String>();
  Stream<String> get firstName$ =>
      firstNameSubject.stream.transform(validateField);
  Sink<String> get inFirstName => firstNameSubject.sink;

  final msgSubject = BehaviorSubject<String>();
  Stream<String> get msg$ => msgSubject.stream.transform(validateField);
  Sink<String> get inMsg => msgSubject.sink;




  final phoneSubject = BehaviorSubject<String>();
  Stream<String> get phone$ =>
      phoneSubject.stream.transform(validatePhoneField);
  Sink<String> get inPhone => phoneSubject.sink;



  Stream<bool> get isFormValid$ => Rx.combineLatest([
    email$,
    firstName$,
    phone$,
    msg$
  ], (values) => true);

  @override
  dispose() {
    emailSubject.close();
    msgSubject.close();
    firstNameSubject.close();
    phoneSubject.close();
  }
}
