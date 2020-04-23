import 'dart:async';

import 'package:momentoo/shared/helper/manager.dart';
import 'package:momentoo/shared/validation/validation.dart';
import 'package:rxdart/rxdart.dart';

class AddAddressValidationManager with Validation implements Manager {
  final emailSubject = BehaviorSubject<String>();
  Stream<String> get email$ => emailSubject.stream.transform(validateEmail);
  Sink<String> get inEmail => emailSubject.sink;

  final blockSubject = BehaviorSubject<String>();
  Stream<String> get block$ =>
      blockSubject.stream.transform(validateField);
  Sink<String> get inblock => blockSubject.sink;



  final streetTwoSubject = BehaviorSubject<String>();
  Stream<String> get streetTwo$ =>
      streetTwoSubject.stream.transform(validateField);
  Sink<String> get instreetTwo => streetTwoSubject.sink;


  final streetSubject = BehaviorSubject<String>();
  Stream<String> get street$ =>
      streetSubject.stream.transform(validateField);
  Sink<String> get instreet => streetSubject.sink;


  final houseSubject = BehaviorSubject<String>();
  Stream<String> get house$ =>
      houseSubject.stream.transform(validateField);
  Sink<String> get inhouse => houseSubject.sink;


  final floorSubject = BehaviorSubject<String>();
  Stream<String> get floor$ =>
      floorSubject.stream.transform(validateField);
  Sink<String> get infloor => floorSubject.sink;


  final jaddaSubject = BehaviorSubject<String>();
  Stream<String> get jadda$ =>
      jaddaSubject.stream.transform(validateField);
  Sink<String> get injadda => jaddaSubject.sink;

//
//  final appartmentSubject = BehaviorSubject<String>();
//  Stream<String> get appartment$ =>
//      appartmentSubject.stream.transform(validateField);
//  Sink<String> get inappartment => streetSubject.sink;
//



  Stream<bool> get isFormValid$ =>
      Rx.combineLatest([block$,floor$,house$,jadda$,street$,streetTwo$], (values) => true);

  @override
  dispose() {
    emailSubject.close();
    blockSubject.close();
//    _checkBoxSubject.close();
  }

  @override
  getData([Map<String, dynamic> map]) {
    return null;
  }
}
