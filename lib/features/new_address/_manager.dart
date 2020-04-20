import 'package:momentoo/features/home/home_repo.dart';
import 'package:momentoo/features/new_address/_model.dart';
import 'package:momentoo/features/new_address/_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class NewAddressManager implements Manager {
  final BehaviorSubject<AddNewAddressModel> _adsSubject =
      BehaviorSubject<AddNewAddressModel>();

  Stream<AddNewAddressModel> postData(
      city, block, street, streetTwo, building, floor, jadda, flat, notes) {
    Stream.fromFuture(NewAddressRepo.postAddNewAddressData(city, block, street,
            streetTwo, building, floor, jadda, flat, notes))
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
