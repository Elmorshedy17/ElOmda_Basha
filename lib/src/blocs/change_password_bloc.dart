import 'dart:async';
//import 'package:heed/locator.dart';
//import 'package:heed/src/services/prefs_Service.dart';
import 'package:flutter/material.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:rxdart/rxdart.dart';


class ChangePasswordBloc {



  final validatePasswordIn = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        if (password.length >= 3) {
          sink.add(password);
        } else {
          sink.addError(Locale('en') != null?"password must be at least 3 characters":"كلمة السر يجيب الاتقل عن 3 عناصر");
        }
      });

  final validateNewPasswordIn = StreamTransformer<String, String>.fromHandlers(
      handleData: (newPassword, sink) {
        if (newPassword.length >= 3) {
          sink.add(newPassword);
        } else {
          sink.addError(Locale('en') != null?"password must be at least 3 characters":"كلمة السر يجيب الاتقل عن 3 عناصر");
        }
      });

  final BehaviorSubject<String> _password = BehaviorSubject<String>();

  final BehaviorSubject<String> _newPassword = BehaviorSubject<String>();

   get currentOldPassword => _password.value;
   get currentNewPassword => _newPassword.value;


  Function(String) get changePassword => _password.sink.add;

  Function(String) get changeNewPassword => _newPassword.sink.add;


  Stream<String> get password => _password.stream.transform(validatePasswordIn);

  Stream<String> get newPassword => _newPassword.stream.transform(validateNewPasswordIn);

  Stream<bool> get registerValid =>
      Rx.combineLatest2(password, newPassword, (p, m) => true);

  dispose() {
    _password.close();
    _newPassword.close();
  }
}
