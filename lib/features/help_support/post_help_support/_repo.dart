import 'package:dio/dio.dart';
import 'package:momentoo/features/help_support/post_help_support/_model.dart';
import 'package:momentoo/features/sign_in/_model.dart';
import 'package:momentoo/features/sign_up/_model.dart';
import 'package:momentoo/features/sign_up/signUpValidation_manager.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class ContactUsPostRepo {
  static Future<ContactUsPostModel> postContactUsData(name,email,phone,type,message) async {


    FormData formData =

    FormData.fromMap({
      "name": name,
      "message": message,
      "email": email,
      "phone": phone,
      "complaint_id": "$type",
    });





    try {
      final Response response = await locator<ApiService>().dioClient.post(
        '${locator<ApiService>().dioClient.options.baseUrl}contact',
        data:formData,

      );
      return ContactUsPostModel.fromJson(response.data);
    } on DioError {
      throw FetchDataException('No Internet connection');
    }

  }
}