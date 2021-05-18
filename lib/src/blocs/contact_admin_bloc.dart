import 'dart:async';
//import 'package:heed/locator.dart';
//import 'package:heed/src/services/prefs_Service.dart';
import 'package:flutter/material.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:rxdart/rxdart.dart';

const String _kEmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";

class ContactAdminBloc {

  final validateEmail =
  StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
//final RegExp emailExp = new RegExp(_kEmailRule);
    if (email.length < 4) {
      sink.addError(locator<PrefsService>().appLanguage == "en"?'Entre a valid email':"ادخل بريد اليكتروني صالح");
    } else {
      sink.add(email);
    }
  });


  final validateTextArea = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        if (password.length > 3) {
          sink.add(password);
        } else {
          sink.addError(locator<PrefsService>().appLanguage == "en"?"password must be at least 3 characters":"كلمة السر يجيب الا تقل عن 3 عناصر");
        }
      });

  final BehaviorSubject<String> _email = BehaviorSubject<String>();

  final BehaviorSubject<String> _textArea = BehaviorSubject<String>();

  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changeTextArea => _textArea.sink.add;

  Stream<String> get email =>
      _email.stream.transform(validateEmail);

  Stream<String> get textArea =>
      _textArea.stream.transform(validateTextArea);


  Stream<bool> get registerValid =>
      Rx.combineLatest2(textArea, email, (t, m) => true);

  get currentState => _email.value;
  get currentTextArea => _textArea.value;


  dispose() {
    _email.close();
    _textArea.close();
  }
}
