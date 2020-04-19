import 'package:momentoo/features/edit_profile/_model.dart';
import 'package:momentoo/features/edit_profile/_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class EditProfileManager implements Manager {
  final BehaviorSubject<EditProfileModel> _adsSubject = BehaviorSubject<EditProfileModel>();


  Stream<EditProfileModel> postData(phone,firstName,middelName,lastName){
    Stream.fromFuture(EditProfileRepo.postEditProfileData(phone,firstName,middelName,lastName)).listen((v) {
      _adsSubject.add(v);
    });
    return _adsSubject.stream;
  }



  @override
  void dispose() {
    _adsSubject.close();
  }
}
