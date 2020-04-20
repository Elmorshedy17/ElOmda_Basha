import 'package:momentoo/features/settings/settings_model.dart';
import 'package:momentoo/features/settings/settings_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class SettingsManager implements Manager {
  final BehaviorSubject<SettingsModel> _subject =
      BehaviorSubject<SettingsModel>();

  Stream<SettingsModel> getData() {
    Stream.fromFuture(SettingsRepo.getSettingsData()).listen((v) {
      _subject.add(v);
    });
    return _subject.stream;
  }

  @override
  void dispose() {
    _subject.close();
  }
}
