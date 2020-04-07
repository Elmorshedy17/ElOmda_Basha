import 'package:momentoo/features/home/home_model.dart';
import 'package:momentoo/features/home/home_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class HomeManager implements Manager {
  final BehaviorSubject<HomeModel> _adsSubject = BehaviorSubject<HomeModel>();

  Stream<HomeModel> getData(int categoryId) {
    Stream.fromFuture(HomeRepo.getHomeData(categoryId)).listen((v) {
      _adsSubject.add(v);
    });
    return _adsSubject.stream;
  }

  @override
  void dispose() {
    _adsSubject.close();
  }
}
