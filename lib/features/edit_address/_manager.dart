import 'package:momentoo/features/about_us/about_model.dart';
import 'package:momentoo/features/about_us/about_repo.dart';
import 'package:momentoo/features/edit_address/_model.dart';
import 'package:momentoo/features/edit_address/_repo.dart';
import 'package:momentoo/features/home/home_model.dart';
import 'package:momentoo/features/home/home_repo.dart';

import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class AddressesInfoManager implements Manager {
  final BehaviorSubject<AddressesInfoModel> _adsSubject = BehaviorSubject<AddressesInfoModel>();

  Stream<AddressesInfoModel> getData(id) {
    Stream.fromFuture(AddressesInfoRepo.getAddressesInfoData(id)).listen((v) {
      _adsSubject.add(v);
    });
    return _adsSubject.stream;
  }

  @override
  void dispose() {
    _adsSubject.close();
  }
}
