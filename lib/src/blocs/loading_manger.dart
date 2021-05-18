import 'package:rxdart/rxdart.dart';

class IsLoadingManager {
  final BehaviorSubject isLoading = BehaviorSubject();
  void dispose() {
    isLoading.close();
  }
}
