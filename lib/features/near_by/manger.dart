import 'package:momentoo/features/about_us/about_model.dart';
import 'package:momentoo/features/about_us/about_repo.dart';
import 'package:momentoo/features/address_book/addressBook_model.dart';
import 'package:momentoo/features/address_book/addressBook_repo.dart';
import 'package:momentoo/features/help_support/get_help_support/_model.dart';
import 'package:momentoo/features/help_support/get_help_support/_repo.dart';
import 'package:momentoo/features/home/home_model.dart';
import 'package:momentoo/features/home/home_repo.dart';
import 'package:momentoo/features/near_by/_model.dart';
import 'package:momentoo/features/near_by/_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class NearByManager implements Manager {

  final BehaviorSubject<NearByModel> _adsSubject = BehaviorSubject<NearByModel>();

   BehaviorSubject catSubject = BehaviorSubject.seeded(1);

  Stream<NearByModel> getData(catSubject,word,cityID,cuisineID) {
    Stream.fromFuture(nearByRepo.getNearByData(catSubject,word,cityID,cuisineID)).listen((v) {
      _adsSubject.add(v);
    });
    return _adsSubject.stream;
  }

  @override
  void dispose() {
    _adsSubject.close();
    catSubject.close();
  }
}
