import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/all_orders_bloc.dart';
import 'package:medicine/src/blocs/user_id_bloc.dart';
import 'package:medicine/src/blocs/user_type_bloc.dart';
import 'package:medicine/src/views/screens/contact_admin.dart';
import 'package:medicine/src/views/screens/delivery_history.dart';
import 'package:medicine/src/views/screens/delivery_home.dart';
import 'package:medicine/src/views/screens/delivery_money_transfere.dart';
import 'package:medicine/src/views/screens/delivery_products_screen.dart';
import 'package:medicine/src/views/screens/history.dart';
import 'package:medicine/src/views/screens/history_filter.dart';
import 'package:medicine/src/views/screens/home_page.dart';
import 'package:medicine/src/views/screens/login.dart';
import 'package:medicine/src/views/screens/markters_of_supervisor.dart';
import 'package:medicine/src/views/screens/money_transform.dart';
import 'package:medicine/src/views/screens/my_account.dart';
import 'package:medicine/src/views/screens/my_orders.dart';
import 'package:medicine/src/views/screens/points_transfere.dart';
import 'package:medicine/src/views/screens/pre_reg.dart';
import 'package:medicine/src/views/screens/show_cities_delegate.dart';
import 'package:medicine/src/views/screens/show_service.dart';
import 'package:medicine/theme_setting.dart';
//import 'package:auto_size_text/auto_size_text.dart';


var GlobalUserType = locator<PrefsService>().userType == null ? locator<UserTypeBloc>().currentUserType:locator<PrefsService>().userType;


class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.all(15.0),
        color: primaryColor,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 55.0,
            ),
            _myUserProfile(),
            SizedBox(
              height: 40.0,
            ),
            DrawerItem("assets/images/home.png", AppLocalizations.of(context).translate('home_str'), () {

              Navigator.pop(context);
//              Navigator.push(
//                  context,
//                  new MaterialPageRoute(
//                      builder: (BuildContext context) => GlobalUserType!= "delegate"? HomePage(locator<UserIdBloc>().currentUserId.toString()):DeliveyHomePage(locator<UserIdBloc>().currentUserId.toString())));
            }),

            GlobalUserType !="delegate"?   DrawerItem("assets/images/cart.png", AppLocalizations.of(context).translate("My_Orders"), () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => MyOrdersScreen()));

            }):DrawerItem("assets/images/products.png", AppLocalizations.of(context).translate("My_Products"), () {
              Navigator.pop(context);
                   Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => DeliveryProductsScreen(locator<UserIdBloc>().currentUserId.toString())));
            }),







            GlobalUserType !="delegate"?
            DrawerItem("assets/images/history.png", AppLocalizations.of(context).translate("history_str"), () {
              locator<AllOrdersFilterBloc>().allOrdersFilterSink.add("");
              locator<AllOrdersFilterBloc>().clearFilter();
              Navigator.pop(context);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => History()));
            }):DrawerItem("assets/images/history.png", AppLocalizations.of(context).translate("The_Orders_str"), () {
              locator<AllOrdersFilterBloc>().allOrdersFilterSink.add("");
              locator<AllOrdersFilterBloc>().clearFilter();
              Navigator.pop(context);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => DeliveryHistory()));
            }),


            GlobalUserType !="delegate"?
            DrawerItem("assets/images/history.png", AppLocalizations.of(context).translate("history_filter") , () {
              locator<AllOrdersFilterBloc>().clearFilter();
              Navigator.pop(context);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => HistoryFilter()));
            }):Container(),

            GlobalUserType =="delegate"?
            DrawerItem("assets/images/history.png", AppLocalizations.of(context).translate("soled_packages") , () {
              // locator<AllOrdersFilterBloc>().clearFilter();
              Navigator.pop(context);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => ShowServiceScreen()));
            }):Container(),

            DrawerItem("assets/images/profile.png", AppLocalizations.of(context).translate("My_Acount") , () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => MyAccount()));
            }),

            // GlobalUserType !="delegate"?
            DrawerItem("assets/images/cityscape.png", AppLocalizations.of(context).translate("cities_delegates") , () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => ShowCitiesDelegates()));
            }),
            GlobalUserType =="supervisor_marketer"? DrawerItem("assets/images/users.png", AppLocalizations.of(context).translate("Markters_str"), () {
    Navigator.pop(context);
    Navigator.push(
    context,
    new MaterialPageRoute(
    builder: (BuildContext context) => SuperVisorMarkters()));
    }):Container(),
            GlobalUserType =="supervisor_marketer"? DrawerItem("assets/images/pointswhite.png", AppLocalizations.of(context).translate("Points_Transfere_str") , () {

              ApiService.PackagesShow().then((data) => data.key == "1"
                  ?   Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => CarouselWithIndicator(data)))
                  : showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(data.msg),
                  );
                },
              ));


//    Navigator.pop(context);
//
//
//
//    Navigator.push(
//    context,
//    new MaterialPageRoute(
//    builder: (BuildContext context) => CarouselWithIndicator()));
    }):Container(),
            GlobalUserType== "delegate"?  DrawerItem("assets/images/payment_.png",AppLocalizations.of(context).translate("Money_Transfere_str") ,
                () {
                  Navigator.pop(context);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => DeliveryMoneyTransfere()));
            }):DrawerItem("assets/images/payment_.png", AppLocalizations.of(context).translate("Amount_Transfere_Orders_str"),
                    () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => MoneyTransform()));
                }),


            DrawerItem("assets/images/contact.png", AppLocalizations.of(context).translate("Contact_Admin_str"), () {

//              print("locator<PrefsService>().saveUserIdlocator<PrefsService>().saveUserIdlocator<PrefsService>().saveUserIdlocator<PrefsService>().saveUserId${locator<PrefsService>().saveUserId}");

              Navigator.pop(context);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => ContactAdmin()));

            }),
            SizedBox(
              height: 60.0,
            ),
            DrawerItem("assets/images/logout.png", AppLocalizations.of(context).translate("Exit_str"), () {
              locator<PrefsService>().removeSaveUserId();
              locator<PrefsService>().removeUserType();
              locator<PrefsService>().removeNotiCount();
              locator<PrefsService>().clearAllPrefs();
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');

//              ApiService.logout()
//                  .then((data) => data.key == "1"
//                  ?   Navigator.pushReplacement(
//                  context,
//                  new MaterialPageRoute(
//                      builder: (BuildContext context) => PreRegistration()))
//                  : showDialog(
//                context: context,
//                builder: (BuildContext context) {
//                  return AlertDialog(
//                    title: Text(data.msg),
//                  );
//                },
//              ));
              locator<PrefsService>().removeSaveUserId();
              locator<PrefsService>().removeUserType();
            }),
          ],
        ),
      ),
    );
  }

  Widget _myUserProfile() {
    return locator<PrefsService>().userImageProfile == null? FutureBuilder(
      future:  ApiService.UserProfile(),
      builder: (context, snapshot) {

        if(snapshot.hasData){
          locator<PrefsService>().userImageProfile = snapshot.data.data.avatar;
          locator<PrefsService>().userNameProfile = snapshot.data.data.firstName;
          locator<PrefsService>().userEmailProfile = snapshot.data.data.email;
          locator<PrefsService>().userLastName = snapshot.data.data.lastName;
          locator<PrefsService>().userPhoneProfile = snapshot.data.data.phone;
          locator<PrefsService>().userPhoneCodeProfile = snapshot.data.data.phoneCode;
          locator<PrefsService>().userWhatsAppProfile = snapshot.data.data.whatsapp;
          locator<PrefsService>().userWhatsAppCodeProfile = snapshot.data.data.whatsappCode;
          locator<PrefsService>().CounteryIdProfile = snapshot.data.data.countryId;
          locator<PrefsService>().CityIdProfile = snapshot.data.data.cityId;
        }

        return snapshot.hasData ? Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: new BorderRadius.circular(50.0),
                  child: Image.network(
                   snapshot.data.data.avatar,
                    height: 60.0,
                    width: 60.0,
                    fit: BoxFit.fill,

                  ),
                ),
                SizedBox(
                  width: 18.0,
                ),
                Container(
                  child: Text(
                    snapshot.data.data.firstName ,
                    //"Trader Name",
                    style: TextStyle(
                      color: drawerColor,
                      fontWeight: bolFont,
                      fontSize: MediumFont,
                    ),
                  ),
                ),

              ],
            ),
            Container(
              height: 5.0,
            ),
            snapshot.data.data.email.length < 30 ?  FittedBox(
              child: Text(
                //  "Trader_Name@trader.com",
                snapshot.data.data.email,
                style: TextStyle(
                  color: drawerColor,
                  fontWeight: semiFont,
                  fontSize: SecondaryFont,
                ),
              ),
            ):Container,
          ],
        ):Container(
          height: 50.0,
        );
      }
    ):Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: new BorderRadius.circular(50.0),
              child: Image.network(
                locator<PrefsService>().userImageProfile.toString(),
                height: 60.0,
                width: 60.0,
                fit: BoxFit.fill,

              ),
            ),
            SizedBox(
              width: 18.0,
            ),
            Container(
              child: Text(
                locator<PrefsService>().userNameProfile,
                //"Trader Name",
                style: TextStyle(
                  color: drawerColor,
                  fontWeight: bolFont,
                  fontSize: MediumFont,
                ),
              ),
            ),

          ],
        ),
        Container(
          height: 5.0,
        ),
        locator<PrefsService>().userEmailProfile.length  < 30 ?  FittedBox(
          child: Text(
            //  "Trader_Name@trader.com",
            locator<PrefsService>().userEmailProfile ,
            style: TextStyle(
              color: drawerColor,
              fontWeight: semiFont,
              fontSize: SecondaryFont,
            ),
          ),
        ):Container,
      ],
    );
  }
}

Widget DrawerItem(imgUrl, title, voidOnTap) {
  return Container(
    margin: EdgeInsets.only(bottom: 8.0),
    child: ListTile(
      leading: Image.asset(
        imgUrl,
        height: 25.0,
        width: 25.0,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: drawerColor,
          fontWeight: bolFont,
          fontSize: PrimaryFont,
        ),
      ),
      onTap: voidOnTap,
    ),
  );
}
