import 'package:dio/dio.dart';
import 'package:momentoo/features/about_us/about_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class PaymentResponse {
  static Future<AboutModel> paymentResponse(String url) async {
    try {
      final Response response =
          await locator<ApiService>().dioClient.get('$url');
      print('xXx: $response');
      return AboutModel.fromJson(response.data);
    } on DioError {
      print('xXx: DioError');
      throw FetchDataException(DioError().error);
    }
  }
}
