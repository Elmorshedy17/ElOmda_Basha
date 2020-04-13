import 'package:dio/dio.dart';
import 'package:momentoo/features/trending_stores/trendingStore_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class TrendingStoreRepo {
  static Future<TrendingStoreModel> getTrendingStoreData(int categoryId) async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}tranding_sellers/$categoryId',
          );
      return TrendingStoreModel.fromJson(response.data);
    } on DioError {
      // throw FetchDataException('No Internet connection');
      throw FetchDataException(DioError().error);
    }
  }
}
