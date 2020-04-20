import 'package:momentoo/features/forget_password/forgetPassword_model.dart';
import 'package:momentoo/features/forget_password/forgetPassword_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class ForgetPasswordManager implements Manager {
  final BehaviorSubject<ForgetPasswordModel> _adsSubject =
      BehaviorSubject<ForgetPasswordModel>();

  Stream<ForgetPasswordModel> postData(email) {
    Stream.fromFuture(ForgetPasswordRepo.postForgetPasswordData(email))
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
