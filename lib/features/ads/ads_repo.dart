import 'package:dio/dio.dart';
import 'package:momentoo/features/ads/ads_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class AdsRepo {
  static Future<AdsModel> getAdsData() async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}ads',
          );
      return AdsModel.fromJson(response.data);
    } on DioError catch (e) {
      // throw FetchDataException('No Internet connection');
      // throw FetchDataException(DioError().error);
      throw (e.message);
    }
  }
}
