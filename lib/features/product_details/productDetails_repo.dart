import 'package:dio/dio.dart';
import 'package:momentoo/features/product_details/productDetails_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class ProductDetailsRepo {
  static Future<ProductDetailsModel> getProductDetailsData(
      int productId) async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}product/$productId',
          );
      return ProductDetailsModel.fromJson(response.data);
    } on DioError {
      // throw FetchDataException('No Internet connection');
      throw FetchDataException(DioError().error);
    }
  }
}
