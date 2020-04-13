import 'package:momentoo/features/change_email/_model.dart';
import 'package:momentoo/features/change_email/_repo.dart';
import 'package:momentoo/features/change_password/_model.dart';
import 'package:momentoo/features/change_password/_repo.dart';
import 'package:momentoo/features/home/home_repo.dart';
import 'package:momentoo/features/sign_up/_model.dart';
import 'package:momentoo/features/sign_up/_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class ChangeEmailManager implements Manager {
  final BehaviorSubject<ChangeEmailModel> _adsSubject = BehaviorSubject<ChangeEmailModel>();


  Stream<ChangeEmailModel> postData(oldEmail,newEmail,confirmNewEmail) {
    Stream.fromFuture(ChangeEmailRepo.postChangeEmailData(oldEmail,newEmail,confirmNewEmail)).listen((v) {
      _adsSubject.add(v);
    });
    return _adsSubject.stream;
  }



  @override
  void dispose() {
    _adsSubject.close();
  }
}
