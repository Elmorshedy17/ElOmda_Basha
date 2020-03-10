import 'package:dio/dio.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class HomeRepo {
  static Future<dynamic> getData(String lang) async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${BaseOptions().baseUrl}/',
            options: Options(
              headers: {},
            ),
          );
      // return HomeModel.fromJson(response.data);
    } on DioError {
      throw FetchDataException('No Internet connection');
    }
  }
}
