import 'package:dio/dio.dart';
import 'package:momentoo/features/home/autoComplete_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class AutoCompleteRepo {
  static Future<AutoCompleteModel> getData(int categoryId, String query) async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            '${locator<ApiService>().dioClient.options.baseUrl}auto_complete/$categoryId?word=$query',
          );
      return AutoCompleteModel.fromJson(response.data);
    } on DioError {
      // throw FetchDataException('No Internet connection');
      throw FetchDataException(DioError().error);
    }
  }
}
