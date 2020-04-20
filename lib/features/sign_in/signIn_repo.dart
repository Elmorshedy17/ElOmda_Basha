import 'package:dio/dio.dart';
import 'package:momentoo/features/sign_in/signIn_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class LoginRepo {
  static Future<LoginModel> postLoginData(email, password) async {
    FormData formData = FormData.fromMap({
      "email": email,
      "password": "$password",
    });

    try {
      final Response response = await locator<ApiService>().dioClient.post(
            '${locator<ApiService>().dioClient.options.baseUrl}login',
            data: formData,
          );
      return LoginModel.fromJson(response.data);
    } on DioError {
      throw FetchDataException('No Internet connection');
    }
  }
}
