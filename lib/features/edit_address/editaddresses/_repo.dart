import 'package:dio/dio.dart';
import 'package:momentoo/features/edit_address/editaddresses/_model.dart';
import 'package:momentoo/features/forget_password/_model.dart';
import 'package:momentoo/features/new_address/_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class EditAddressRepo {
  static Future<EditAddressesModel> postEditAddressData(city,block,street,streetTwo,building,floor,jadda,flat,notes,id) async {


    FormData formData =

    FormData.fromMap({
      "city_id": city,
      "block": block,
      "street": street,
      "street_2": streetTwo,
      "building": building,
      "floor": floor,
      "jadda": jadda,
      "flat": flat,
      "notes": notes,
    });


    try {
      final Response response = await locator<ApiService>().dioClient.post(
        '${locator<ApiService>().dioClient.options.baseUrl}edit_address/$id',
        data:formData,

      );
      return EditAddressesModel.fromJson(response.data);
    } on DioError {
      throw FetchDataException('No Internet connection');
    }

  }
}