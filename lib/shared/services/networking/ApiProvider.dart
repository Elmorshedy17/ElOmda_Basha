import 'package:dio/dio.dart';
import 'package:momentoo/shared/services/networking/CustomInterceptor.dart';
import 'package:momentoo/shared/services/networking/DioConnectivityRequestRecall.dart';

class ApiService {
  final Dio dioClient = Dio(
    BaseOptions(
      baseUrl: '',
      connectTimeout: 60000,
      receiveTimeout: 60000,
    ),
  )..interceptors.add(
      CustomInterceptor(
        requestRecall: DioConnectivityRequestRecall(),
      ),
    );
}

//  interceptors.add(
//      InterceptorsWrapper(
//        onRequest: (RequestOptions options) async {
//          options.headers = {
//            'Auth': '',
//            'Lang': locator<PrefsService>().appLanguage,
//            'Platform': Platform.isAndroid ? 'android' : 'ios',
//            'FirebaseToken': locator<FcmTokenManager>().currentFcmToken,
//          };
//          return options;
//        },
//        onResponse: (Response response) async {
//          switch (response.statusCode) {
//            case 200:
//              // print(response);
//              return response;
//            case 400:
//              throw BadRequestException(response.data.toString());
//            case 401:
//
//            case 403:
//              throw UnauthorizedException(response.data.toString());
//            case 500:
//
//            default:
//              throw FetchDataException(
//                  '''Error occurred while Communication with Server with StatusCode :
//             ${response.statusCode}''');
//          }
//        },
//        onError: (DioError dioError) async {
//          if (dioError.type == DioErrorType.DEFAULT &&
//              dioError.error != null &&
//              dioError.error is SocketException) {}
//          return dioError;
//        },
//      ),
//    );
