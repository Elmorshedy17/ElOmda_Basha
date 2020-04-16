import 'package:momentoo/features/edit_address/editaddresses/_model.dart';
import 'package:momentoo/features/edit_address/editaddresses/_repo.dart';
import 'package:momentoo/features/home/home_repo.dart';
import 'package:momentoo/features/new_address/_model.dart';
import 'package:momentoo/features/new_address/_repo.dart';
import 'package:momentoo/features/sign_in/_model.dart';
import 'package:momentoo/features/sign_in/_repo.dart';
import 'package:momentoo/features/sign_up/_model.dart';
import 'package:momentoo/features/sign_up/_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class EditAddressManager implements Manager {
  final BehaviorSubject<EditAddressesModel> _adsSubject = BehaviorSubject<EditAddressesModel>();


  Stream<EditAddressesModel> postData(city,block,street,streetTwo,building,floor,jadda,flat,notes,id) {
    Stream.fromFuture(EditAddressRepo.postEditAddressData(city,block,street,streetTwo,building,floor,jadda,flat,notes,id)).listen((v) {
      _adsSubject.add(v);
    });
    return _adsSubject.stream;
  }



  @override
  void dispose() {
    _adsSubject.close();
  }
}
