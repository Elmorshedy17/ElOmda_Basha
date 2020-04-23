import 'package:flutter/material.dart';
import 'package:momentoo/features/address_book/addressBook_manager.dart';
import 'package:momentoo/features/address_book/addressBook_model.dart';
import 'package:momentoo/features/delete_addresses/delete_address_repo.dart';
import 'package:momentoo/features/edit_address/_repo.dart';
import 'package:momentoo/features/edit_address/editAddress_screen.dart';
import 'package:momentoo/features/new_address/dropdown_data.dart';
import 'package:momentoo/features/new_address/newAddress_screen.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/helper/observer_widget.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:momentoo/shared/theme_setting.dart';
import 'package:rxdart/rxdart.dart';

BehaviorSubject isLoading = new BehaviorSubject.seeded(false);

class AddressBookScreen extends StatefulWidget {
  @override
  _AddressBookScreenState createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends State<AddressBookScreen> {
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

  List<User> users = <User>[const User(1, 'Foo'), const User(2, 'Bar')];
//List<List<User>> Users = [];
  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).translate('addressBook_str'),
            style: TextStyle(
              color: Colors.white,
//              fontSize: 25,
//              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
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
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            CustomObserver(
                stream: locator<AddressesManager>().getData(),
                onSuccess: (_, AddressesModel model) {
                  print("model$model");
                  for (int index = 0;
                      index < model.data.cities.length;
                      index++) {
                    users.add(User(model.data.cities[index].id,
                        model.data.cities[index].name));
                  }
                  locator<DrobDownBloc>()
                      .DrobDownBlocSink
                      .add(model.data.cities);

                  print(
                      "locator<DrobDownBloc>().currentDrobDownBloc${locator<DrobDownBloc>().currentDrobDownBloc[0].name}");
                  return Stack(
                    children: <Widget>[
                      Column(
//          crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
//            Center(
//              child: Container(
////                elevation: 5,
//                child: Container(
//                  width: MediaQuery.of(context).size.width * 0.90,
//                  height: 60,
//                  child: Center(
//                    child: Text(
//                      AppLocalizations.of(context).translate('addressBook_str'),
//                      style: TextStyle(
//                        color: Colors.white,
//                        fontSize: 25,
//                        fontWeight: FontWeight.bold,
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//            ),

                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: model.data.addresses.length,
                                  itemBuilder: (context, index) {
                                    return AddressBookItem(
                                      id: model.data.addresses[index].id,
                                      modelData: model,
//                                deleteTag: 'd1',
//                                editTag: 'e1',
                                      adress: model.data.addresses[index].title,
                                    );
                                  }),
                            ),
                          ),
                          SizedBox(
                            height: 85.0,
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 5.0,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          child: ButtonTheme(
                            height: 55,
                            minWidth: MediaQuery.of(context).size.width * 0.8,
                            child: RaisedButton(
                              color: Colors.teal.shade900,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.white24),
                              ),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('addNewAddress_str'),
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontFamily:
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? 'en'
                                            : 'ar'),
                              ),
                              onPressed: () {
                                _navigateAndRetrieveData(context,
                                    model.data.country, model.data.cities);
//                                Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) => NewAddressScreen(
//                                            country: model.data.country,
//                                            cities: model.data.cities,
//                                          )),
//                                );
//                          model
//                          Navigator.of(context).pushNamed('/newAddressScreen');
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
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
//                AppLocalizations.of(context).translate('addNewAddress_str'),
//                style: TextStyle(
//                    color: Colors.white70,
//                    fontFamily: locator<PrefsService>().appLanguage == 'en'
//                        ? 'en'
//                        : 'ar'),
//              ),
//              onPressed: () {
//                Navigator.of(context).pushNamed('/newAddressScreen');
//              },
//            ),
//          ),
//        ),
      ),
    );
  }
}

class AddressBookItem extends StatelessWidget {
//  final String deleteTag;
//  final String editTag;
  final String adress;
  final int id;
  final modelData;

  AddressBookItem({this.adress, this.id, this.modelData});
//    , this.editTag, this.adress

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 95,
      child: Card(
        elevation: 5,
        child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Image.asset(
                'assets/images/address_book.png',
                width: 30,
                height: 30,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child:
                    // Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // children: <Widget>[
                    Text(adress),
                // Text('data'),
                // ],
                // ),
              ),
            ),
            Row(
              children: <Widget>[
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: double.infinity),
                  child: RaisedButton(
                    color: Colors.grey[350],
//                  heroTag: editTag,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    onPressed: () {
//                      Navigator.of(context).pushNamed('/editAddressScreen');

                      isLoading.add(true);

                      AddressesInfoRepo.getAddressesInfoData(id)
                          .then((onValue) {
                        isLoading.add(false);

                        if (onValue.status == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditAddressScreen(onValue)),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(onValue.message),
                              );
                            },
                          );
                        }
                      });
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('edit_str'),
                      style: TextStyle(
                          fontFamily:
                              locator<PrefsService>().appLanguage == 'en'
                                  ? 'en'
                                  : 'ar'),
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: double.infinity),
                  child: RaisedButton(
                    color: Colors.red,
//                  heroTag: deleteTag,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    onPressed: () {
                      isLoading.add(true);
                      DeleteAddressRepo.postDeleteNewAddressData(id)
                          .then((onValue) {
                        isLoading.add(false);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(onValue.message),
                            );
                          },
                        );
//                        Navigator.pushReplacementNamed(context, '/AddressBookScreen');

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddressBookScreen()),
                        );
                      });
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('delete_str'),
                      style: TextStyle(
                          fontFamily:
                              locator<PrefsService>().appLanguage == 'en'
                                  ? 'en'
                                  : 'ar'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  const User(this.id, this.name);

  final String name;
  final int id;
}
