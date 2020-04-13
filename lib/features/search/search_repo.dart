import 'package:dio/dio.dart';
import 'package:momentoo/features/search/search_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class SearchRepo {
  static Future<SearchModel> getData(int categoryId, String query,
      [String cuisineId = '', String cityId = '']) async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}search/$categoryId?word=$query&cuisine_id=$cuisineId&city_id=$cityId',
          );
      return SearchModel.fromJson(response.data);
    } on DioError {
      // throw FetchDataException('No Internet connection');
      throw FetchDataException(DioError().error);
    }
  }
}
