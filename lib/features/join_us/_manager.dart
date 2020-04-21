import 'package:momentoo/features/join_us/_model.dart';
import 'package:momentoo/features/join_us/_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class JoinUsManager implements Manager {
  final BehaviorSubject<JoinUsModel> _adsSubject = BehaviorSubject<JoinUsModel>();

  Stream<JoinUsModel> getData(name,address,email,phone,SelectedImagePath,drivers) {
    Stream.fromFuture(JoinUsRepo.postJoinUsData(name,address,email,phone,SelectedImagePath,drivers)).listen((v) {
      _adsSubject.add(v);
    });
    return _adsSubject.stream;
  }

  @override
  void dispose() {
    _adsSubject.close();
  }
}
