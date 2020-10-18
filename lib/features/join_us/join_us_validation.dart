import 'dart:async';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:momentoo/shared/validation/validation.dart';
import 'package:rxdart/rxdart.dart';

class JoinUsValidationManager with Validation implements Manager {
  final emailSubject = BehaviorSubject<String>();
  Stream<String> get email$ => emailSubject.stream.transform(validateEmail);
  Sink<String> get inEmail => emailSubject.sink;

  final companyLogo = BehaviorSubject<String>();


  final companyName = BehaviorSubject<String>();
  Stream<String> get companyName$ =>
      companyName.stream.transform(validateField);
  Sink<String> get inCompanyName => companyName.sink;

  final addressSubject = BehaviorSubject<String>();
  Stream<String> get address$ => addressSubject.stream.transform(validateField);
  Sink<String> get inAddress => addressSubject.sink;



  final phoneSubject = BehaviorSubject<String>();
  Stream<String> get phone$ =>
      phoneSubject.stream.transform(validatePhoneField);
  Sink<String> get inPhone => phoneSubject.sink;

  final numberDeliversSubject = BehaviorSubject<String>();
  Stream<String> get numberDelivers$ => numberDeliversSubject.stream.transform(justValidatePhoneField);
  Sink<String> get inNumberDelivers => numberDeliversSubject.sink;



  Stream<bool> get isFormValid$ => Rx.combineLatest([
    companyName$,
    address$,
    phone$,
    email$,
    numberDeliversSubject,
  ], (values) => true);

  @override
  dispose() {
    emailSubject.close();
    addressSubject.close();
    companyName.close();
    phoneSubject.close();
    numberDeliversSubject.close();
    companyLogo.close();
  }
}
