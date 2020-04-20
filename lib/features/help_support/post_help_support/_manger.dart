import 'package:momentoo/features/help_support/post_help_support/_model.dart';
import 'package:momentoo/features/help_support/post_help_support/_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class LoginManager implements Manager {
  final BehaviorSubject<ContactUsPostModel> _adsSubject =
      BehaviorSubject<ContactUsPostModel>();

  Stream<ContactUsPostModel> postData(name, email, phone, type, message) {
    Stream.fromFuture(ContactUsPostRepo.postContactUsData(
            name, email, phone, type, message))
        .listen((v) {
      _adsSubject.add(v);
    });
    return _adsSubject.stream;
  }

  @override
  void dispose() {
    _adsSubject.close();
  }
}
