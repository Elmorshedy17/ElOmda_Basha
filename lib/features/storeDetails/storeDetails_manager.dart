import 'package:momentoo/features/storeDetails/storeDetails_model.dart';
import 'package:momentoo/features/storeDetails/storeDetails_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class StoreDetailsManager implements Manager {
  final BehaviorSubject<StoreDetailsModel> _subject =
      BehaviorSubject<StoreDetailsModel>();

  Stream<StoreDetailsModel> getData(int sellerId) {
    Stream.fromFuture(StoreDetailsRepo.getStoreDetailsData(sellerId))
        .listen((v) {
      _subject.add(v);
    });
    return _subject.stream;
  }

  @override
  void dispose() {
    _subject.close();
  }
}
