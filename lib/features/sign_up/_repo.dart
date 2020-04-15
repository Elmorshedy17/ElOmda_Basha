import 'package:dio/dio.dart';
import 'package:momentoo/features/sign_up/_model.dart';
import 'package:momentoo/features/sign_up/signUpValidation_manager.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class RegisterRepo {
  static Future<RegisterModel> postRegisterData(email,phone,password,confirm,first,mid,last,adress) async {



    //

    FormData formData =
    FormData.fromMap({
      "email": email,
      "phone": "$phone",
      "password": "$password",
      "password_confirmation": "$confirm",
      "first_name": "$first",
      "middle_name": "$mid",
      "last_name": "$last",
      "address": "$adress",
    });





    try {
      final Response response = await locator<ApiService>().dioClient.post(
        '${locator<ApiService>().dioClient.options.baseUrl}register',
      data:formData,
//        {
//          "email": "${locator<SignUpValidationManager>().emailSubject.value}",
//          "phone": "${locator<SignUpValidationManager>().phoneSubject.value}",
//          "password": "${locator<SignUpValidationManager>().passwordSubject.value}",
//          "password_confirmation": "${locator<SignUpValidationManager>().emailSubject.value}",
//          "first_name": "${locator<SignUpValidationManager>().firstNameSubject.value}",
//          "middle_name": "${locator<SignUpValidationManager>().middleNameSubject.value}",
//          "last_name": "${locator<SignUpValidationManager>().lastNameSubject.value}",
//          "address": "${locator<SignUpValidationManager>().addressSubject.value}",
//          "email": email,
//          "phone": "$phone",
//          "password": "$password",
//          "password_confirmation": "$confirm",
//          "first_name": "$first",
//          "middle_name": "$mid",
//          "last_name": "$last",
//          "address": "$adress",
//        },
      );
      return RegisterModel.fromJson(response.data);
    } on DioError {
      throw FetchDataException('No Internet connection');
    }

  }
}