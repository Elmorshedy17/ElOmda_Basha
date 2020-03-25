import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/fcm/FcmTokenManager.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';
import 'package:momentoo/shared/services/networking/DioConnectivityRequestRecall.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class CustomInterceptor implements Interceptor {
  final DioConnectivityRequestRecall requestRecall;

  CustomInterceptor({@required this.requestRecall});

  @override
  Future onRequest(RequestOptions options) async {
    options.headers = {
      'Auth': '',
      'Lang': locator<PrefsService>().appLanguage,
      'Platform': Platform.isAndroid ? 'android' : 'ios',
      'FirebaseToken': locator<FcmTokenManager>().currentFcmToken,
    };
    return options;
  }

  @override
  Future onResponse(Response response) async {
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
  }

  @override
  Future onError(DioError err) async {
    if (_shouldRecall(err)) {
      try {
        return requestRecall.scheduleRequestRecall(err.request);
      } catch (e) {
        return e;
      }
    }
    return err;
  }

  bool _shouldRecall(DioError err) {
    return err.type == DioErrorType.DEFAULT &&
        err.error != null &&
        err.error is SocketException;
  }
}
