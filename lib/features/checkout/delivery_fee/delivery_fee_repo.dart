import 'package:dio/dio.dart';
import 'package:momentoo/features/checkout/delivery_fee/delivery_fee_model.dart';
import 'package:momentoo/features/checkout/delivery_fee/delivery_fee_request.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class DeliveryFeeRepo {
  static Future<DeliveryFeeModel> apiPost(
      DeliveryFeeRequest deliveryFeeRequest) async {
    FormData formData = FormData.fromMap(deliveryFeeRequest.toJson());

    try {
      final Response response = await locator<ApiService>().dioClient.post(
            '${locator<ApiService>().dioClient.options.baseUrl}delivery_fee',
            data: formData,
          );
      return DeliveryFeeModel.fromJson(response.data);
    } on DioError {
      throw FetchDataException('No Internet connection');
    }
  }
}
