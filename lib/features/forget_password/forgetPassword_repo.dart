import 'package:dio/dio.dart';
import 'package:momentoo/features/forget_password/forgetPassword_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class ForgetPasswordRepo {
  static Future<ForgetPasswordModel> postForgetPasswordData(email) async {
    FormData formData = FormData.fromMap({
      "email": email,
    });

    try {
      final Response response = await locator<ApiService>().dioClient.post(
            '${locator<ApiService>().dioClient.options.baseUrl}forget_password',
            data: formData,
          );
      return ForgetPasswordModel.fromJson(response.data);
    } on DioError {
      throw FetchDataException('No Internet connection');
    }
  }
}
