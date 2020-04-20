import 'package:momentoo/features/profile/_model.dart';
import 'package:momentoo/features/profile/_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class ProfileManager implements Manager {
  final BehaviorSubject<ProfileModel> _adsSubject =
      BehaviorSubject<ProfileModel>();

  Stream<ProfileModel> getData() {
    Stream.fromFuture(ProfileRepo.getProfileData()).listen((v) {
      _adsSubject.add(v);
    });
    return _adsSubject.stream;
  }

  @override
  void dispose() {
    _adsSubject.close();
  }
}
