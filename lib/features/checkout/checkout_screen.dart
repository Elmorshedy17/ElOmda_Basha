import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:momentoo/features/address_book/addressBook_model.dart';
import 'package:momentoo/features/checkout/checkout_manager.dart';
import 'package:momentoo/features/checkout/checkout_request/asUser_request.dart';
import 'package:momentoo/features/checkout/checkout_request/asVisitor_request.dart';
import 'package:momentoo/features/checkout/checkout_validation.dart';
import 'package:momentoo/features/checkout/coupon/coupon_manger.dart';
import 'package:momentoo/features/checkout/coupon/coupon_request.dart';
import 'package:momentoo/features/checkout/paymentGateway/PaymentGateway.dart';
import 'package:momentoo/features/new_address/dropdown_data.dart';
import 'package:momentoo/features/new_address/newAddress_screen.dart';
import 'package:momentoo/features/shopping_cart/cartActions_model.dart'
    as cartActions;
import 'package:momentoo/shared/helper/customNotification_widget.dart';
import 'package:momentoo/shared/helper/custom_bottomNavigation.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/network_sensitive.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:rxdart/rxdart.dart';

class CheckOutScreenArguments {
  final double finalPrice;
  final cartActions.Seller seller;
  final List<Addresses> addresses;
  final List<cartActions.Products> products;
  final List<Cities> cities;
  final Country country;

  CheckOutScreenArguments({
    @required this.seller,
    @required this.addresses,
    @required this.products,
    @required this.cities,
    @required this.finalPrice,
    @required this.country,
  });
}

class CheckOutScreen extends StatefulWidget {
  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  BehaviorSubject addressesBehaviorSubject = BehaviorSubject();
  BehaviorSubject cityBehaviorSubject = BehaviorSubject();

  CheckoutValidationManager validation = locator<CheckoutValidationManager>();
  String _mySelection;

  FocusNode firstNameFocusNode = new FocusNode();
  FocusNode lastNameFocusNode = new FocusNode();
  FocusNode phoneNumberFocusNode = new FocusNode();
  FocusNode emailFocusNode = new FocusNode();

  FocusNode blockFocusNode = new FocusNode();
  FocusNode streetFocusNode = new FocusNode();
  FocusNode streetTwoFocusNode = new FocusNode();
  FocusNode houseFocusNode = new FocusNode();
  FocusNode floorFocusNode = new FocusNode();
  FocusNode jaddaFocusNode = new FocusNode();
  FocusNode apartmentFocusNode = new FocusNode();
  FocusNode instructionsFocusNode = new FocusNode();

  bool deliveryChecked = true;
  bool pickUpCheck = false;

  double priceAfterDiscount = 0.0;
  int addressId = -1;
  int cityId = -1;
  String promoCode = '';

  String email = '';
  String block = '';
  String lastName = '';
  String jadda = '';
  String phone = '';
  String flat = '';
  String floor = '';
  String notes = '';
  String street2 = '';
  String street = '';
  String building = '';
  String firstName = '';
  String apartment = '';
  BehaviorSubject isLoading = new BehaviorSubject.seeded(false);

  var returnDataFromNewAddress;

  // A method that launches the SelectionScreen and awaits the
  // result from Navigator.pop.
  _navigateAndRetrieveData(
      BuildContext context, Country country, List<Cities> cities) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
          builder: (context) => NewAddressScreen(
                country: country,
                cities: cities,
              )),
    );

    returnDataFromNewAddress = result;
  }

  @override
  Widget build(BuildContext context) {
    CheckOutScreenArguments args = ModalRoute.of(context).settings.arguments;
    print(args.addresses);
    if (returnDataFromNewAddress != null) {
//      args.addresses.add(returnDataFromNewAddress);

    }
    return NetworkSensitive(
      child: StreamBuilder<Object>(
          stream: isLoading.stream,
          builder: (context, isLoadingSnapshot) {
            return Stack(
              children: <Widget>[
                MainBackground(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      centerTitle: true,
                      title: Text(
                        AppLocalizations.of(context).translate('Checkout_str'),
                        style: TextStyle(
                            fontFamily:
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                            color: Colors.white),
                      ),
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
                              AppLocalizations.of(context)
                                  .translate('back_str'),
                              style: TextStyle(
                                fontFamily:
                                    locator<PrefsService>().appLanguage == 'en'
                                        ? 'en'
                                        : 'ar',
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        NotificationWidget(
                          onPressedNotifications: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            Navigator.of(context)
                                .pushNamed('/notificationsScreen');
                            locator<PrefsService>().notificationFlag = false;
                          },
                        )
                      ],
                    ),
                    body: Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 1.0),
                        decoration: new BoxDecoration(
                          borderRadius:
                              new BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Container(
                          child: ListView(
                            children: <Widget>[
                              Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: args.products.length,
                                  separatorBuilder: (_, index) => Divider(
                                    indent: 15,
                                    endIndent: 15,
                                    height: 1,
                                  ),
                                  itemBuilder: (_, index) => Container(
                                    height: 100,
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          height: 100.0,
                                          width: 100.0,
                                          child: Image.network(
                                            args.products[index].image,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 8),
                                            title: Text(
                                              '${args.products[index].name}',
                                              style: TextStyle(
                                                fontFamily:
                                                    locator<PrefsService>()
                                                                .appLanguage ==
                                                            'en'
                                                        ? 'en'
                                                        : 'ar',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            subtitle: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                // Text('options'),
                                                Text(
                                                  '${args.products[index].price} ${args.products[index].currency}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        locator<PrefsService>()
                                                                    .appLanguage ==
                                                                'en'
                                                            ? 'en'
                                                            : 'ar',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 20.0,
                              ),

                              // Delivery & pickup
                              Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(30.0),
                                  child: Center(
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                deliveryChecked = false;
                                                pickUpCheck = true;
                                              });
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  AppLocalizations.of(context)
                                                      .translate('PickUp_str'),
                                                  style: TextStyle(
                                                      fontFamily:
                                                          locator<PrefsService>()
                                                                      .appLanguage ==
                                                                  'en'
                                                              ? 'en'
                                                              : 'ar',
                                                      color: pickUpCheck == true
                                                          ? Colors.black
                                                              .withOpacity(.7)
                                                          : Colors.black
                                                              .withOpacity(.3),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 20.0,
                                                ),
                                                pickUpCheck == true
                                                    ? Container(
                                                        height: 40.0,
                                                        width: 40.0,
                                                        decoration:
                                                            new BoxDecoration(
                                                          color: Colors
                                                              .teal.shade800,
                                                          borderRadius:
                                                              new BorderRadius
                                                                  .all(
                                                            Radius.circular(
                                                                50.0),
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.check,
                                                            size: 28,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 40.0,
                                                        width: 40.0,
                                                        decoration:
                                                            new BoxDecoration(
                                                          color: Colors.grey
                                                              .withOpacity(.7),
                                                          borderRadius:
                                                              new BorderRadius
                                                                  .all(
                                                            Radius.circular(
                                                                50.0),
                                                          ),
                                                        ),
                                                      )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                deliveryChecked = true;
                                                pickUpCheck = false;
                                              });
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'DeliveryCheck_str'),
                                                  style: TextStyle(
                                                      fontFamily:
                                                          locator<PrefsService>()
                                                                      .appLanguage ==
                                                                  'en'
                                                              ? 'en'
                                                              : 'ar',
                                                      color: deliveryChecked ==
                                                              true
                                                          ? Colors.black
                                                              .withOpacity(.7)
                                                          : Colors.black
                                                              .withOpacity(.3),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 20.0,
                                                ),
                                                deliveryChecked == true
                                                    ? Container(
                                                        height: 40.0,
                                                        width: 40.0,
                                                        decoration:
                                                            new BoxDecoration(
                                                          color: Colors
                                                              .teal.shade800,
                                                          borderRadius:
                                                              new BorderRadius
                                                                  .all(
                                                            Radius.circular(
                                                                50.0),
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.check,
                                                            size: 28,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 40.0,
                                                        width: 40.0,
                                                        decoration:
                                                            new BoxDecoration(
                                                          color: Colors.grey
                                                              .withOpacity(.7),
                                                          borderRadius:
                                                              new BorderRadius
                                                                  .all(
                                                            Radius.circular(
                                                                50.0),
                                                          ),
                                                        ),
                                                      )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 20.0,
                              ),

                              locator<PrefsService>().userObj != null
                                  ? pickUpCheck == false
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Card(
                                              elevation: 4.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: FormField(
                                                builder:
                                                    (FormFieldState state) {
                                                  return DropdownButtonHideUnderline(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        new InputDecorator(
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .transparent),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                const Radius
                                                                        .circular(
                                                                    10.0),
                                                              ),
                                                            ),
                                                            filled: true,
// hintText: 'Choose City',
                                                            hintText: AppLocalizations
                                                                    .of(context)
                                                                .translate(
                                                                    'selectAddress_str'),
                                                            hintStyle:
                                                                TextStyle(
                                                              fontFamily:
                                                                  locator<PrefsService>()
                                                                              .appLanguage ==
                                                                          'en'
                                                                      ? 'en'
                                                                      : 'ar',
                                                            ),
                                                          ),
                                                          isEmpty:
                                                              _mySelection ==
                                                                  null,
                                                          child: DropdownButton(
                                                            isDense: true,
                                                            items: returnDataFromNewAddress ==
                                                                    null
                                                                ? args.addresses
                                                                    .map<DropdownMenuItem<String>>(
                                                                        (item) {
                                                                    return new DropdownMenuItem(
                                                                      child: new Text(
                                                                          item.title),
                                                                      value: item
                                                                          .id
                                                                          .toString(),
                                                                    );
                                                                  }).toList()
                                                                : returnDataFromNewAddress
                                                                    .map<DropdownMenuItem<String>>(
                                                                        (item) {
                                                                    return new DropdownMenuItem(
                                                                      child: new Text(
                                                                          item.title),
                                                                      value: item
                                                                          .id
                                                                          .toString(),
                                                                    );
                                                                  }).toList(),
                                                            onChanged:
                                                                (newVal) {
                                                              addressId =
                                                                  int.parse(
                                                                      newVal);
                                                              setState(() {
                                                                _mySelection =
                                                                    newVal;
                                                              });
                                                              locator<DrobDownBloc>()
                                                                  .DrobDownvalueSink
                                                                  .add(newVal);
                                                            },
                                                            value: _mySelection,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: RaisedButton(
                                                  color: Colors.teal.shade900,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(10.0),
                                                      side: BorderSide(
                                                        color: Colors
                                                            .teal.shade900,
                                                      )),
                                                  child: Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                            "NewAddress_str"),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            locator<PrefsService>()
                                                                        .appLanguage ==
                                                                    'en'
                                                                ? 'en'
                                                                : 'ar',
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    locator<DrobDownBloc>()
                                                        .DrobDownBlocSink
                                                        .add(args.cities);
                                                    _navigateAndRetrieveData(
                                                        context,
                                                        args.country,
                                                        args.cities);
//                                                  Navigator.push(
//                                                    context,
//                                                    MaterialPageRoute(
//                                                        builder: (context) =>
//                                                            NewAddressScreen(
//                                                              country:
//                                                                  args.country,
//                                                              cities:
//                                                                  args.cities,
//                                                            )),
//                                                  );
                                                  }),
                                            )
                                          ],
                                        )
                                      : Container()
                                  : Container(),
                              // end Delivery & pickup

                              SizedBox(
                                height: locator<PrefsService>().userObj != null
                                    ? 0
                                    : 20.0,
                              ),

                              // User details
                              locator<PrefsService>().userObj != null
                                  ? Container()
                                  : Card(
                                      elevation: 4.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(15.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'User_details_str'),
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(.7),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            Container(
                                              color: Colors.grey[100],
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15.0),
                                                child: StreamBuilder<Object>(
                                                    stream:
                                                        validation.firstName$,
                                                    builder:
                                                        (context, snapshot) {
                                                      return TextFormField(
                                                        onChanged: (v) {
                                                          firstName = v;
                                                          validation.inFirstName
                                                              .add(v);
                                                        },
                                                        focusNode:
                                                            firstNameFocusNode,
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        onFieldSubmitted:
                                                            (String value) {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  lastNameFocusNode);
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          errorText:
                                                              snapshot.error,
                                                          border:
                                                              InputBorder.none,
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                          hintText: AppLocalizations
                                                                  .of(context)
                                                              .translate(
                                                                  "first_name_str"),
                                                          contentPadding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 14.0,
                                                                  bottom: 8.0,
                                                                  top: 8.0),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            Container(
                                              color: Colors.grey[100],
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15.0),
                                                child: StreamBuilder<Object>(
                                                    stream:
                                                        validation.lastName$,
                                                    builder:
                                                        (context, snapshot) {
                                                      return TextFormField(
                                                        onChanged: (v) {
                                                          lastName = v;
                                                          validation.inLastName
                                                              .add(v);
                                                        },
                                                        focusNode:
                                                            lastNameFocusNode,
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        onFieldSubmitted:
                                                            (String value) {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  phoneNumberFocusNode);
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          errorText:
                                                              snapshot.error,
                                                          border:
                                                              InputBorder.none,
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                          hintText: AppLocalizations
                                                                  .of(context)
                                                              .translate(
                                                                  "last_name_str"),
                                                          contentPadding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 14.0,
                                                                  bottom: 8.0,
                                                                  top: 8.0),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            Container(
                                              color: Colors.grey[100],
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15.0),
                                                child: StreamBuilder<Object>(
                                                    stream: validation.phone$,
                                                    builder:
                                                        (context, snapshot) {
                                                      return TextFormField(
                                                        onChanged: (v) {
                                                          validation.inPhone
                                                              .add(v);
                                                          if (v.length == 8) {
                                                            phone = v;
                                                          }
                                                        },
                                                        keyboardType: TextInputType
                                                            .numberWithOptions(),
                                                        focusNode:
                                                            phoneNumberFocusNode,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        onFieldSubmitted:
                                                            (String value) {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  emailFocusNode);
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          errorText:
                                                              snapshot.error,
                                                          border:
                                                              InputBorder.none,
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                          hintText: AppLocalizations
                                                                  .of(context)
                                                              .translate(
                                                                  "965_phone_number_str"),
                                                          contentPadding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 14.0,
                                                                  bottom: 8.0,
                                                                  top: 8.0),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            Container(
                                              color: Colors.grey[100],
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15.0),
                                                child: StreamBuilder<Object>(
                                                    stream: validation.email$,
                                                    builder:
                                                        (context, snapshot) {
                                                      return TextFormField(
                                                        onChanged: (v) {
                                                          validation.inEmail
                                                              .add(v);
                                                          if (EmailValidator
                                                              .validate(v)) {
                                                            email = v;
                                                          }
                                                        },
                                                        focusNode:
                                                            emailFocusNode,
                                                        keyboardType:
                                                            TextInputType
                                                                .emailAddress,
                                                        decoration:
                                                            InputDecoration(
                                                          errorText:
                                                              snapshot.error,
                                                          border:
                                                              InputBorder.none,
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                          hintText: AppLocalizations
                                                                  .of(context)
                                                              .translate(
                                                                  "email_str"),
                                                          contentPadding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 14.0,
                                                                  bottom: 8.0,
                                                                  top: 8.0),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              // end User details

                              SizedBox(
                                height: locator<PrefsService>().userObj != null
                                    ? 0
                                    : 20.0,
                              ),

                              // User address details
                              locator<PrefsService>().userObj != null
                                  ? Container()
                                  : pickUpCheck == false
                                      ? Card(
                                          elevation: 4.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.all(15.0),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'Address_Details_str'),
                                                      style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(.7),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 8.0,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  color: Colors.grey[100],
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 15.0,
                                                        vertical: 12.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text(
                                                            AppLocalizations.of(
                                                                    context)
                                                                .translate(
                                                                    'Kuwait_str'),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .teal
                                                                    .shade900,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8.0,
                                                ),
                                                FormField(
                                                  builder:
                                                      (FormFieldState state) {
                                                    return DropdownButtonHideUnderline(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          new InputDecorator(
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .transparent),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  const Radius
                                                                          .circular(
                                                                      10.0),
                                                                ),
                                                              ),
                                                              filled: true,
                                                              hintText: AppLocalizations
                                                                      .of(
                                                                          context)
                                                                  .translate(
                                                                      'City_Str'),
                                                              hintStyle:
                                                                  TextStyle(
                                                                fontFamily:
                                                                    locator<PrefsService>().appLanguage ==
                                                                            'en'
                                                                        ? 'en'
                                                                        : 'ar',
                                                              ),
                                                            ),
                                                            isEmpty:
                                                                _mySelection ==
                                                                    null,
                                                            child:
                                                                DropdownButton(
                                                              isDense: true,
                                                              items: args.cities.map<
                                                                  DropdownMenuItem<
                                                                      String>>((item) {
                                                                return new DropdownMenuItem(
                                                                  child: new Text(
                                                                      item.name),
                                                                  value: item.id
                                                                      .toString(),
                                                                );
                                                              }).toList(),
                                                              onChanged:
                                                                  (newVal) {
                                                                addressId =
                                                                    int.parse(
                                                                        newVal);
                                                                setState(() {
                                                                  _mySelection =
                                                                      newVal;
                                                                });
                                                                locator<DrobDownBloc>()
                                                                    .DrobDownvalueSink
                                                                    .add(
                                                                        newVal);
                                                              },
                                                              value:
                                                                  _mySelection,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 8.0,
                                                ),
                                                Container(
                                                  child: Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Container(
                                                            color: Colors
                                                                .grey[100],
                                                            child: StreamBuilder<
                                                                    Object>(
                                                                stream:
                                                                    validation
                                                                        .block$,
                                                                builder: (context,
                                                                    snapshot) {
                                                                  return TextFormField(
                                                                    onChanged:
                                                                        (value) {
                                                                      block =
                                                                          value;
                                                                      validation
                                                                          .inBlock
                                                                          .add(
                                                                              value);
                                                                    },
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    focusNode:
                                                                        blockFocusNode,
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
                                                                    onFieldSubmitted:
                                                                        (String
                                                                            value) {
                                                                      FocusScope.of(
                                                                              context)
                                                                          .requestFocus(
                                                                              streetFocusNode);
                                                                    },
                                                                    decoration:
                                                                        InputDecoration(
                                                                      errorText:
                                                                          snapshot
                                                                              .error,
                                                                      border: InputBorder
                                                                          .none,
                                                                      hintStyle:
                                                                          TextStyle(
                                                                              color: Colors.grey),
                                                                      hintText: AppLocalizations.of(
                                                                              context)
                                                                          .translate(
                                                                              "Block_Str"),
                                                                      contentPadding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              14.0,
                                                                          bottom:
                                                                              8.0,
                                                                          top:
                                                                              8.0),
                                                                    ),
                                                                  );
                                                                }),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 5.0,
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            color: Colors
                                                                .grey[100],
                                                            child: StreamBuilder<
                                                                    Object>(
                                                                stream:
                                                                    validation
                                                                        .street$,
                                                                builder: (context,
                                                                    snapshot) {
                                                                  return TextFormField(
                                                                    onChanged:
                                                                        (v) {
                                                                      street =
                                                                          v;
                                                                      validation
                                                                          .inStreet
                                                                          .add(
                                                                              v);
                                                                    },
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    focusNode:
                                                                        streetFocusNode,
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
                                                                    onFieldSubmitted:
                                                                        (String
                                                                            value) {
                                                                      FocusScope.of(
                                                                              context)
                                                                          .requestFocus(
                                                                              streetTwoFocusNode);
                                                                    },
                                                                    decoration:
                                                                        InputDecoration(
                                                                      errorText:
                                                                          snapshot
                                                                              .error,
                                                                      border: InputBorder
                                                                          .none,
                                                                      hintStyle:
                                                                          TextStyle(
                                                                              color: Colors.grey),
                                                                      hintText: AppLocalizations.of(
                                                                              context)
                                                                          .translate(
                                                                              "Street_str"),
                                                                      contentPadding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              14.0,
                                                                          bottom:
                                                                              8.0,
                                                                          top:
                                                                              8.0),
                                                                    ),
                                                                  );
                                                                }),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8.0,
                                                ),
                                                Container(
                                                  color: Colors.grey[100],
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 15.0),
                                                    child:
                                                        StreamBuilder<Object>(
                                                            stream: validation
                                                                .street2$,
                                                            builder: (context,
                                                                snapshot) {
                                                              return TextFormField(
                                                                onChanged: (v) {
                                                                  street2 = v;
                                                                  validation
                                                                      .inStreet2
                                                                      .add(v);
                                                                },
                                                                focusNode:
                                                                    streetTwoFocusNode,
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .next,
                                                                onFieldSubmitted:
                                                                    (String
                                                                        value) {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .requestFocus(
                                                                          houseFocusNode);
                                                                },
                                                                decoration:
                                                                    InputDecoration(
                                                                  errorText:
                                                                      snapshot
                                                                          .error,
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintStyle: TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                  hintText: AppLocalizations.of(
                                                                          context)
                                                                      .translate(
                                                                          "Street_two_str"),
                                                                  contentPadding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          14.0,
                                                                      bottom:
                                                                          8.0,
                                                                      top: 8.0),
                                                                ),
                                                              );
                                                            }),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8.0,
                                                ),
                                                Container(
                                                  color: Colors.grey[100],
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 15.0),
                                                    child:
                                                        StreamBuilder<Object>(
                                                            stream: validation
                                                                .building$,
                                                            builder: (context,
                                                                snapshot) {
                                                              return TextFormField(
                                                                onChanged: (v) {
                                                                  building = v;
                                                                  validation
                                                                      .iBuilding
                                                                      .add(v);
                                                                },
                                                                focusNode:
                                                                    houseFocusNode,
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .next,
                                                                onFieldSubmitted:
                                                                    (String
                                                                        value) {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .requestFocus(
                                                                          floorFocusNode);
                                                                },
                                                                decoration:
                                                                    InputDecoration(
                                                                  errorText:
                                                                      snapshot
                                                                          .error,
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintStyle: TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                  hintText: AppLocalizations.of(
                                                                          context)
                                                                      .translate(
                                                                          "House_building_str"),
                                                                  contentPadding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          14.0,
                                                                      bottom:
                                                                          8.0,
                                                                      top: 8.0),
                                                                ),
                                                              );
                                                            }),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8.0,
                                                ),
                                                Container(
                                                  child: Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Container(
                                                            color: Colors
                                                                .grey[100],
                                                            child: StreamBuilder<
                                                                    Object>(
                                                                stream:
                                                                    validation
                                                                        .floor$,
                                                                builder: (context,
                                                                    snapshot) {
                                                                  return TextFormField(
                                                                    onChanged:
                                                                        (v) {
                                                                      floor = v;
                                                                      validation
                                                                          .inFloor
                                                                          .add(
                                                                              v);
                                                                    },
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    focusNode:
                                                                        floorFocusNode,
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
                                                                    onFieldSubmitted:
                                                                        (String
                                                                            value) {
                                                                      FocusScope.of(
                                                                              context)
                                                                          .requestFocus(
                                                                              jaddaFocusNode);
                                                                    },
                                                                    decoration:
                                                                        InputDecoration(
                                                                      errorText:
                                                                          snapshot
                                                                              .error,
                                                                      border: InputBorder
                                                                          .none,
                                                                      hintStyle:
                                                                          TextStyle(
                                                                              color: Colors.grey),
                                                                      hintText: AppLocalizations.of(
                                                                              context)
                                                                          .translate(
                                                                              "Floor_Str"),
                                                                      contentPadding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              14.0,
                                                                          bottom:
                                                                              8.0,
                                                                          top:
                                                                              8.0),
                                                                    ),
                                                                  );
                                                                }),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 5.0,
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            color: Colors
                                                                .grey[100],
                                                            child: StreamBuilder<
                                                                    Object>(
                                                                stream:
                                                                    validation
                                                                        .jadda$,
                                                                builder: (context,
                                                                    snapshot) {
                                                                  return TextFormField(
                                                                    onChanged:
                                                                        (v) {
                                                                      jadda = v;
                                                                      validation
                                                                          .inJadda
                                                                          .add(
                                                                              v);
                                                                    },
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    focusNode:
                                                                        jaddaFocusNode,
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
                                                                    onFieldSubmitted:
                                                                        (String
                                                                            value) {
                                                                      FocusScope.of(
                                                                              context)
                                                                          .requestFocus(
                                                                              apartmentFocusNode);
                                                                    },
                                                                    decoration:
                                                                        InputDecoration(
                                                                      errorText:
                                                                          snapshot
                                                                              .error,
                                                                      border: InputBorder
                                                                          .none,
                                                                      hintStyle:
                                                                          TextStyle(
                                                                              color: Colors.grey),
                                                                      hintText: AppLocalizations.of(
                                                                              context)
                                                                          .translate(
                                                                              "Jadda_str"),
                                                                      contentPadding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              14.0,
                                                                          bottom:
                                                                              8.0,
                                                                          top:
                                                                              8.0),
                                                                    ),
                                                                  );
                                                                }),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8.0,
                                                ),
                                                Container(
                                                  color: Colors.grey[100],
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 15.0),
                                                    child: TextFormField(
                                                      onChanged: (v) {
                                                        apartment = v;
                                                      },
                                                      focusNode:
                                                          instructionsFocusNode,
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      decoration:
                                                          InputDecoration(
                                                        suffix: Text(
                                                          "(${AppLocalizations.of(context).translate("optional_Str")})",
                                                        ),
                                                        suffixStyle: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.grey),
                                                        border:
                                                            InputBorder.none,
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey),
                                                        hintText: AppLocalizations
                                                                .of(context)
                                                            .translate(
                                                                "Apartment_Office_name"),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 14.0,
                                                                bottom: 8.0,
                                                                top: 8.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8.0,
                                                ),
                                                Container(
                                                  color: Colors.grey[100],
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 15.0,
                                                        vertical: 8.0),
                                                    child: TextFormField(
                                                      onChanged: (v) {
                                                        notes = v;
                                                      },
                                                      maxLines: 8,
                                                      focusNode:
                                                          phoneNumberFocusNode,
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      onFieldSubmitted:
                                                          (String value) {
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                emailFocusNode);
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        suffix: Text(
                                                          "(${AppLocalizations.of(context).translate("optional_Str")})",
                                                        ),
                                                        suffixStyle: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.grey),
                                                        border:
                                                            InputBorder.none,
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey),
                                                        hintText: AppLocalizations
                                                                .of(context)
                                                            .translate(
                                                                "Delivery_instructions"),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 14.0,
                                                                bottom: 8.0,
                                                                top: 8.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(),
                              // end User address details

                              SizedBox(
                                height: 20.0,
                              ),
                              Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 15.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: TextField(
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              promoCode = value;
                                            }
                                          },
                                          onSubmitted: (value) {
                                            if (value.isNotEmpty) {
                                              promoCode = value;
                                            }
                                          },
                                          textInputAction: TextInputAction.done,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                fontFamily:
                                                    locator<PrefsService>()
                                                                .appLanguage ==
                                                            'en'
                                                        ? 'en'
                                                        : 'ar',
                                                color: Colors.grey),
                                            hintText: AppLocalizations.of(
                                                    context)
                                                .translate("Discount_code_str"),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 14.0,
                                                    bottom: 8.0,
                                                    top: 8.0),
                                          ),
                                        ),
                                      ),
                                      RaisedButton(
                                        onPressed: () async {

                                          if(promoCode == ''){
                                            Fluttertoast.showToast(
                                              msg: locator<PrefsService>().appLanguage == "en" ? 'enter coupon code':' '"أدخل رمز الخصم",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              backgroundColor: Colors.black.withOpacity(0.6),
                                              textColor: Colors.white,
                                              fontSize: 14.0,
                                            );
                                          }else{
                                            isLoading.add(true);
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());

                                            locator<CouponRequest>()
                                              ..sellerId = locator<PrefsService>()
                                                  .cartObj
                                                  .sellerId
                                              ..products = locator<PrefsService>()
                                                  .cartObj
                                                  .products
                                              ..orderType = deliveryChecked
                                                  ? 'delivery'
                                                  : 'pickup'
                                              ..promoCode = promoCode;
                                            // ..promoCode =
                                            //     promoCodeController.value?.text ?? '';

                                            await locator<CouponManager>()
                                                .getFutureData()
                                                .then((value) {
                                              isLoading.add(false);
                                              if (value.status != 0) {
                                                priceAfterDiscount = double.parse(
                                                    value.data.total);
                                              }
                                              showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    elevation: 3,
                                                    // contentPadding: const EdgeInsets.all(8.0),
                                                    content: Container(
                                                      // height: 90,

                                                      padding: EdgeInsets.all(8),
                                                      child: Text(
                                                          '${value.message}'),
                                                    ),
                                                    actions: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 1.0),
                                                        child: ButtonTheme(
                                                          minWidth: 70.0,
                                                          height: 30.0,
                                                          child: RaisedButton(
                                                            shape:
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  25.0),
                                                            ),
                                                            child: Text(
                                                              'OK',
                                                              // AppLocalizations.of(context)
                                                              //     .translate('notNow_str'),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            // color: greyBlue,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            });
                                          }


                                        },
                                        color: Colors.teal.shade900,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(10.0),
                                            side: BorderSide(
                                              color: Colors.teal.shade900,
                                            )),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate("check_str"),
                                          style: TextStyle(
                                              fontFamily:
                                                  locator<PrefsService>()
                                                              .appLanguage ==
                                                          'en'
                                                      ? 'en'
                                                      : 'ar',
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 20.0),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text(
                                          AppLocalizations.of(context)
                                              .translate("total_str"),
                                          style: TextStyle(
                                              fontFamily:
                                                  locator<PrefsService>()
                                                              .appLanguage ==
                                                          'en'
                                                      ? 'en'
                                                      : 'ar',
                                              color: Colors.grey.shade600,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        trailing: Text(
                                          '${args.finalPrice.toStringAsFixed(2)}',
                                          style: TextStyle(
                                              fontFamily:
                                                  locator<PrefsService>()
                                                              .appLanguage ==
                                                          'en'
                                                      ? 'en'
                                                      : 'ar',
                                              color: Colors.grey.shade500,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          AppLocalizations.of(context)
                                              .translate("Discount_str"),
                                          style: TextStyle(
                                              fontFamily:
                                                  locator<PrefsService>()
                                                              .appLanguage ==
                                                          'en'
                                                      ? 'en'
                                                      : 'ar',
                                              color: Colors.grey.shade600,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        trailing: Text(
                                          '${priceAfterDiscount != 0.0 ? (args.finalPrice - priceAfterDiscount).toStringAsFixed(2) : 0.0}',
                                          style: TextStyle(
                                              fontFamily:
                                                  locator<PrefsService>()
                                                              .appLanguage ==
                                                          'en'
                                                      ? 'en'
                                                      : 'ar',
                                              color: Colors.grey.shade500,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                      Divider(
                                        height: 1,
                                      ),
                                      ListTile(
                                        title: Text(
                                          AppLocalizations.of(context)
                                              .translate("subtotal_str"),
                                          style: TextStyle(
                                              fontFamily:
                                                  locator<PrefsService>()
                                                              .appLanguage ==
                                                          'en'
                                                      ? 'en'
                                                      : 'ar',
                                              color: Colors.teal.shade900,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        trailing: Text(
                                          '${priceAfterDiscount == 0.0 ? args.finalPrice.toStringAsFixed(2) : priceAfterDiscount.toStringAsFixed(2)}',
                                          style: TextStyle(
                                              fontFamily:
                                                  locator<PrefsService>()
                                                              .appLanguage ==
                                                          'en'
                                                      ? 'en'
                                                      : 'ar',
                                              color: Colors.teal.shade900,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),

                              ButtonTheme(
                                minWidth: 280.0,
                                height: 55.0,
                                child: RaisedButton(
                                  color: Colors.teal.shade900,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('Pay_now_Str'),
                                    style: TextStyle(
                                        fontFamily: locator<PrefsService>()
                                                    .appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar',
                                        color: Colors.white,
                                        fontSize: 20.0),
                                  ),
                                  onPressed: () async {
                                    if (locator<PrefsService>().userObj !=
                                        null) {
                                      // As User

                                      if (!deliveryChecked ||
                                          (addressId != -1 &&
                                              deliveryChecked)) {
                                        isLoading.add(true);
                                        locator<AsUserRequest>()
                                          ..sellerId = locator<PrefsService>()
                                              .cartObj
                                              .sellerId
                                          ..products = locator<PrefsService>()
                                              .cartObj
                                              .products
                                          ..orderType = deliveryChecked
                                              ? 'delivery'
                                              : 'pickup'
                                          ..promoCode = promoCode
                                          ..addressId = addressId
                                          ..notes = '';

                                        await locator<CheckoutManager>()
                                            .checkoutAsUserFuture()
                                            .then((value) {
                                          isLoading.add(false);
                                          if (value.status != 0) {
                                            Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        PaymentGatewayScreen(
                                                  url: value.data.paymentLink,
                                                ),
                                              ),
                                            );
                                          } else {
                                            checkoutDialog(value.message);
                                          }
                                        });
                                      } else {
                                        checkoutDialog(
                                            'You must choose an address');
                                      }
                                    } else {
                                      // As Visitor
                                      if (firstName.isEmpty) {
                                        showToast(locator<PrefsService>()
                                                    .appLanguage ==
                                                "en"
                                            ? 'Enter first name'
                                            : 'أدخل الإسم الأول');
                                        return;
                                      }
                                      if (lastName.isEmpty) {
                                        showToast(locator<PrefsService>()
                                                    .appLanguage ==
                                                "en"
                                            ? 'Enter last name'
                                            : 'أدخل الأسم الأخير');
                                        return;
                                      }
                                      if (phone.isEmpty) {
                                        showToast(locator<PrefsService>()
                                                    .appLanguage ==
                                                "en"
                                            ? 'Enter phone'
                                            : 'أدخل رقم الهاتف');
                                        return;
                                      }
                                      if (email.isEmpty) {
                                        showToast(locator<PrefsService>()
                                                    .appLanguage ==
                                                "en"
                                            ? 'Enter valid email'
                                            : 'أدخل بريد إلكتروني صحيح');
                                        return;
                                      }
                                      if (deliveryChecked) {
                                        if (addressId == -1) {
                                          showToast(locator<PrefsService>()
                                                      .appLanguage ==
                                                  "en"
                                              ? 'Select city'
                                              : 'اختر مدينة');
                                          return;
                                        }
                                        if (block.isEmpty) {
                                          showToast(locator<PrefsService>()
                                                      .appLanguage ==
                                                  "en"
                                              ? 'Enter block'
                                              : 'أدخل المنطقة');
                                          return;
                                        }
                                        if (street.isEmpty) {
                                          showToast(locator<PrefsService>()
                                                      .appLanguage ==
                                                  "en"
                                              ? 'Enter street'
                                              : 'أدخل الشارع');
                                          return;
                                        }
                                        if (street2.isEmpty) {
                                          showToast(locator<PrefsService>()
                                                      .appLanguage ==
                                                  "en"
                                              ? 'Enter street 2'
                                              : 'أدخل اسم الشارع');
                                          return;
                                        }
                                        if (building.isEmpty) {
                                          showToast(locator<PrefsService>()
                                                      .appLanguage ==
                                                  "en"
                                              ? 'Enter building'
                                              : 'أدخل رقم البناية');
                                          return;
                                        }
                                        if (floor.isEmpty) {
                                          showToast(locator<PrefsService>()
                                                      .appLanguage ==
                                                  "en"
                                              ? 'Enter floor'
                                              : 'أدخل رقم الطابق');
                                          return;
                                        }
                                        if (jadda.isEmpty) {
                                          showToast(locator<PrefsService>()
                                                      .appLanguage ==
                                                  "en"
                                              ? 'Enter jadda'
                                              : 'أدخل الجادة');
                                          return;
                                        }
                                      }

                                      isLoading.add(true);
                                      locator<AsVisitorRequest>()
                                        ..sellerId = locator<PrefsService>()
                                            .cartObj
                                            .sellerId
                                        ..products = locator<PrefsService>()
                                            .cartObj
                                            .products
                                        ..orderType = deliveryChecked
                                            ? 'delivery'
                                            : 'pickup'
                                        ..promoCode = promoCode
                                        ..notes = notes
                                        ..firstName = firstName
                                        ..lastName = lastName
                                        ..phone = phone
                                        ..email = email
                                        ..cityId = addressId
                                        ..block = block
                                        ..street = street
                                        ..street2 = street2
                                        ..building = building
                                        ..floor = floor
                                        ..jadda = jadda
                                        ..flat = apartment;

                                      await locator<CheckoutManager>()
                                          .checkoutAsVisitorFuture()
                                          .then((value) {
                                        isLoading.add(false);
                                        if (value.status != 0) {
                                          Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  PaymentGatewayScreen(
                                                url: value.data.paymentLink,
                                              ),
                                            ),
                                          );
                                        } else {
                                          checkoutDialog(value.message);
                                        }
                                      });
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    bottomNavigationBar: CustomBottomNavigation(),
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
            );
          }),
    );
  }

  checkoutDialog(message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 3,
          // contentPadding: const EdgeInsets.all(8.0),
          content: Container(
            // height: 90,

            padding: EdgeInsets.all(8),
            child: Text('${message}'),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: ButtonTheme(
                minWidth: 70.0,
                height: 30.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                  child: Text(
                    'OK',
                    // AppLocalizations.of(context)
                    //     .translate('notNow_str'),
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  // color: greyBlue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  showToast(message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black.withOpacity(0.6),
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
