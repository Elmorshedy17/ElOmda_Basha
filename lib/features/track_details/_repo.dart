import 'package:dio/dio.dart';
import 'package:momentoo/features/track_details/_repo.dart';
import 'package:momentoo/features/track_details/_model.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/networking/ApiProvider.dart';
import 'package:momentoo/shared/services/networking/CustomException.dart';

class TrackOrderRepo {
  static Future<TrackOrderModel> getTrackOrderData(Id) async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
        '${locator<ApiService>().dioClient.options.baseUrl}track/$Id',
      );
      return TrackOrderModel.fromJson(response.data);
    } on DioError {
      // throw FetchDataException('No Internet connection');
      throw FetchDataException(DioError().error);
    }
  }
}
