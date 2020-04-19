import 'package:dio/dio.dart';
import 'package:momentoo/features/favorites/favoriteActions_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class FavoriteActionsRepo {
  static Future<FavoritesActionsModel> postFavoritesData(
      String type, String action, String id) async {
    FormData formData = FormData.fromMap({
      'type': type,
      'action': action,
      'id': id,
    });
    try {
      final Response response = await locator<ApiService>().dioClient.post(
            '${locator<ApiService>().dioClient.options.baseUrl}favourite_action',
            data: formData,
          );
      return FavoritesActionsModel.fromJson(response.data);
    } on DioError {
      // throw FetchDataException('No Internet connection');
      throw FetchDataException(DioError().error);
    }
  }
}
