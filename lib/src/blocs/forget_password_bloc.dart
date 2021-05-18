import 'dart:async';
//import 'package:heed/locator.dart';
//import 'package:heed/src/services/prefs_Service.dart';
import 'package:flutter/material.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:rxdart/rxdart.dart';

const String _kEmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";

class ForgetPasswordBloc {

  final validateEmail =
  StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
//    final RegExp emailExp = new RegExp(_kEmailRule);
    if (email.length < 4) {
      sink.addError(locator<PrefsService>().appLanguage == "en"?'Entre a valid email':"ادخل بريد اليكتروني صالح");
    } else {
      sink.add(email);
    }
  });

  final BehaviorSubject<String> _email = BehaviorSubject<String>();

  Function(String) get changeEmail => _email.sink.add;

  Stream<String> get email =>
      _email.stream.transform(validateEmail);
//
//  Stream<bool> get registerValid =>
//      Observable.combineLatest(password, email, (p, m) => true);

   get currentState => _email.value;


  dispose() {
    _email.close();
  }
}
