import 'dart:io';

import 'package:dio/dio.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/fcm/FcmTokenManager.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class ApiService {
  final Dio dioClient = Dio(
    BaseOptions(
      baseUrl: '',
      connectTimeout: 60000,
      receiveTimeout: 60000,
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          options.headers = {
            'Auth': '',
            'Lang': locator<PrefsService>().appLanguage,
            'Platform': Platform.isAndroid ? 'android' : 'ios',
            'FirebaseToken': locator<FcmTokenManager>().currentFcmToken,
          };
          return options;
        },
        onResponse: (Response response) async {
          switch (response.statusCode) {
            case 200:
              // print(response);
              return response;
            case 400:
              throw BadRequestException(response.data.toString());
            case 401:

            case 403:
              throw UnauthorizedException(response.data.toString());
            case 500:

            default:
              throw FetchDataException(
                  '''Error occurred while Communication with Server with StatusCode :
             ${response.statusCode}''');
          }
        },
        onError: (DioError dioError) async {
          return dioError;
        },
      ),
    );

  // Future<dynamic> get(String url) async {
  //   var responseJson;
  //   try {
  //     final Response response = await dioClient.get(
  //       '${BaseOptions().baseUrl}/',
  //       options: Options(
  //         headers: {},
  //       ),
  //     );
  //     responseJson = _response(response);
  //   } on DioError {
  //     throw FetchDataException('No Internet connection');
  //   }
  //   return responseJson;
  // }
}

class Name {}
