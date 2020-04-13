import 'package:dio/dio.dart';
import 'package:momentoo/features/trending_products/trendingProduct_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class TrendingProductsRepo {
  static Future<TrendingProductsModel> getTrendingProductData(
      int categoryId) async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}tranding_products/$categoryId',
          );
      return TrendingProductsModel.fromJson(response.data);
    } on DioError {
      // throw FetchDataException('No Internet connection');
      throw FetchDataException(DioError().error);
    }
  }
}
