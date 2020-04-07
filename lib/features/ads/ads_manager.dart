import 'package:momentoo/features/ads/ads_model.dart';
import 'package:momentoo/features/ads/ads_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class AdsManager implements Manager {
  final BehaviorSubject<AdsModel> _adsSubject = BehaviorSubject<AdsModel>();

  Stream<AdsModel> getData() {
    Stream.fromFuture(AdsRepo.getAdsData()).listen((v) {
      _adsSubject.add(v);
    });
    return _adsSubject.stream;
  }

  @override
  void dispose() {
    _adsSubject.close();
  }
}
