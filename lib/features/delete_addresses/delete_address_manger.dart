import 'package:momentoo/features/delete_addresses/delete_address_model.dart';
import 'package:momentoo/features/delete_addresses/delete_address_repo.dart';
import 'package:momentoo/features/home/home_repo.dart';
import 'package:momentoo/features/sign_in/_model.dart';
import 'package:momentoo/features/sign_in/_repo.dart';
import 'package:momentoo/features/sign_up/_model.dart';
import 'package:momentoo/features/sign_up/_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class DeleteNewAddressManager implements Manager {
  final BehaviorSubject<DeleteNewAddressModel> _adsSubject = BehaviorSubject<DeleteNewAddressModel>();


  Stream<DeleteNewAddressModel> postData(id) {
    Stream.fromFuture(DeleteAddressRepo.postDeleteNewAddressData(id)).listen((v) {
      _adsSubject.add(v);
    });
    return _adsSubject.stream;
  }



  @override
  void dispose() {
    _adsSubject.close();
  }
}
