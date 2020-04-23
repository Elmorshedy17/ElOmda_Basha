import 'package:dio/dio.dart';
import 'package:momentoo/features/change_email/changeEmail_model.dart';
import 'package:momentoo/features/join_us/_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';
import 'package:momentoo/features/my_orders/reorder/_model.dart';


class ReOrderRepo {
  static Future<ReOrderModel> postReOrderData(Id) async {

    try {
      final Response response = await locator<ApiService>().dioClient.post(
        '${locator<ApiService>().dioClient.options.baseUrl}reorder/$Id',
      );
      print(response.data);
      return ReOrderModel.fromJson(response.data);
    } on DioError {
      throw FetchDataException('No Internet connection');
    }
  }
}
