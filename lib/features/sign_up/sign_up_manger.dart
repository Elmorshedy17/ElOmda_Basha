import 'package:momentoo/features/home/home_repo.dart';
import 'package:momentoo/features/sign_up/_model.dart';
import 'package:momentoo/features/sign_up/_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class RegisterManager implements Manager {
  final BehaviorSubject<RegisterModel> _adsSubject = BehaviorSubject<RegisterModel>();


  Stream<RegisterModel> postData(email,phone,password,confirm,first,mid,last,adress) {
    Stream.fromFuture(RegisterRepo.postRegisterData(email,phone,password,confirm,first,mid,last,adress)).listen((v) {
      _adsSubject.add(v);
    });
    return _adsSubject.stream;
  }



  @override
  void dispose() {
    _adsSubject.close();
  }
}
