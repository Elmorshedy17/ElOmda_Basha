import 'package:momentoo/features/change_email/changeEmail_model.dart';
import 'package:momentoo/features/change_email/changeEmail_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class ChangeEmailManager implements Manager {
  final BehaviorSubject<ChangeEmailModel> _adsSubject =
      BehaviorSubject<ChangeEmailModel>();

  Stream<ChangeEmailModel> postData(oldEmail, newEmail, confirmNewEmail) {
    Stream.fromFuture(ChangeEmailRepo.postChangeEmailData(
            oldEmail, newEmail, confirmNewEmail))
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
