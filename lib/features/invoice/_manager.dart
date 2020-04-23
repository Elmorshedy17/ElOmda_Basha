import 'package:momentoo/features/ads/ads_model.dart';
import 'package:momentoo/features/ads/ads_repo.dart';
import 'package:momentoo/features/invoice/_model.dart';
import 'package:momentoo/features/invoice/_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class OrderDetailsManager implements Manager {
  final BehaviorSubject<InvoiceModel> _adsSubject = BehaviorSubject<InvoiceModel>();

  Stream<InvoiceModel> getData(Id) {
    Stream.fromFuture(OrderDetailsRepo.getOrderDetailsData(Id)).listen((v) {
      _adsSubject.add(v);
    });
    return _adsSubject.stream;
  }

  @override
  void dispose() {
    _adsSubject.close();
  }
}
