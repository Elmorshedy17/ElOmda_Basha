
import 'package:momentoo/features/track_details/_repo.dart';
import 'package:momentoo/features/track_details/_model.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class TrackOrderManager implements Manager {
  final BehaviorSubject<TrackOrderModel> _adsSubject = BehaviorSubject<TrackOrderModel>();

  Stream<TrackOrderModel> getData(Id) {
    Stream.fromFuture(TrackOrderRepo.getTrackOrderData(Id)).listen((v) {
      _adsSubject.add(v);
    });
    return _adsSubject.stream;
  }

  @override
  void dispose() {
    _adsSubject.close();
  }
}
