import 'package:dio/dio.dart';
import 'package:momentoo/features/change_password/_model.dart';
import 'package:momentoo/features/sign_up/_model.dart';
import 'package:momentoo/features/sign_up/signUpValidation_manager.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class ChangePasswordRepo {
  static Future<ChangePasswordModel> postChangePasswordData(oldPassword,newPassword,confirmNewPassword) async {

    FormData formData =
    FormData.fromMap({
      "old_password": oldPassword,
      "new_password": "$newPassword",
      "new_password_confirmation": "$confirmNewPassword",

    });





    try {
      final Response response = await locator<ApiService>().dioClient.post(
        '${locator<ApiService>().dioClient.options.baseUrl}change_password',
      data:formData,

      );
      return ChangePasswordModel.fromJson(response.data);
    } on DioError {
      throw FetchDataException('No Internet connection');
    }

  }
}