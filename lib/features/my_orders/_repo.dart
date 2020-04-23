import 'package:dio/dio.dart';
import 'package:momentoo/features/ads/ads_model.dart';
import 'package:momentoo/features/my_orders/_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class MyOrdersRepo {
  static Future<MyOrdersModel> getMyOrdersData() async {

    try {
      final Response response = await locator<ApiService>().dioClient.get(
        '${locator<ApiService>().dioClient.options.baseUrl}orders',
      );
      print(response.data.toString());
      return MyOrdersModel.fromJson(response.data);
    } on DioError {
      // throw FetchDataException('No Internet connection');
      throw FetchDataException(DioError().error);
    }
  }
}
