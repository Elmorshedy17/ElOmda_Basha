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
      sink.addError(locator<PrefsService>().appLanguage == 'en'
          ? 'Incorrect Email'
          : 'بريد إلكتروني خاطئ');
    }
  });

  final validateField =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    int length = value.length;
    if (length == 0) {
      sink.addError(locator<PrefsService>().appLanguage == 'en'
          ? '* required'
          : 'هذا الحقل مطلوب');
    } else if (length < 3) {
      sink.addError(locator<PrefsService>().appLanguage == 'en'
          ? 'The field must be 3 characters at least'
          : 'أدخل 3 رموز على الأقل');
    }else{
      sink.add(value);

    }
      });

  final validateFieldIsRequired =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    int length = value.length;
    if (length == 0) {
      sink.addError(locator<PrefsService>().appLanguage == 'en'
          ? '* required'
          : 'هذا الحقل مطلوب');

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
      sink.addError('* required ');
    } else if (length != 8) {
      sink.addError(locator<PrefsService>().appLanguage == 'en'
          ? 'The field must be 8 digits'
          : 'رقم الهاتف يجب ان يكون 8 أرقام');
    } else {
      sink.add(value);
    }
  });

  final justValidatePhoneField =
  StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    int length = value.length;
    if (length == 0) {
      sink.addError('* required ');
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
      sink.addError(locator<PrefsService>().appLanguage == 'en'
          ? 'Please enter the same password'
          : 'تأكد من إدخال نفس كلمة السر');
    } else {
      sink.add(value);
    }
  });
}
