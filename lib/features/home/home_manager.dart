// import 'package:momentoo/features/home/home_repo.dart';
// import 'package:momentoo/shared/helper/locator.dart';
// import 'package:momentoo/shared/services/prefs_service.dart';
// import 'package:rxdart/rxdart.dart';

// class HomeManager {
//   final BehaviorSubject<String> _langSubject =
//       BehaviorSubject<String>.seeded(locator<PrefsService>().appLanguage);
//   // final BehaviorSubject<> _aboutSubject =
//   //     BehaviorSubject<>();

//   // Stream<> get home$ => _aboutSubject.stream;
//   Sink<String> get inLang => _langSubject.sink;

//   HomeManager() {
//     _langSubject.switchMap((lang) async* {
//       yield await HomeRepo.getData();
//     }).listen((value) {
//       // _aboutSubject.add(value);
//     });
//   }
// }
