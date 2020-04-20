import 'package:dio/dio.dart';
import 'package:momentoo/features/new_address/_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class NewAddressRepo {
  static Future<AddNewAddressModel> postAddNewAddressData(city, block, street,
      streetTwo, building, floor, jadda, flat, notes) async {
    FormData formData = FormData.fromMap({
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
            '${locator<ApiService>().dioClient.options.baseUrl}add_address',
            data: formData,
          );
      return AddNewAddressModel.fromJson(response.data);
    } on DioError {
      throw FetchDataException('No Internet connection');
    }
  }
}
