import 'package:dio/dio.dart';
import 'package:momentoo/features/delete_addresses/delete_address_model.dart';
import 'package:momentoo/features/sign_in/_model.dart';
import 'package:momentoo/features/sign_up/_model.dart';
import 'package:momentoo/features/sign_up/signUpValidation_manager.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class DeleteAddressRepo {
  static Future<DeleteNewAddressModel> postDeleteNewAddressData(id) async {


    FormData formData =

    FormData.fromMap({});





    try {
      final Response response = await locator<ApiService>().dioClient.post(
        '${locator<ApiService>().dioClient.options.baseUrl}delete_address/$id',
        data:formData,

      );
      return DeleteNewAddressModel.fromJson(response.data);
    } on DioError {
      throw FetchDataException('No Internet connection');
    }

  }
}