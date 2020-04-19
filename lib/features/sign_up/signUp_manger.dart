import 'package:momentoo/features/sign_up/signUp_model.dart';
import 'package:momentoo/features/sign_up/signUp_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class RegisterManager implements Manager {
  final BehaviorSubject<RegisterModel> _adsSubject =
      BehaviorSubject<RegisterModel>();

  Stream<RegisterModel> postData(
      email, phone, password, confirm, first, mid, last, address) {
    Stream.fromFuture(RegisterRepo.postRegisterData(
            email, phone, password, confirm, first, mid, last, address))
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
