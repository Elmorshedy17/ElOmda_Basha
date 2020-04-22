import 'package:dio/dio.dart';
import 'package:momentoo/features/checkout/checkout_request/asUser_request.dart';
import 'package:momentoo/features/checkout/checkout_request/asVisitor_request.dart';
import 'package:momentoo/features/checkout/checkout_response.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class CheckoutRepo {
  static Future<CheckoutResponse> checkoutAsUser() async {
    FormData formData = FormData.fromMap(locator<AsUserRequest>().toJson());
    print(formData.fields);
    try {
      final Response response = await locator<ApiService>().dioClient.post(
            '${locator<ApiService>().dioClient.options.baseUrl}checkout',
            data: formData,
          );
      print('++++++++++++++++++++++++++++++++++${response.data}');
      return CheckoutResponse.fromJson(response.data);
    } on DioError {
      // throw FetchDataException('No Internet connection');
      throw FetchDataException(DioError().error);
    }
  }

  static Future<CheckoutResponse> checkoutAsVisitor() async {
    FormData formData = FormData.fromMap(locator<AsVisitorRequest>().toJson());
    print(formData.fields);
    try {
      final Response response = await locator<ApiService>().dioClient.post(
            '${locator<ApiService>().dioClient.options.baseUrl}checkout',
            data: formData,
          );
      print('++++++++++++++++++++++++++++++++++${response.data}');
      return CheckoutResponse.fromJson(response.data);
    } on DioError {
      // throw FetchDataException('No Internet connection');
      throw FetchDataException(DioError().error);
    }
  }
}
