import 'package:dio/dio.dart';
import 'package:momentoo/features/shopping_cart/cartActions_model.dart';
import 'package:momentoo/shared/domain/cartRequest.dart' as cart;
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class CartActionsRepo {
  static Map<String, dynamic> myMap() {
    if (locator<PrefsService>().cartObj == null) {
      cart.LocalCart dummyCart = cart.LocalCart()
        ..sellerId = -1
        ..products.add(
            cart.Products(productId: -1, count: -1, options: '', notes: ''));
      locator<PrefsService>().cartObj = dummyCart;
      return locator<PrefsService>().cartObj.toJson();
      // locator<CartActionsManager>().getData();
    } else {
      return locator<PrefsService>().cartObj.toJson();
    }
  }

  static Future<CartActionsModel> postCartData() async {
    FormData formData = FormData.fromMap(myMap()
        // locator<PrefsService>().cartObj.toJson()
        );

    try {
      final Response response = await locator<ApiService>().dioClient.post(
            '${locator<ApiService>().dioClient.options.baseUrl}cart',
            data: formData,
          );
      return CartActionsModel.fromJson(response.data);
    } on DioError {
      // throw FetchDataException('No Internet connection');
      throw FetchDataException(DioError().error);
    }
  }
}
