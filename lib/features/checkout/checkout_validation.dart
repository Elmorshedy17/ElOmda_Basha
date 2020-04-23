import 'dart:async';

import 'package:momentoo/shared/helper/manager.dart';
import 'package:momentoo/shared/validation/validation.dart';
import 'package:rxdart/rxdart.dart';

class CheckoutValidationManager with Validation implements Manager {
  final emailSubject = BehaviorSubject<String>();
  Stream<String> get email$ => emailSubject.stream.transform(validateEmail);
  Sink<String> get inEmail => emailSubject.sink;

  final firstNameSubject = BehaviorSubject<String>();
  Stream<String> get firstName$ =>
      firstNameSubject.stream.transform(validateField);
  Sink<String> get inFirstName => firstNameSubject.sink;

  final lastNameSubject = BehaviorSubject<String>();
  Stream<String> get lastName$ =>
      lastNameSubject.stream.transform(validateField);
  Sink<String> get inLastName => lastNameSubject.sink;

  final addressSubject = BehaviorSubject<String>();
  Stream<String> get address$ => addressSubject.stream.transform(validateField);
  Sink<String> get inAddress => addressSubject.sink;

  final blockSubject = BehaviorSubject<String>();
  Stream<String> get block$ =>
      addressSubject.stream.transform(validateFieldIsRequired);
  Sink<String> get inBlock => addressSubject.sink;

  final streetSubject = BehaviorSubject<String>();
  Stream<String> get street$ =>
      addressSubject.stream.transform(validateFieldIsRequired);
  Sink<String> get inStreet => addressSubject.sink;

  final street2Subject = BehaviorSubject<String>();
  Stream<String> get street2$ =>
      addressSubject.stream.transform(validateFieldIsRequired);
  Sink<String> get inStreet2 => addressSubject.sink;
  final buildingSubject = BehaviorSubject<String>();
  Stream<String> get building$ =>
      addressSubject.stream.transform(validateFieldIsRequired);
  Sink<String> get iBuilding => addressSubject.sink;

  final floorSubject = BehaviorSubject<String>();
  Stream<String> get floor$ =>
      addressSubject.stream.transform(validateFieldIsRequired);
  Sink<String> get inFloor => addressSubject.sink;

  final jaddaSubject = BehaviorSubject<String>();
  Stream<String> get jadda$ =>
      addressSubject.stream.transform(validateFieldIsRequired);
  Sink<String> get inJadda => addressSubject.sink;

  final phoneSubject = BehaviorSubject<String>();
  Stream<String> get phone$ =>
      phoneSubject.stream.transform(validatePhoneField);
  Sink<String> get inPhone => phoneSubject.sink;

  Stream<bool> get isFormValid$ => Rx.combineLatest([
        email$,
        firstName$,
        lastName$,
        phone$,
        block$,
        street$,
        street2$,
        building$,
        floor$,
        jadda$
      ], (values) => true);

  @override
  dispose() {
    emailSubject.close();
    firstNameSubject.close();
    lastNameSubject.close();
    addressSubject.close();
    phoneSubject.close();
    blockSubject.close();
    streetSubject.close();
    street2Subject.close();
    buildingSubject.close();
    floorSubject.close();
    jaddaSubject.close();
  }
}
