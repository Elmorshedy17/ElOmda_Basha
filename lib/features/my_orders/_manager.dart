import 'package:momentoo/features/ads/ads_model.dart';
import 'package:momentoo/features/ads/ads_repo.dart';
import 'package:momentoo/features/my_orders/_model.dart';
import 'package:momentoo/features/my_orders/_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class MyOrdersManager implements Manager {
  final BehaviorSubject<MyOrdersModel> _adsSubject = BehaviorSubject<MyOrdersModel>();

  Stream<MyOrdersModel> getData() {
    Stream.fromFuture(MyOrdersRepo.getMyOrdersData()).listen((v) {
      _adsSubject.add(v);
    });
    return _adsSubject.stream;
  }

  @override
  void dispose() {
    _adsSubject.close();
  }
}
