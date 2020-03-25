import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:momentoo/shared/services/connection_service.dart';

class DioConnectivityRequestRecall {
  final Dio dio;
  final ConnectionCheckerService checkerService;

  DioConnectivityRequestRecall({
    @required this.dio,
    @required this.checkerService,
  });

  Future<Response> scheduleRequestRecall(RequestOptions requestOptions) async {
    StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = checkerService.getConnectionStatus$.listen((status) {
      if (status == InternetStatus.Online) {
        // Ensure that only one retry happens per connectivity change by cancelling the listener.
        streamSubscription.cancel();
        // Complete the completer instead of returning
        responseCompleter.complete(
          dio.request(
            requestOptions.path,
            cancelToken: requestOptions.cancelToken,
            data: requestOptions.data,
            onReceiveProgress: requestOptions.onReceiveProgress,
            onSendProgress: requestOptions.onSendProgress,
            queryParameters: requestOptions.queryParameters,
            options: requestOptions,
          ),
        );
      }
    });
    return responseCompleter.future;
  }
}
