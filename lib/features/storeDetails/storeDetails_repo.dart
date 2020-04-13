import 'package:dio/dio.dart';
import 'package:momentoo/features/storeDetails/storeDetails_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class StoreDetailsRepo {
  static Future<StoreDetailsModel> getStoreDetailsData(int sellerId) async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}seller/$sellerId',
          );
      return StoreDetailsModel.fromJson(response.data);
    } on DioError {
      // throw FetchDataException('No Internet connection');
      throw FetchDataException(DioError().error);
    }
  }
}
