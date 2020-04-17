import 'package:dio/dio.dart';
import 'package:momentoo/features/about_us/about_model.dart';
import 'package:momentoo/features/address_book/addressBook_model.dart';
import 'package:momentoo/features/help_support/get_help_support/_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class ContactUsGetRepo {
  static Future<ContactUsGetModel> getContactUsGetData() async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
        '${locator<ApiService>().dioClient.options.baseUrl}contact',
      );
      return ContactUsGetModel.fromJson(response.data);
    } on DioError {
      throw FetchDataException('No Internet connection');
    }
  }
}


