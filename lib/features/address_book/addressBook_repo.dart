import 'package:dio/dio.dart';
import 'package:momentoo/features/about_us/about_model.dart';
import 'package:momentoo/features/address_book/addressBook_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class AddressesRepo {
  static Future<AddressesModel> getAddressesData() async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
        '${locator<ApiService>().dioClient.options.baseUrl}addresses',
      );
      return AddressesModel.fromJson(response.data);
    } on DioError {
      throw FetchDataException('No Internet connection');
    }
  }
}


