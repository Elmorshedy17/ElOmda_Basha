import 'package:momentoo/features/change_password/changePassword_model.dart';
import 'package:momentoo/features/change_password/changePassword_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class ChangePasswordManager implements Manager {
  final BehaviorSubject<ChangePasswordModel> _adsSubject =
      BehaviorSubject<ChangePasswordModel>();

  Stream<ChangePasswordModel> postData(
      oldPassword, newPassword, confirmNewPassword) {
    Stream.fromFuture(ChangePasswordRepo.postChangePasswordData(
            oldPassword, newPassword, confirmNewPassword))
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
