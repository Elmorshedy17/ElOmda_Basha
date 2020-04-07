import 'package:dio/dio.dart';
import 'package:momentoo/features/home/home_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class HomeRepo {
  static Future<HomeModel> getHomeData(int categoryId) async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}home_screen?category_id=$categoryId',
          );
      return HomeModel.fromJson(response.data);
    } on DioError {
      throw FetchDataException('No Internet connection');
    }
  }
}
