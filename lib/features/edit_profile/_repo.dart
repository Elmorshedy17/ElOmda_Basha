import 'package:dio/dio.dart';
import 'package:momentoo/features/edit_profile/_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class EditProfileRepo {
  static Future<EditProfileModel> postEditProfileData(
      firstName, middelName, lastName, phone) async {
    FormData formData = FormData.fromMap({
      "phone": phone,
      "first_name": "$firstName",
      "middle_name": "$middelName",
      "last_name": "$lastName",
    });

    try {
      final Response response = await locator<ApiService>().dioClient.post(
            '${locator<ApiService>().dioClient.options.baseUrl}profile',
            data: formData,
          );
      print("response$response");
      return EditProfileModel.fromJson(response.data);
    } on DioError {
      throw FetchDataException('No Internet connection');
    }
  }
}
