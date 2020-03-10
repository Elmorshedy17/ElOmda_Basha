import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class GetAddressManager implements Manager {
  final BehaviorSubject<String> _featureNameSubject =
      BehaviorSubject<String>.seeded('Select Your Location');
  final BehaviorSubject<String> _addressLineSubject =
      BehaviorSubject<String>.seeded('');

  Stream<String> get featureName$ => _featureNameSubject.stream;
  Sink<String> get inFeatureName => _featureNameSubject.sink;

  Stream<String> get addressLine$ => _addressLineSubject.stream;
  Sink<String> get inAddressLine => _addressLineSubject.sink;

  @override
  void dispose() {
    _featureNameSubject.close();
    _addressLineSubject.close();
  }
}
