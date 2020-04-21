import 'package:dio/dio.dart';
import 'package:momentoo/features/checkout/coupon/coupon_request.dart';
import 'package:momentoo/features/checkout/coupon/coupon_response.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class CouponRepo {
  static Future<CouponResponse> postCouponData() async {
    FormData formData = FormData.fromMap(locator<CouponRequest>().toJson());

    try {
      final Response response = await locator<ApiService>().dioClient.post(
            '${locator<ApiService>().dioClient.options.baseUrl}check_copoun',
            data: formData,
          );
      return CouponResponse.fromJson(response.data);
    } on DioError {
      // throw FetchDataException('No Internet connection');
      throw FetchDataException(DioError().error);
    }
  }
}
