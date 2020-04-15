import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:momentoo/features/sign_up/signUpValidation_manager.dart';
import 'package:momentoo/shared/helper/locator.dart';

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
      sink.addError('The field cannot be empty');
    } else if (length < 3) {
      sink.addError('The field must be longer than 3 characters');
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
      sink.addError('Please enter the same password');
    } else {
      sink.add(value);
    }
  });
}
