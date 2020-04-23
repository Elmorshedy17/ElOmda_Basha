import 'package:dio/dio.dart';
import 'package:momentoo/features/ads/ads_model.dart';
import 'package:momentoo/features/invoice/_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class OrderDetailsRepo {
  static Future<InvoiceModel> getOrderDetailsData(Id) async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
        '${locator<ApiService>().dioClient.options.baseUrl}order/$Id',
      );
      return InvoiceModel.fromJson(response.data);
    } on DioError {
      // throw FetchDataException('No Internet connection');
      throw FetchDataException(DioError().error);
    }
  }
}
