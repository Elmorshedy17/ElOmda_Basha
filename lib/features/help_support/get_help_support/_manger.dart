import 'package:momentoo/features/about_us/about_model.dart';
import 'package:momentoo/features/about_us/about_repo.dart';
import 'package:momentoo/features/address_book/addressBook_model.dart';
import 'package:momentoo/features/address_book/addressBook_repo.dart';
import 'package:momentoo/features/help_support/get_help_support/_model.dart';
import 'package:momentoo/features/help_support/get_help_support/_repo.dart';
import 'package:momentoo/features/home/home_model.dart';
import 'package:momentoo/features/home/home_repo.dart';
import 'package:momentoo/shared/helper/manager.dart';
import 'package:rxdart/rxdart.dart';

class ContactUsManager implements Manager {
  final BehaviorSubject<ContactUsGetModel> _adsSubject = BehaviorSubject<ContactUsGetModel>();

  Stream<ContactUsGetModel> getData() {
    Stream.fromFuture(ContactUsGetRepo.getContactUsGetData()).listen((v) {
      _adsSubject.add(v);
    });
    return _adsSubject.stream;
  }

  @override
  void dispose() {
    _adsSubject.close();
  }
}
