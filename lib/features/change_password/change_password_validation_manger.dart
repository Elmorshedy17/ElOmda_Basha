import 'dart:async';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:momentoo/shared/validation/validation.dart';
import 'package:rxdart/rxdart.dart';

class ChangePasswordValidationManager with Validation implements Manager {

  final oldPasswordSubject = BehaviorSubject<String>();
  Stream<String> get oldPassword$ => oldPasswordSubject.stream.transform(validateField);
  Sink<String> get inOldPassword => oldPasswordSubject.sink;

  final passwordSubject = BehaviorSubject<String>();
  Stream<String> get password$ => passwordSubject.stream.transform(validateField);
  Sink<String> get inPassword => passwordSubject.sink;

  final newPasswordSubject = BehaviorSubject<String>();
  Stream<String> get newPassword$ => newPasswordSubject.stream.transform(validateField);
  Sink<String> get inNewPassword => newPasswordSubject.sink;

  Stream<bool> get isFormValid$ =>
      Rx.combineLatest([oldPassword$, password$,newPassword$], (values) => true);

  @override
  dispose() {
    passwordSubject.close();
    oldPasswordSubject.close();
    newPasswordSubject.close();
  }

}
