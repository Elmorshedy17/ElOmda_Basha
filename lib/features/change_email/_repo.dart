import 'package:dio/dio.dart';
import 'package:momentoo/features/change_email/_model.dart';
import 'package:momentoo/features/change_password/_model.dart';
import 'package:momentoo/features/sign_up/_model.dart';
import 'package:momentoo/features/sign_up/signUpValidation_manager.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class ChangeEmailRepo {
  static Future<ChangeEmailModel> postChangeEmailData(oldEmail,newEmail,confirmNewEmail) async {

    FormData formData =
    FormData.fromMap({
      "old_email": oldEmail,
      "new_email": "$newEmail",
      "new_email_confirmation": "$confirmNewEmail",

    });





    try {
      final Response response = await locator<ApiService>().dioClient.post(
        '${locator<ApiService>().dioClient.options.baseUrl}change_email',
      data:formData,

      );
      return ChangeEmailModel.fromJson(response.data);
    } on DioError {
      throw FetchDataException('No Internet connection');
    }

  }
}