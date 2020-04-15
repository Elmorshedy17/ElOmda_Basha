import 'package:momentoo/features/about_us/about_model.dart';
import 'package:momentoo/features/about_us/about_repo.dart';
import 'package:momentoo/features/home/home_model.dart';
import 'package:momentoo/features/home/home_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class AboutManager implements Manager {
  final BehaviorSubject<AboutModel> _adsSubject = BehaviorSubject<AboutModel>();

  Stream<AboutModel> getData() {
    Stream.fromFuture(AboutRepo.getAboutData()).listen((v) {
      _adsSubject.add(v);
    });
    return _adsSubject.stream;
  }

  @override
  void dispose() {
    _adsSubject.close();
  }
}
