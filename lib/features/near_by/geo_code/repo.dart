import 'dart:io';

import 'package:dio/dio.dart';
import 'package:momentoo/features/help_support/post_help_support/_model.dart';
import 'package:momentoo/features/near_by/geo_code/geo_code_model.dart';
import 'package:momentoo/features/sign_in/_model.dart';
import 'package:momentoo/features/sign_up/_model.dart';
import 'package:momentoo/features/sign_up/signUpValidation_manager.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';


class geoCodeRepo {

  static Future <GeoCodeModel> geoCode(lat, lng) async {
    Response response;
    Dio dio = new Dio();

    try {
      response = await dio.get(
          "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=${Platform
              .isAndroid
              ? "AIzaSyBjzO55poKvqbwepgZK1wioHj0GOYcPZMM"
              : "AIzaSyAWxomwJys-vAXdtyrreAkGHTBJoZcWCt8"}");

      return GeoCodeModel.fromJson(response.data);
    } on DioError {
      throw FetchDataException('No Internet connection');
    }
    print(response.data.toString());
  }
}