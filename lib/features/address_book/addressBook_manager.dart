import 'package:momentoo/features/about_us/about_model.dart';
import 'package:momentoo/features/about_us/about_repo.dart';
import 'package:momentoo/features/address_book/addressBook_model.dart';
import 'package:momentoo/features/address_book/addressBook_repo.dart';
import 'package:momentoo/features/home/home_model.dart';
import 'package:momentoo/features/home/home_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class AddressesManager implements Manager {
  final BehaviorSubject<AddressesModel> _adsSubject = BehaviorSubject<AddressesModel>();

  Stream<AddressesModel> getData() {
    Stream.fromFuture(AddressesRepo.getAddressesData()).listen((v) {
      _adsSubject.add(v);
    });
    return _adsSubject.stream;
  }

  @override
  void dispose() {
    _adsSubject.close();
  }
}
