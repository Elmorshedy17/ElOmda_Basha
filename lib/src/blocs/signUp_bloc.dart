import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
//import 'package:heed/locator.dart';
//import 'package:heed/src/services/prefs_Service.dart';
import 'package:rxdart/rxdart.dart';

var passKey = GlobalKey<FormFieldState>();
const String _kEmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";

class SignUpBloc {
//
//  var passKey = GlobalKey<FormFieldState>();

  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 3) {
      sink.add(name);
    } else {
      sink.addError(locator<PrefsService>().appLanguage == "en"?"enter a valid user name":"ادخل اسم مستخدم صالح");
    }
  });

  final validateSecondName =
      StreamTransformer<String, String>.fromHandlers(handleData: (secondName, sink) {
    if (secondName.length > 3) {
      sink.add(secondName);
    } else {
      sink.addError(locator<PrefsService>().appLanguage == "en"?"enter a valid user name":"ادخل اسم مستخدم صالح");
    }
  });

  final validateConfirmPassword =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (confirmPassword, sink) {
    if (confirmPassword.length > 0) {
      sink.add(confirmPassword);
    } else {
      sink.addError(locator<PrefsService>().appLanguage == "en"?"please enter your password again":"ادخل كلمة السر مجددا");
    }
  });

  final validateMobile = StreamTransformer<String, String>.fromHandlers(
      handleData: (mobile, sink) {
    if (mobile.length > 3) {
      sink.add(mobile);
    } else {
      sink.addError(locator<PrefsService>().appLanguage == "en"?"enter a valid Mobile Number":"ادخل رقم هاتف صالح");
    }
  });

  final validateWhatsapp = StreamTransformer<String, String>.fromHandlers(
      handleData: (Whatsapp, sink) {
    if (Whatsapp.length > 3) {
      sink.add(Whatsapp);
    } else {
      sink.addError(locator<PrefsService>().appLanguage == "en"?"enter a valid Mobile Number":"ادخل رقم هاتف صالح");
    }
  });

  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
//    final RegExp emailExp = new RegExp(_kEmailRule);
    if (email.length < 4) {
      sink.addError(locator<PrefsService>().appLanguage == "en"?'Entre a valid email':"ادخل بريد اليكتروني صالح");
    } else {
      sink.add(email);
    }
  });



  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 3) {
      sink.add(password);
    } else {
      sink.addError(locator<PrefsService>().appLanguage == "en"?"password must be at least 3 characters":"كلمة السر يجيب الا تقل عن 3 عناصر");
    }
  });



  final validateSupervisor = StreamTransformer<String, String>.fromHandlers(
      handleData: (Supervisor, sink) {
    if (Supervisor.length > 0) {
      sink.add(Supervisor);
    } else {
      sink.addError(locator<PrefsService>().appLanguage == "en"?"code can't be empty":"الكود لا يمكن ان يكون اقل من رقم ");
    }
  });
//  bool checkBoxState = false;
// streams of checkBox
  final BehaviorSubject<bool> streamCheckBoxController =BehaviorSubject<bool>.seeded(false);
// sink
//  Sink get checkBoxSink => streamCheckBoxController.sink;
// stream
  Stream<bool> get checkBoxStream => streamCheckBoxController.stream.asBroadcastStream();

  bool get _currentState => streamCheckBoxController.value;

// function to change the color
  changeCheckBoxController() {
    streamCheckBoxController.add(!_currentState);
  }
  //Bloc(){colorSink.add(Colors.red);}
//
//// streams of Color
//  final BehaviorSubject<String> termsCheckController = BehaviorSubject<String>();
//// sink
//  Sink get termsCheckSink => termsCheckController.sink;
//// stream
//  Stream<Color> get termsCheckStream => termsCheckController.Observable;
//
//// function to change the color
//  changeColor() {
//    colorSink.add(Colors.red);
//  }
////  Bloc(){colorSink.add(Colors.red);}



  final BehaviorSubject<String> _name = BehaviorSubject<String>();
  final BehaviorSubject<String> _secondName = BehaviorSubject<String>();
  final BehaviorSubject<String> _confirmPassword = BehaviorSubject<String>();
  final BehaviorSubject<String> _mobile = BehaviorSubject<String>();
  final BehaviorSubject<String> _whatsapp = BehaviorSubject<String>();
  final BehaviorSubject<String> _password = BehaviorSubject<String>();
  final BehaviorSubject<String> _superVisor = BehaviorSubject<String>();
  final BehaviorSubject<String> _email = BehaviorSubject<String>();

  String get currentName => _name.value;
  String get currentSecondName => _secondName.value;
  String get currentPassword => _password.value;
  String get currentMobile => _mobile.value;
  String get currenEmail => _email.value;
  String get currentWhatsapp => _whatsapp.value;
//  String get currentName => _name.value;



  ////code for phone //////
  final BehaviorSubject<String> _phoneCodeSubject =
  BehaviorSubject<String>();
  Stream<String> get phoneCodeSubjectStream$ => _phoneCodeSubject.stream.asBroadcastStream();
  Sink<String> get phoneCodeSubjectSink => _phoneCodeSubject.sink;
  String get currentPhoneCode => _phoneCodeSubject.value;


//// code for whatsapp///
  final BehaviorSubject<String> _whatsappCodeSubject =
  BehaviorSubject<String>();
  Stream<String> get whastappCodeSubjectStream$ => _whatsappCodeSubject.stream.asBroadcastStream();
  Sink<String> get whastappCodeSubjectSink => _whatsappCodeSubject.sink;
  String get currentWhatsappCode => _whatsappCodeSubject.value;

//
//  final _mobile = StreamController<String>.broadcast();
//  final _confirmPassword = StreamController<String>.broadcast();
//  final _password = StreamController<String>.broadcast();
//  final _email = StreamController<String>.broadcast();

  Function(String) get changeName => _name.sink.add;

  Function(String) get changeSecondName => _secondName.sink.add;

  Function(String) get changeMobile => _mobile.sink.add;

  Function(String) get changeWhatsapp => _whatsapp.sink.add;

  Function(String) get changePasswordConfirmation => _confirmPassword.sink.add;

//
  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changePassword => _password.sink.add;

  Function(String) get changeSuperVisor => _superVisor.sink.add;




  final BehaviorSubject<String> _radioButtomSubject =
  BehaviorSubject<String>.seeded("commission");

//  Stream<String> get UserTypeApiStream$ => _radioButtomSubject.stream;

  Sink<String> get radioButtomSink => _radioButtomSubject.sink;

  String get currentradioButtom => _radioButtomSubject.value;
  
  ////streams

  Stream<String> get name => _name.stream.transform(validateName).asBroadcastStream();

  Stream<String> get secondname => _secondName.stream.transform(validateSecondName).asBroadcastStream();

  Stream<String> get mobile => _mobile.stream.transform(validateMobile).asBroadcastStream();

  Stream<String> get whatsapp => _whatsapp.stream.transform(validateWhatsapp).asBroadcastStream();

  Stream<String> get confirmPassword =>
      _confirmPassword.stream.transform(validatePassword).doOnData((String c) {
        // If the password is accepted (after validation of the rules)
        // we need to ensure both password and retyped password match
        if (0 != _password.value.compareTo(c)) {
          // If they do not match, add an error
          _confirmPassword.addError(locator<PrefsService>().appLanguage == "en"?"No Match":"غير متطابق مع كلمة السر");
        }
      }).asBroadcastStream();

  Stream<String> get email => _email.stream.transform(validateEmail);

  Stream<String> get password => _password.stream.transform(validatePassword);

  Stream<String> get supervisor => _superVisor.stream.transform(validateSupervisor);
  String get currentSupervisorCode => _superVisor.value;

  //
  // Registration button
  Stream<bool> get registerValid => Rx.combineLatest6(
      email, password, confirmPassword, name, mobile,secondname, (e, p, c, n, m,w) => true);




//  final BehaviorSubject<String> _supervisorCode =
//  BehaviorSubject<String>.seeded("");
//
////  Stream<String> get UserTypeApiStream$ => _UserTypeSubject.stream;
//
//  Sink<String> get supervisorCodeSink => _supervisorCode.sink;
//
//  String get currentSupervisorCode => _supervisorCode.value;


  dispose() {
//    _supervisorCode.close();
    _email.close();
    _password.close();
    _confirmPassword.close();
    _name.close();
    _mobile.close();
    streamCheckBoxController.close();
  _superVisor.close();
  _whatsapp.close();
  _secondName.close();
    _phoneCodeSubject.close();
    _whatsappCodeSubject.close();
  }
}