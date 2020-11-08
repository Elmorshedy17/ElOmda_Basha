import 'package:flutter/material.dart';
import 'package:momentoo/features/address_book/addressBook_manager.dart';
import 'package:momentoo/features/address_book/addressBook_model.dart';
import 'package:momentoo/features/checkout/delivery_fee/delivery_fee_manager.dart';
import 'package:momentoo/features/checkout/delivery_fee/delivery_fee_repo.dart';
import 'package:momentoo/features/checkout/delivery_fee/delivery_fee_request.dart';
import 'package:momentoo/features/new_address/_repo.dart';
import 'package:momentoo/features/new_address/addAddressValidation_manager.dart';
import 'package:momentoo/features/new_address/cityDropdown.dart';
import 'package:momentoo/features/new_address/dropdown_data.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/network_sensitive.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:rxdart/rxdart.dart';

class NewAddressScreen extends StatefulWidget {
  final bool isComeFromCheckoutScreen;
  final Country country;
  final List<Cities> cities;
  NewAddressScreen(
      {@required this.country,
      @required this.cities,
      this.isComeFromCheckoutScreen = false});

  @override
  _NewAddressScreenState createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends State<NewAddressScreen> {
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

  final validationManager = locator<AddAddressValidationManager>();
  @override
  void initState() {
    super.initState();
    locator<DeliveryFeeManager>().inCityId.add('');
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
              AppLocalizations.of(context).translate('newAddress_str'),
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
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(15.0),
//          padding: EdgeInsets.all(15.0),
                    child: Column(
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
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 60,
                                      child: Align(
                                        alignment: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? Alignment.centerLeft
                                            : Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            widget.country.name,
//                                  AppLocalizations.of(context)
//                                      .translate('Kuwait_str'),
                                            style: TextStyle(
                                              color: Colors.teal.shade900,
//                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              fontFamily:
                                                  locator<PrefsService>()
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
                                  CityDropdown(),
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    // width: MediaQuery.of(context).size.width * 0.8,
                                    // height: 60,
                                    child: Row(
                                      // mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: StreamBuilder(
                                              stream: validationManager.block$,
                                              builder: (context, snapshot) {
                                                return TextField(
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  focusNode: blockFocus,
                                                  onSubmitted: (v) {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            streetFocus);
                                                  },
                                                  onChanged: (value) {
                                                    validationManager.inblock
                                                        .add(value);
                                                  },
                                                  controller: blockController,
                                                  decoration: InputDecoration(
                                                      errorText: snapshot.error,
                                                      filled: true,
                                                      border: InputBorder.none,
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          const Radius.circular(
                                                              10.0),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          const Radius.circular(
                                                              10.0),
                                                        ),
                                                      ),
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          const Radius.circular(
                                                              10.0),
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
                                                          AppLocalizations.of(
                                                                  context)
                                                              .translate(
                                                                  'Block_Str'),
                                                      fillColor:
                                                          Colors.grey[200]),
                                                );
                                              }),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: StreamBuilder(
                                              stream: validationManager.street$,
                                              builder: (context, snapshot) {
                                                return TextField(
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  focusNode: streetFocus,
                                                  onSubmitted: (v) {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            streetTwoFocus);
                                                  },
                                                  controller: streetController,
                                                  onChanged: (value) {
                                                    validationManager.instreet
                                                        .add(value);
                                                  },
                                                  decoration: InputDecoration(
                                                      errorText: snapshot.error,
                                                      filled: true,
                                                      border: InputBorder.none,
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          const Radius.circular(
                                                              10.0),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          const Radius.circular(
                                                              10.0),
                                                        ),
                                                      ),
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          const Radius.circular(
                                                              10.0),
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
                                                          AppLocalizations.of(
                                                                  context)
                                                              .translate(
                                                                  'Street_str'),
                                                      fillColor:
                                                          Colors.grey[200]),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    child: StreamBuilder(
                                        stream: validationManager.streetTwo$,
                                        builder: (context, snapshot) {
                                          return TextField(
                                            textInputAction:
                                                TextInputAction.next,
                                            focusNode: streetTwoFocus,
                                            onSubmitted: (v) {
                                              FocusScope.of(context)
                                                  .requestFocus(houseFocus);
                                            },
                                            controller: streetTwoController,
                                            onChanged: (value) {
                                              validationManager.instreetTwo
                                                  .add(value);
                                            },
                                            decoration: InputDecoration(
                                                errorText: snapshot.error,
                                                filled: true,
                                                border: InputBorder.none,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    const Radius.circular(10.0),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    const Radius.circular(10.0),
                                                  ),
                                                ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent),
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
                                                        .translate(
                                                            'Street_two_str'),
                                                fillColor: Colors.grey[200]),
                                          );
                                        }),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    child: StreamBuilder(
                                        stream: validationManager.house$,
                                        builder: (context, snapshot) {
                                          return TextField(
                                            textInputAction:
                                                TextInputAction.next,
                                            focusNode: houseFocus,
                                            onSubmitted: (v) {
                                              FocusScope.of(context)
                                                  .requestFocus(floorFocus);
                                            },
                                            controller: houseController,
                                            onChanged: (value) {
                                              validationManager.inhouse
                                                  .add(value);
                                            },
                                            decoration: InputDecoration(
                                                errorText: snapshot.error,
                                                filled: true,
                                                border: InputBorder.none,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    const Radius.circular(10.0),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    const Radius.circular(10.0),
                                                  ),
                                                ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent),
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
                                                hintText: AppLocalizations.of(
                                                        context)
                                                    .translate(
                                                        'House_building_str'),
                                                fillColor: Colors.grey[200]),
                                          );
                                        }),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    // width: MediaQuery.of(context).size.width * 0.8,
                                    // height: 60,
                                    child: Row(
                                      // mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: StreamBuilder(
                                              stream: validationManager.floor$,
                                              builder: (context, snapshot) {
                                                return TextField(
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  focusNode: floorFocus,
                                                  onSubmitted: (v) {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            jaddaFocus);
                                                  },
                                                  controller: floorController,
                                                  onChanged: (value) {
                                                    validationManager.infloor
                                                        .add(value);
                                                  },
                                                  decoration: InputDecoration(
                                                      errorText: snapshot.error,
                                                      filled: true,
                                                      border: InputBorder.none,
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          const Radius.circular(
                                                              10.0),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          const Radius.circular(
                                                              10.0),
                                                        ),
                                                      ),
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          const Radius.circular(
                                                              10.0),
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
                                                          AppLocalizations.of(
                                                                  context)
                                                              .translate(
                                                                  'Floor_Str'),
                                                      fillColor:
                                                          Colors.grey[200]),
                                                );
                                              }),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: StreamBuilder(
                                              stream: validationManager.jadda$,
                                              builder: (context, snapshot) {
                                                return TextField(
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  focusNode: jaddaFocus,
                                                  onSubmitted: (v) {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            apartmentFocus);
                                                  },
                                                  controller: jaddaController,
                                                  onChanged: (value) {
                                                    validationManager.injadda
                                                        .add(value);
                                                  },
                                                  decoration: InputDecoration(
                                                      errorText: snapshot.error,
                                                      filled: true,
                                                      border: InputBorder.none,
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          const Radius.circular(
                                                              10.0),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          const Radius.circular(
                                                              10.0),
                                                        ),
                                                      ),
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          const Radius.circular(
                                                              10.0),
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
                                                          AppLocalizations.of(
                                                                  context)
                                                              .translate(
                                                                  'Jadda_str'),
                                                      fillColor:
                                                          Colors.grey[200]),
                                                );
                                              }),
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
                                          suffixText:
                                              AppLocalizations.of(context)
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
                                            fontFamily: locator<PrefsService>()
                                                        .appLanguage ==
                                                    'en'
                                                ? 'en'
                                                : 'ar',
                                          ),
                                          hintText: AppLocalizations.of(context)
                                              .translate(
                                                  'Apartment_Office_name'),
                                          fillColor: Colors.grey[200]),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    child: TextField(
                                      textInputAction: TextInputAction.done,
                                      focusNode: instructiosFocus,
                                      controller: deliveryController,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                          suffixText:
                                              AppLocalizations.of(context)
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
                                            fontFamily: locator<PrefsService>()
                                                        .appLanguage ==
                                                    'en'
                                                ? 'en'
                                                : 'ar',
                                          ),
                                          hintText: AppLocalizations.of(context)
                                              .translate(
                                                  'Delivery_instructions'),
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
                        StreamBuilder(
                            stream: validationManager.isFormValid$,
                            builder: (context, snapshot) {
                              return ButtonTheme(
                                height: 55,
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.8,
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
                                          locator<PrefsService>().appLanguage ==
                                                  'en'
                                              ? 'en'
                                              : 'ar',
                                    ),
                                  ),
                                  onPressed: snapshot.hasData
                                      ? () {
                                          isLoading.add(true);
//                          NewAddressRepo.postAddNewAddressData(locator<DrobDownBloc>().currentDrobDownvalue ==  null ? "" : locator<DrobDownBloc>().currentDrobDownvalue ,blockController.text,streetController.text,streetTwoController.text,houseController.text,floorController.text,jaddaController.text,appartmentController.text,deliveryController.text).then((onValue){

                                          print(
                                              "locator<DrobDownBloc>().currentDrobDownvalue ${locator<DrobDownBloc>().currentDrobDownvalue}");

                                          if (locator<DrobDownBloc>()
                                                      .currentDrobDownvalue ==
                                                  null ||
                                              blockController.text.length ==
                                                  0 ||
                                              streetController.text.length ==
                                                  0 ||
                                              streetTwoController.text.length ==
                                                  0 ||
                                              houseController.text.length ==
                                                  0 ||
                                              floorController.text.length ==
                                                  0 ||
                                              jaddaController.text.length ==
                                                  0) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(AppLocalizations
                                                          .of(context)
                                                      .translate(
                                                          'fill_required_fileds')),
                                                );
                                              },
                                            );
                                          } else {
                                            isLoading.add(true);
                                            NewAddressRepo.postAddNewAddressData(
                                                    locator<DrobDownBloc>()
                                                                .currentDrobDownvalue ==
                                                            null
                                                        ? ""
                                                        : locator<
                                                                DrobDownBloc>()
                                                            .currentDrobDownvalue,
                                                    blockController.text,
                                                    streetController.text,
                                                    streetTwoController.text,
                                                    houseController.text,
                                                    floorController.text,
                                                    jaddaController.text,
                                                    appartmentController.text,
                                                    deliveryController.text)
                                                .then((onValue) {
                                              isLoading.add(false);
                                              if (onValue.status == 1) {
                                                locator<AddressesManager>()
                                                    .getData();
                                                Addresses newAddress;
                                                if (widget
                                                    .isComeFromCheckoutScreen) {
                                                  DeliveryFeeRequest
                                                      deliveryFeeRequest =
                                                      // DeliveryFeeRequest()
                                                      //   ..sellerId = locator<
                                                      //           DeliveryFeeManager>()
                                                      //       .sellerIdValue
                                                      //   ..cityId = locator<
                                                      //           DeliveryFeeManager>()
                                                      //       .cityIdValue;
                                                      DeliveryFeeRequest(
                                                          sellerId: locator<
                                                                  DeliveryFeeManager>()
                                                              .sellerIdValue,
                                                          cityId: locator<
                                                                  DeliveryFeeManager>()
                                                              .cityIdValue);
                                                  DeliveryFeeRepo.apiPost(
                                                          deliveryFeeRequest)
                                                      .then((value) {
                                                    if (value.status == 1) {
                                                      newAddress = onValue
                                                          .data.addresses.last;
                                                      newAddress
                                                        ..deliveryFee = value
                                                            .data.deliveryFee;
                                                      Navigator.pop(
                                                          context, newAddress);
                                                    }
                                                  });
                                                } else {
                                                  Navigator.pop(context,
                                                      onValue.data.addresses);
                                                }
                                              } else {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title:
                                                          Text(onValue.message),
                                                    );
                                                  },
                                                );
                                              }
                                            });
                                          }
                                        }
                                      : null,
                                ),
                              );
                            })
                      ],
                    ),
                  ),
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
