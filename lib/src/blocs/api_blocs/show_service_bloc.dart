import 'dart:async';
import 'package:rxdart/rxdart.dart';

class ShowServiceBloc {
  // final BehaviorSubject<String> startDateSubject = BehaviorSubject<String>();
  //
  // final BehaviorSubject<String> endDateSubject = BehaviorSubject<String>();


  final BehaviorSubject startDateFilterBloc = BehaviorSubject.seeded("");
  final BehaviorSubject endDateFilterBloc = BehaviorSubject.seeded("");

  void showServiceClear(){
    startDateFilterBloc.sink.add("");
    endDateFilterBloc.sink.add("");
  }
  dispose() {
    // startDateSubject.close();
    // endDateSubject.close();
    startDateFilterBloc.close();
    endDateFilterBloc.close();
  }
}
