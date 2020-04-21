import 'package:dio/dio.dart';
import 'package:momentoo/features/change_email/changeEmail_model.dart';
import 'package:momentoo/features/join_us/_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class JoinUsRepo {
  static Future<JoinUsModel> postJoinUsData(name,address,email,phone,SelectedImagePath,drivers) async {
    FormData formData = FormData.fromMap({
      "name": name,
      "address": address,
      "email": email,
      "phone": phone,
      "image": await MultipartFile.fromFile("$SelectedImagePath",filename: "$SelectedImagePath"),
      "drivers": drivers,
    });

    try {
      final Response response = await locator<ApiService>().dioClient.post(
        '${locator<ApiService>().dioClient.options.baseUrl}join_us',
        data: formData,
      );
      print(response.data);
      return JoinUsModel.fromJson(response.data);
    } on DioError {
      throw FetchDataException('No Internet connection');
    }
  }
}
