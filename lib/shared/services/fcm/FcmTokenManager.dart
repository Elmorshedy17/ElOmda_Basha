import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class FcmTokenManager implements Manager {
  // String _fcmToken = '';
  final BehaviorSubject<String> _fcmTokenSubject =
      BehaviorSubject<String>.seeded('');
  // Stream<String> get fcmToken$ => _fcmTokenSubject.stream;
  Sink<String> get inFcm => _fcmTokenSubject.sink;
  // String get currentFcmToken => _fcmToken;
  String get currentFcmToken => _fcmTokenSubject.value;

  // FcmTokenManager() {
  //   _fcmTokenSubject.listen((token) {
  //     _fcmToken = token;
  //   });
  // }

  @override
  void dispose() {
    _fcmTokenSubject.close();
  }
}
