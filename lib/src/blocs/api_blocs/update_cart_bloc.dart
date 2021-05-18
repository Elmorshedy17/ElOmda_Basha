import 'dart:async';
import 'package:rxdart/rxdart.dart';

class UpdateCartModel {
/////////////// USER TYPE
  final BehaviorSubject quantityCartBloc =
  BehaviorSubject();

//  Stream get UserTypeApiStream$ => _UserTypeSubject.stream;

   get quantityCartBlocSink => quantityCartBloc.sink;

   get currentQuantityCartBloc => quantityCartBloc.value;

   
   
   //////////// this is cart Id ////////////////
   
  final BehaviorSubject cartIdBloc =
  BehaviorSubject();

//  Stream get UserTypeApiStream$ => _UserTypeSubject.stream;

   get cartIdBlocSink => cartIdBloc.sink;

   get currentCartIdBloc => cartIdBloc.value;

  dispose() {
    cartIdBloc.close();
    quantityCartBloc.close();
  }

}
