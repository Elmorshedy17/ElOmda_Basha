import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:momentoo/features/address_book/addressBook_manager.dart';
import 'package:momentoo/features/edit_address/cityDropdown.dart';
import 'package:momentoo/features/edit_address/dropdown_data.dart';
import 'package:momentoo/features/edit_address/editaddresses/_repo.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/network_sensitive.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:momentoo/features/new_address/_repo.dart';
import 'package:rxdart/rxdart.dart';

class EditAddressScreen extends StatefulWidget {
  var modelData;
  EditAddressScreen(this.modelData);

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  TextEditingController blockController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController streetTwoController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController jaddaController = TextEditingController();
  TextEditingController appartmentController = TextEditingController();
  TextEditingController deliveryController = TextEditingController();
  BehaviorSubject isLoading = new BehaviorSubject.seeded(false);

  final blockFocus = FocusNode();
  final streetFocus = FocusNode();
  final streetTwoFocus = FocusNode();
  final houseFocus = FocusNode();
  final floorFocus = FocusNode();
  final jaddaFocus = FocusNode();
  final apartmentFocus = FocusNode();
  final instructiosFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    blockController =
        new TextEditingController(text: widget.modelData.data.address.block);
    streetController =
        new TextEditingController(text: widget.modelData.data.address.street);
    streetTwoController =
        new TextEditingController(text: widget.modelData.data.address.street2);
    houseController =
        new TextEditingController(text: widget.modelData.data.address.building);
    floorController =
        new TextEditingController(text: widget.modelData.data.address.floor);
    jaddaController =
        new TextEditingController(text: widget.modelData.data.address.jadda);
    appartmentController =
        new TextEditingController(text: widget.modelData.data.address.flat);
    deliveryController =
        new TextEditingController(text: widget.modelData.data.address.notes);
  }

  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      child: MainBackground(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context).translate('editAddress_str'),
              style: TextStyle(
//              color: Colors.teal.shade900,
//              fontSize: 25,
//              fontWeight: FontWeight.bold,
                fontFamily:
                    locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar',
              ),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.arrow_back_ios,
                    size: 15,
                  ),
                  Text(
                    AppLocalizations.of(context).translate('back_str'),
                    style: TextStyle(
                      fontFamily: locator<PrefsService>().appLanguage == 'en'
                          ? 'en'
                          : 'ar',
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(15.0),
//          padding: EdgeInsets.all(15.0),
                child: ListView(
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            children: <Widget>[
                              Card(
                                color: Colors.grey[200],
//                        elevation: 5,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 60,
                                  child: Align(
                                    alignment:
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? Alignment.centerLeft
                                            : Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        widget.modelData.data.country.name,
//                                  AppLocalizations.of(context)
//                                      .translate('Kuwait_str'),
                                        style: TextStyle(
                                          color: Colors.teal.shade900,
//                              fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: locator<PrefsService>()
                                                      .appLanguage ==
                                                  'en'
                                              ? 'en'
                                              : 'ar',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              CityDropdown(widget.modelData.data.cities),
                              Container(
                                padding: EdgeInsets.all(4),
                                // width: MediaQuery.of(context).size.width * 0.8,
                                // height: 60,
                                child: Row(
                                  // mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: TextField(
                                        textInputAction: TextInputAction.next,
                                        focusNode: blockFocus,
                                        onSubmitted: (v) {
                                          FocusScope.of(context)
                                              .requestFocus(streetFocus);
                                        },
                                        controller: blockController,
                                        decoration: InputDecoration(
                                            filled: true,
                                            border: InputBorder.none,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(10.0),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(10.0),
                                              ),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(10.0),
                                              ),
                                            ),
                                            hintStyle: TextStyle(
                                              color: Colors.grey[600],
                                              fontFamily:
                                                  locator<PrefsService>()
                                                              .appLanguage ==
                                                          'en'
                                                      ? 'en'
                                                      : 'ar',
                                            ),
                                            hintText:
                                                AppLocalizations.of(context)
                                                    .translate('Block_Str'),
                                            fillColor: Colors.grey[200]),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: TextField(
                                        textInputAction: TextInputAction.next,
                                        focusNode: streetFocus,
                                        onSubmitted: (v) {
                                          FocusScope.of(context)
                                              .requestFocus(streetTwoFocus);
                                        },
                                        controller: streetController,
                                        decoration: InputDecoration(
                                            filled: true,
                                            border: InputBorder.none,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(10.0),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(10.0),
                                              ),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(10.0),
                                              ),
                                            ),
                                            hintStyle: TextStyle(
                                              color: Colors.grey[600],
                                              fontFamily:
                                                  locator<PrefsService>()
                                                              .appLanguage ==
                                                          'en'
                                                      ? 'en'
                                                      : 'ar',
                                            ),
                                            hintText:
                                                AppLocalizations.of(context)
                                                    .translate('Street_str'),
                                            fillColor: Colors.grey[200]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(4),
                                child: TextField(
                                  textInputAction: TextInputAction.next,
                                  focusNode: streetTwoFocus,
                                  onSubmitted: (v) {
                                    FocusScope.of(context)
                                        .requestFocus(houseFocus);
                                  },
                                  controller: streetTwoController,
                                  decoration: InputDecoration(
                                      filled: true,
                                      border: InputBorder.none,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                      ),
                                      hintText: AppLocalizations.of(context)
                                          .translate('Street_two_str'),
                                      fillColor: Colors.grey[200]),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(4),
                                child: TextField(
                                  textInputAction: TextInputAction.next,
                                  focusNode: houseFocus,
                                  onSubmitted: (v) {
                                    FocusScope.of(context)
                                        .requestFocus(floorFocus);
                                  },
                                  controller: houseController,
                                  decoration: InputDecoration(
                                      filled: true,
                                      border: InputBorder.none,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                      ),
                                      hintText: AppLocalizations.of(context)
                                          .translate('House_building_str'),
                                      fillColor: Colors.grey[200]),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(4),
                                // width: MediaQuery.of(context).size.width * 0.8,
                                // height: 60,
                                child: Row(
                                  // mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: TextField(
                                        textInputAction: TextInputAction.next,
                                        focusNode: floorFocus,
                                        onSubmitted: (v) {
                                          FocusScope.of(context)
                                              .requestFocus(jaddaFocus);
                                        },
                                        controller: floorController,
                                        decoration: InputDecoration(
                                            filled: true,
                                            border: InputBorder.none,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(10.0),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(10.0),
                                              ),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(10.0),
                                              ),
                                            ),
                                            hintStyle: TextStyle(
                                              color: Colors.grey[600],
                                              fontFamily:
                                                  locator<PrefsService>()
                                                              .appLanguage ==
                                                          'en'
                                                      ? 'en'
                                                      : 'ar',
                                            ),
                                            hintText:
                                                AppLocalizations.of(context)
                                                    .translate('Floor_Str'),
                                            fillColor: Colors.grey[200]),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: TextField(
                                        textInputAction: TextInputAction.next,
                                        focusNode: jaddaFocus,
                                        onSubmitted: (v) {
                                          FocusScope.of(context)
                                              .requestFocus(apartmentFocus);
                                        },
                                        controller: jaddaController,
                                        decoration: InputDecoration(
                                            filled: true,
                                            border: InputBorder.none,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(10.0),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(10.0),
                                              ),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.transparent),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(10.0),
                                              ),
                                            ),
                                            hintStyle: TextStyle(
                                              color: Colors.grey[600],
                                              fontFamily:
                                                  locator<PrefsService>()
                                                              .appLanguage ==
                                                          'en'
                                                      ? 'en'
                                                      : 'ar',
                                            ),
                                            hintText:
                                                AppLocalizations.of(context)
                                                    .translate('Jadda_str'),
                                            fillColor: Colors.grey[200]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(4),
                                child: TextField(
                                  textInputAction: TextInputAction.next,
                                  focusNode: apartmentFocus,
                                  onSubmitted: (v) {
                                    FocusScope.of(context)
                                        .requestFocus(instructiosFocus);
                                  },
                                  controller: appartmentController,
                                  decoration: InputDecoration(
                                      suffixText: AppLocalizations.of(context)
                                          .translate('optional_Str'),
                                      suffixStyle: TextStyle(
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                      ),
                                      filled: true,
                                      border: InputBorder.none,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                      ),
                                      hintText: AppLocalizations.of(context)
                                          .translate('Apartment_Office_name'),
                                      fillColor: Colors.grey[200]),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(4),
                                child: TextField(
                                  textInputAction: TextInputAction.done,
                                  focusNode: instructiosFocus,
                                  // onSubmitted: (v) {
                                  //   FocusScope.of(context).requestFocus(instructiosFocus);
                                  // },
                                  controller: deliveryController,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                      suffixText: AppLocalizations.of(context)
                                          .translate('optional_Str'),
                                      suffixStyle: TextStyle(
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                      ),
                                      filled: true,
                                      border: InputBorder.none,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                      ),
                                      hintText: AppLocalizations.of(context)
                                          .translate('Delivery_instructions'),
                                      fillColor: Colors.grey[200]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    ButtonTheme(
                      height: 55,
                      minWidth: MediaQuery.of(context).size.width * 0.8,
                      child: RaisedButton(
                        color: Colors.teal.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.white24),
                        ),
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('saveThisAddress_str'),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily:
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                          ),
                        ),
                        onPressed: () {
                          // isLoading.add(true);
//                          NewAddressRepo.postAddNewAddressData(locator<DrobDownBloc>().currentDrobDownvalue ==  null ? "" : locator<DrobDownBloc>().currentDrobDownvalue ,blockController.text,streetController.text,streetTwoController.text,houseController.text,floorController.text,jaddaController.text,appartmentController.text,deliveryController.text).then((onValue){
//                            isLoading.add(false);
//                            showDialog(
//                              context: context,
//                              builder: (BuildContext context) {
//                                return AlertDialog(
//                                  title: Text(onValue.message),
//                                );
//                              },
//                            );
//                          });

                          print(
                              "locator<DrobDownBloc>().currentDrobDownvalue ${locator<EditDrobDownBloc>().currentDrobDownvalue}");

                          if (locator<EditDrobDownBloc>()
                                      .currentDrobDownvalue ==
                                  null ||
                              blockController.text.length < 1 ||
                              streetController.text.length < 1 ||
                              streetTwoController.text.length < 1 ||
                              houseController.text.length < 1 ||
                              floorController.text.length < 1 ||
                              jaddaController.text.length < 1) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(AppLocalizations.of(context)
                                      .translate('fill_required_fileds')),
                                );
                              },
                            );
                          } else {
                            isLoading.add(true);
                            EditAddressRepo.postEditAddressData(
                                    locator<EditDrobDownBloc>()
                                                .currentDrobDownvalue ==
                                            null
                                        ? ""
                                        : locator<EditDrobDownBloc>()
                                            .currentDrobDownvalue,
                                    blockController.text,
                                    streetController.text,
                                    streetTwoController.text,
                                    houseController.text,
                                    floorController.text,
                                    jaddaController.text,
                                    appartmentController.text,
                                    deliveryController.text,
                                    widget.modelData.data.address.id)
                                .then((onValue) {
                              isLoading.add(false);
                              // showDialog(
                              //   context: context,
                              //   builder: (BuildContext context) {
                              //     return AlertDialog(
                              //       title: Text(onValue.message),
                              //     );
                              //   },
                              // );
                              locator<AddressesManager>().getData();
                              Fluttertoast.showToast(
                                msg: onValue.message,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: Colors.black.withOpacity(0.6),
                                textColor: Colors.white,
                                fontSize: 14.0,
                              );
                              Navigator.of(context).pop();
                            });
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
              isLoading.value == true
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                          child: Container(
//                      color: mainColor,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )),
                    )
                  : Container(),
            ],
          ),

//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
////            Center(
////              child: Card(
////                elevation: 5,
////                child: Container(
////                  width: MediaQuery.of(context).size.width * 0.90,
////                  height: 60,
////                  child: Center(
////                    child: Text(
////                      AppLocalizations.of(context).translate('newAddress_str'),
////                      style: TextStyle(
////                        color: Colors.teal.shade900,
////                        fontSize: 25,
////                        fontWeight: FontWeight.bold,
////                        fontFamily: locator<PrefsService>().appLanguage == 'en'
////                            ? 'en'
////                            : 'ar',
////                      ),
////                    ),
////                  ),
////                ),
////              ),
////            ),
//          Center(
//            child: Container(),
//          ),
//            Expanded(
//              child: Container(
//                width: MediaQuery.of(context).size.width * 0.9,
//                height: MediaQuery.of(context).size.height,
//                child: ,
//              ),
//            ),
//          ],
//        ),
//        bottomNavigationBar: ListTile(
//          title: ,
//        ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    blockController.dispose();
    streetController.dispose();
    streetTwoController.dispose();
    houseController.dispose();
    floorController.dispose();
    jaddaController.dispose();
    appartmentController.dispose();
    deliveryController.dispose();
    isLoading.close();
    super.dispose();
  }
}

//class EditAddressScreen extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MainBackground(
//      height: MediaQuery.of(context).size.height * 0.3,
//      child: Scaffold(
//        backgroundColor: Colors.transparent,
//        appBar: AppBar(
//          elevation: 0.0,
//          backgroundColor: Colors.transparent,
//          leading: InkWell(
//            onTap: () {
//              Navigator.of(context).pop();
//            },
//            child: Row(
//              mainAxisSize: MainAxisSize.min,
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Icon(
//                  Icons.arrow_back_ios,
//                  size: 15,
//                ),
//                Text(
//                  AppLocalizations.of(context).translate('back_str'),
//                  style: TextStyle(
//                      fontFamily: locator<PrefsService>().appLanguage == 'en'
//                          ? 'en'
//                          : 'ar'),
//                ),
//              ],
//            ),
//          ),
//        ),
//        body: Column(
//          children: <Widget>[
//            Center(
//              child: Card(
//                elevation: 5,
//                child: Container(
//                  width: MediaQuery.of(context).size.width * 0.90,
//                  height: 60,
//                  child: Center(
//                    child: Text(
//                      AppLocalizations.of(context).translate('editAddress_str'),
//                      style: TextStyle(
//                        color: Colors.teal.shade900,
//                        fontSize: 25,
//                        fontWeight: FontWeight.bold,
//                        fontFamily: locator<PrefsService>().appLanguage == 'en'
//                            ? 'en'
//                            : 'ar',
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//            ),
//            Expanded(
//              child: Container(
//                width: MediaQuery.of(context).size.width * 0.9,
//                height: MediaQuery.of(context).size.height,
//                child: Card(
//                  elevation: 5,
//                  child: SingleChildScrollView(
//                    child: Column(
//                      children: <Widget>[
//                        Card(
//                          color: Colors.grey[200],
////                        elevation: 5,
//                          child: Container(
//                            padding: EdgeInsets.all(4),
//                            width: MediaQuery.of(context).size.width * 0.9,
//                            height: 60,
//                            child: Align(
//                              alignment:
//                                  locator<PrefsService>().appLanguage == 'en'
//                                      ? Alignment.centerLeft
//                                      : Alignment.centerRight,
//                              child: Text(
//                                AppLocalizations.of(context)
//                                    .translate('Kuwait_str'),
//                                style: TextStyle(
//                                  color: Colors.teal.shade900,
////                              fontSize: 25,
//                                  fontWeight: FontWeight.bold,
//                                  fontFamily:
//                                      locator<PrefsService>().appLanguage ==
//                                              'en'
//                                          ? 'en'
//                                          : 'ar',
//                                ),
//                              ),
//                            ),
//                          ),
//                        ),
//                        CityDropdown(),
//                        Container(
//                          padding: EdgeInsets.all(4),
//                          // width: MediaQuery.of(context).size.width * 0.8,
//                          // height: 60,
//                          child: Row(
//                            // mainAxisSize: MainAxisSize.max,
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            children: <Widget>[
//                              Expanded(
//                                flex: 1,
//                                child: TextField(
//                                  decoration: InputDecoration(
//                                      filled: true,
//                                      border: InputBorder.none,
//                                      enabledBorder: OutlineInputBorder(
//                                        borderSide: BorderSide(
//                                            color: Colors.transparent),
//                                        borderRadius: const BorderRadius.all(
//                                          const Radius.circular(10.0),
//                                        ),
//                                      ),
//                                      hintStyle: TextStyle(
//                                        color: Colors.grey[600],
//                                        fontFamily: locator<PrefsService>()
//                                                    .appLanguage ==
//                                                'en'
//                                            ? 'en'
//                                            : 'ar',
//                                      ),
//                                      hintText: AppLocalizations.of(context)
//                                          .translate('Block_Str'),
//                                      fillColor: Colors.grey[200]),
//                                ),
//                              ),
//                              SizedBox(
//                                width: 5,
//                              ),
//                              Expanded(
//                                flex: 1,
//                                child: TextField(
//                                  decoration: InputDecoration(
//                                      filled: true,
//                                      border: InputBorder.none,
//                                      enabledBorder: OutlineInputBorder(
//                                        borderSide: BorderSide(
//                                            color: Colors.transparent),
//                                        borderRadius: const BorderRadius.all(
//                                          const Radius.circular(10.0),
//                                        ),
//                                      ),
//                                      hintStyle: TextStyle(
//                                        color: Colors.grey[600],
//                                        fontFamily: locator<PrefsService>()
//                                                    .appLanguage ==
//                                                'en'
//                                            ? 'en'
//                                            : 'ar',
//                                      ),
//                                      hintText: AppLocalizations.of(context)
//                                          .translate('Street_str'),
//                                      fillColor: Colors.grey[200]),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                        Container(
//                          padding: EdgeInsets.all(4),
//                          child: TextField(
//                            decoration: InputDecoration(
//                                filled: true,
//                                border: InputBorder.none,
//                                enabledBorder: OutlineInputBorder(
//                                  borderSide:
//                                      BorderSide(color: Colors.transparent),
//                                  borderRadius: const BorderRadius.all(
//                                    const Radius.circular(10.0),
//                                  ),
//                                ),
//                                hintStyle: TextStyle(
//                                  color: Colors.grey[600],
//                                  fontFamily:
//                                      locator<PrefsService>().appLanguage ==
//                                              'en'
//                                          ? 'en'
//                                          : 'ar',
//                                ),
//                                hintText: AppLocalizations.of(context)
//                                    .translate('Street_two_str'),
//                                fillColor: Colors.grey[200]),
//                          ),
//                        ),
//                        Container(
//                          padding: EdgeInsets.all(4),
//                          child: TextField(
//                            decoration: InputDecoration(
//                                filled: true,
//                                border: InputBorder.none,
//                                enabledBorder: OutlineInputBorder(
//                                  borderSide:
//                                      BorderSide(color: Colors.transparent),
//                                  borderRadius: const BorderRadius.all(
//                                    const Radius.circular(10.0),
//                                  ),
//                                ),
//                                hintStyle: TextStyle(
//                                  color: Colors.grey[600],
//                                  fontFamily:
//                                      locator<PrefsService>().appLanguage ==
//                                              'en'
//                                          ? 'en'
//                                          : 'ar',
//                                ),
//                                hintText: AppLocalizations.of(context)
//                                    .translate('House_building_str'),
//                                fillColor: Colors.grey[200]),
//                          ),
//                        ),
//                        Container(
//                          padding: EdgeInsets.all(4),
//                          // width: MediaQuery.of(context).size.width * 0.8,
//                          // height: 60,
//                          child: Row(
//                            // mainAxisSize: MainAxisSize.max,
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            children: <Widget>[
//                              Expanded(
//                                flex: 1,
//                                child: TextField(
//                                  decoration: InputDecoration(
//                                      filled: true,
//                                      border: InputBorder.none,
//                                      enabledBorder: OutlineInputBorder(
//                                        borderSide: BorderSide(
//                                            color: Colors.transparent),
//                                        borderRadius: const BorderRadius.all(
//                                          const Radius.circular(10.0),
//                                        ),
//                                      ),
//                                      hintStyle: TextStyle(
//                                        color: Colors.grey[600],
//                                        fontFamily: locator<PrefsService>()
//                                                    .appLanguage ==
//                                                'en'
//                                            ? 'en'
//                                            : 'ar',
//                                      ),
//                                      hintText: AppLocalizations.of(context)
//                                          .translate('Floor_Str'),
//                                      fillColor: Colors.grey[200]),
//                                ),
//                              ),
//                              SizedBox(
//                                width: 5,
//                              ),
//                              Expanded(
//                                flex: 1,
//                                child: TextField(
//                                  decoration: InputDecoration(
//                                      filled: true,
//                                      border: InputBorder.none,
//                                      enabledBorder: OutlineInputBorder(
//                                        borderSide: BorderSide(
//                                            color: Colors.transparent),
//                                        borderRadius: const BorderRadius.all(
//                                          const Radius.circular(10.0),
//                                        ),
//                                      ),
//                                      hintStyle: TextStyle(
//                                        color: Colors.grey[600],
//                                        fontFamily: locator<PrefsService>()
//                                                    .appLanguage ==
//                                                'en'
//                                            ? 'en'
//                                            : 'ar',
//                                      ),
//                                      hintText: AppLocalizations.of(context)
//                                          .translate('Jadda_str'),
//                                      fillColor: Colors.grey[200]),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                        Container(
//                          padding: EdgeInsets.all(4),
//                          child: TextField(
//                            decoration: InputDecoration(
//                                suffixText: AppLocalizations.of(context)
//                                    .translate('optional_Str'),
//                                suffixStyle: TextStyle(
//                                  fontFamily:
//                                      locator<PrefsService>().appLanguage ==
//                                              'en'
//                                          ? 'en'
//                                          : 'ar',
//                                ),
//                                filled: true,
//                                border: InputBorder.none,
//                                enabledBorder: OutlineInputBorder(
//                                  borderSide:
//                                      BorderSide(color: Colors.transparent),
//                                  borderRadius: const BorderRadius.all(
//                                    const Radius.circular(10.0),
//                                  ),
//                                ),
//                                hintStyle: TextStyle(
//                                  color: Colors.grey[600],
//                                  fontFamily:
//                                      locator<PrefsService>().appLanguage ==
//                                              'en'
//                                          ? 'en'
//                                          : 'ar',
//                                ),
//                                hintText: AppLocalizations.of(context)
//                                    .translate('Apartment_Office_name'),
//                                fillColor: Colors.grey[200]),
//                          ),
//                        ),
//                        Container(
//                          padding: EdgeInsets.all(4),
//                          child: TextField(
//                            decoration: InputDecoration(
//                                suffixText: AppLocalizations.of(context)
//                                    .translate('optional_Str'),
//                                suffixStyle: TextStyle(
//                                  fontFamily:
//                                      locator<PrefsService>().appLanguage ==
//                                              'en'
//                                          ? 'en'
//                                          : 'ar',
//                                ),
//                                filled: true,
//                                border: InputBorder.none,
//                                enabledBorder: OutlineInputBorder(
//                                  borderSide:
//                                      BorderSide(color: Colors.transparent),
//                                  borderRadius: const BorderRadius.all(
//                                    const Radius.circular(10.0),
//                                  ),
//                                ),
//                                hintStyle: TextStyle(
//                                  color: Colors.grey[600],
//                                  fontFamily:
//                                      locator<PrefsService>().appLanguage ==
//                                              'en'
//                                          ? 'en'
//                                          : 'ar',
//                                ),
//                                hintText: AppLocalizations.of(context)
//                                    .translate('Delivery_instructions'),
//                                fillColor: Colors.grey[200]),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              ),
//            ),
//          ],
//        ),
//        bottomNavigationBar: ListTile(
//          title: ButtonTheme(
//            height: 45,
//            minWidth: MediaQuery.of(context).size.width * 0.8,
//            child: RaisedButton(
//              color: Colors.teal.shade900,
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(5.0),
//                side: BorderSide(color: Colors.white24),
//              ),
//              child: Text(
//                AppLocalizations.of(context).translate('saveThisAddress_str'),
//                style: TextStyle(
//                  color: Colors.white70,
//                  fontFamily:
//                      locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar',
//                ),
//              ),
//              onPressed: () {},
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
