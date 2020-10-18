import 'dart:async';

import 'package:momentoo/shared/helper/manager.dart';
import 'package:momentoo/shared/validation/validation.dart';
import 'package:rxdart/rxdart.dart';

class ChangeEmailValidationManager with Validation implements Manager {


  final oldEmailSubject = BehaviorSubject<String>();
  Stream<String> get oldEmail$ => oldEmailSubject.stream.transform(validateEmail);
  Sink<String> get inOldEmail => oldEmailSubject.sink;

  final emailSubject = BehaviorSubject<String>();
  Stream<String> get email$ => emailSubject.stream.transform(validateEmail);
  Sink<String> get inEmail => emailSubject.sink;


  final newEmailSubject = BehaviorSubject<String>();
  Stream<String> get newEmail$ => newEmailSubject.stream.transform(validateEmail);
  Sink<String> get inNewEmail => newEmailSubject.sink;





  Stream<bool> get isFormValid$ => Rx.combineLatest([
    oldEmailSubject,
    emailSubject,
    newEmail$,
  ], (values) => true);

  @override
  dispose() {
    oldEmailSubject.close();
    emailSubject.close();
    newEmailSubject.close();
  }
}
