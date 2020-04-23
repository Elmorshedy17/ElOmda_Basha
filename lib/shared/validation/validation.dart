import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:momentoo/features/sign_up/signUpValidation_manager.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

mixin Validation {
  static bool isEmail(String email) => EmailValidator.validate(email);

  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (isEmail(value)) {
      sink.add(value);
    } else {
      sink.addError('Incorrect Email');
    }
  });

  final validateField =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    int length = value.length;
    if (length == 0) {
      locator<PrefsService>().appLanguage == "en" ? sink.addError('* required') : sink.addError('* مطلوب');
    } else if (length < 3) {
      locator<PrefsService>().appLanguage == "en" ? sink.addError('The field must be longer than 3 characters') : sink.addError('لا يمكن ان تقل عدد الاحرف عن 3 احرف');
    } else {
      sink.add(value);
    }
  });

  final validateFieldIsRequired =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    int length = value.length;
    if (length == 0) {
      locator<PrefsService>().appLanguage == "en" ? sink.addError('* required') : sink.addError('* مطلوب');
      // } else if (length < 3) {
      //   sink.addError('The field must be longer than 3 characters');
    } else {
      sink.add(value);
    }
  });

  final validatePhoneField =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    int length = value.length;
    if (length == 0) {
      locator<PrefsService>().appLanguage == "en" ? sink.addError('* required') : sink.addError('* مطلوب');
    } else if (length < 8) {
      locator<PrefsService>().appLanguage == "en" ? sink.addError('The field must be longer than 8 characters') : sink.addError('لا يمكن ان تقل عدد الاحرف عن 8 احرف');
    } else {
      sink.add(value);
    }
  });

  final validateConfirmPassword =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    String confirm;
    locator<SignUpValidationManager>().password$.listen((password) {
      confirm = password.toString();
    });
    if (value.toString().toLowerCase() == confirm.toLowerCase()) {
      locator<PrefsService>().appLanguage == "en" ? sink.addError('Please enter the same password') : sink.addError('برجاء ادخال نفس كلمة المرور');
    } else {
      sink.add(value);
    }
  });
}
