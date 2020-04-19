import 'package:dio/dio.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

import 'favorites_model.dart';

class FavoritesRepo {
  static Future<FavoritesModel> getFavoritesData() async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}favourites',
          );
      return FavoritesModel.fromJson(response.data);
    } on DioError {
      // throw FetchDataException('No Internet connection');
      throw FetchDataException(DioError().error);
    }
  }
}
