import 'package:momentoo/features/sign_in/signIn_model.dart';
import 'package:momentoo/features/sign_in/signIn_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class LoginManager implements Manager {
  final BehaviorSubject<LoginModel> _adsSubject = BehaviorSubject<LoginModel>();

  Stream<LoginModel> postData(email, password) {
    Stream.fromFuture(LoginRepo.postLoginData(email, password)).listen((v) {
      _adsSubject.add(v);
    });
    return _adsSubject.stream;
  }

  @override
  void dispose() {
    _adsSubject.close();
  }
}
