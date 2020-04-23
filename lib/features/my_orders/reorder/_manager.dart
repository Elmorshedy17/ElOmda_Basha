import 'package:momentoo/features/my_orders/reorder/_model.dart';
import 'package:momentoo/features/my_orders/reorder/_repo.dart';
import 'package:momentoo/features/join_us/_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';


class ReOrderManager implements Manager {
  final BehaviorSubject<ReOrderModel> _adsSubject = BehaviorSubject<ReOrderModel>();

  Stream<ReOrderModel> getData(Id) {
    Stream.fromFuture(ReOrderRepo.postReOrderData(Id)).listen((v) {
      _adsSubject.add(v);
    });
    return _adsSubject.stream;
  }

  @override
  void dispose() {
    _adsSubject.close();
  }
}
