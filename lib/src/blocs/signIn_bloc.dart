import 'dart:async';
//import 'package:heed/locator.dart';
//import 'package:heed/src/services/prefs_Service.dart';
import 'package:flutter/material.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:rxdart/rxdart.dart';

const String _kEmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";

class SignInBloc {

  final validateEmail =
  StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
//    final RegExp emailExp = new RegExp(_kEmailRule);
    if (email.length < 4) {
      sink.addError(locator<PrefsService>().appLanguage == "en"?'Entre a valid email':"ادخل بريد اليكتروني صالح");
    } else {
      sink.add(email);
    }
  });

  final validatePasswordIn = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 3) {
      sink.add(password);
    } else {
      sink.addError(Locale('en') != null?"password must be at least 3 characters":"كلمة السر يجيب الاتقل عن 3 عناصر");
    }
  });

  final BehaviorSubject<String> _mobileOrEmail = BehaviorSubject<String>();
  final BehaviorSubject<String> _password = BehaviorSubject<String>();

  Function(String) get changeMobileOrEmail => _mobileOrEmail.sink.add;

  Function(String) get changePassword => _password.sink.add;

  Stream<String> get mobileOrEmail =>
      _mobileOrEmail.stream.transform(validateEmail).asBroadcastStream();

  Stream<String> get password => _password.stream.transform(validatePasswordIn).asBroadcastStream();

  Stream<bool> get registerValid =>
      Rx.combineLatest2(password, mobileOrEmail, (p, m) => true).asBroadcastStream();

  dispose() {
    _password.close();
    _mobileOrEmail.close();
  }
}
