import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medicine/localizations/app_language.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/loading_manger.dart';
import 'package:medicine/src/blocs/my_account_switch_bloc.dart';
import 'package:medicine/src/blocs/update_profile.dart';
import 'package:medicine/src/views/screens/change_password.dart';
import 'package:medicine/src/views/screens/wallet_delivery.dart';
import 'package:medicine/theme_setting.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:image_picker/image_picker.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  BehaviorSubject isDialogAdd = new BehaviorSubject.seeded(false);


  TextEditingController firstNameController = TextEditingController();

  TextEditingController secondNameController = TextEditingController();

  TextEditingController PhoneController = TextEditingController();

  TextEditingController phoneCodeController = TextEditingController();

  TextEditingController wharsAppController = TextEditingController();

  TextEditingController whatsAppCodeController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController cashNumber = TextEditingController();

  // locator<PrefsService>().userNameProfile = snapshot.data.data.firstName;
  //
  // locator<PrefsService>().userEmailProfile = snapshot.data.data.email;
  // locator<PrefsService>().userLastName = snapshot.data.data.lastName;
  // locator<PrefsService>().userPhoneProfile = snapshot.data.data.phone;
  // locator<PrefsService>().userPhoneCodeProfile = snapshot.data.data.phoneCode;
  // locator<PrefsService>().userWhatsAppProfile = snapshot.data.data.whatsapp;
  // locator<PrefsService>().userWhatsAppCodeProfile = snapshot.data.data.whatsappCode;
  // locator<PrefsService>().CounteryIdProfile = snapshot.data.data.countryId;
  // locator<PrefsService>().CityIdProfile = snapshot.data.data.cityId;


 String firstdrop = locator<PrefsService>().userPhoneCodeProfile;


  final  first = BehaviorSubject.seeded("+${locator<PrefsService>().userPhoneCodeProfile.replaceAll(new RegExp(r'[^\w\s]+'),'') }");
  final  second = BehaviorSubject.seeded("+${locator<PrefsService>().userWhatsAppCodeProfile.replaceAll(new RegExp(r'[^\w\s]+'),'')}");

  @override
  void initState() {
    super.initState();
    // first = "+${}";
    firstNameController =
    new TextEditingController(text: locator<PrefsService>().userNameProfile);

    secondNameController =
    new TextEditingController(text:  locator<PrefsService>().userLastName);

    PhoneController = new TextEditingController(text: locator<PrefsService>().userPhoneProfile);

    phoneCodeController = new TextEditingController(text: locator<PrefsService>().userPhoneCodeProfile );

    wharsAppController = new TextEditingController(text: locator<PrefsService>().userWhatsAppProfile);

    whatsAppCodeController = new TextEditingController(text: locator<PrefsService>().userWhatsAppCodeProfile);

    // emailController = new TextEditingController(text: locator<PrefsService>().userEmailProfile);
  }

  bool switchOn = false;

  void _onSwitchChanged(bool value) {
    switchOn = false;
  }

  File SelectedImage;

  Future getImageGallery() async {

    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//    setState(() {
//      SelectedImage = image;
//    });

//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setString('test_image', SelectedImage.path);
//    String imagePath = (prefs.getString('test_image'));
    locator<UpdateProfileBloc>().imagePathSink(image.path);

  }


  Future getImageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
//    setState(() {
//      SelectedImage = image;
//    });
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setString('test_image', SelectedImage.path);
//    String imagePath = (prefs.getString('test_image'));
    locator<UpdateProfileBloc>().imagePathSink(image.path);
  }





  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(AppLocalizations.of(context).translate("My_Acount")),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<Object>(
          future: ApiService.UserProfile(), //returns bool
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              cashNumber = new TextEditingController(text: snapshot.data.data.accountNumber);

            }
            return snapshot.hasData? SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    //     color: Colors.yellow,
                  ),
                  Container(
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(50.0)),
                      child: Container(
                        height: 120.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    top: 60.0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            _firstCard(snapshot),
                            SizedBox(
                              height: 10.0,
                            ),
                            _secondCard(snapshot),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30.0,
                    right: MediaQuery.of(context).size.width / 2 - 70.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: new BorderRadius.circular(3.0),
                              child: InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(3.5),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.4),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0))),
                                  ///
                                  /// dont forget put this later on shared prefrences and delete the static picture
                                  ///
                                  child: snapshot.connectionState ==
                                          ConnectionState.done
                                      ?
              new ClipRRect(
              borderRadius: new BorderRadius.circular(50.0),
              child: Image.network(
                snapshot.data.data.avatar,
                height: 100.0,
                width: 100.0,
                fit: BoxFit.fill,
              )
              )
                                      : CircularProgressIndicator(),
       ),

                              ),
                            ),
                            Container(
                              height: 6.0,
                            ),
                            snapshot.connectionState == ConnectionState.done
                                ? Text(
                                    snapshot.data.data.name,
                                    style: TextStyle(
                                      fontSize: PrimaryFont,
                                      fontWeight: bolFont,
                                    ),
                                  )
                                : Container(),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    height: 80,
                    width: 80,
                    top: 80,
                    left: 20,
                    child: FlatButton(
                      child: Image.asset(
                        "assets/images/edit.png",
                        height: 50.0,
                        width: 50.0,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title:Container(
                                  height: 15.0,
                                ),
                                //Text("Choose where want pick Image"),
                                content: StreamBuilder(
                                  stream: isDialogAdd.stream,
                                  builder: (context, snapshot) {
                                    return Stack(
                                      children: <Widget>[
                                        Container(
                                          height: MediaQuery.of(context).size.height - 20,
                                          width: MediaQuery.of(context).size.width,
                                          child: ListView(
                                            children: <Widget>[
                                              StreamBuilder<Object>(
                                                  stream: locator<UpdateProfileBloc>().imagePathStream$,
                                                builder: (context, snapshot) {
                                                  return Center(
                                                    child:
//                                        locator<UpdateProfileBloc>().currentimagePath == null
                                                      snapshot.hasData ? ClipRRect(
                                                        borderRadius:
                                                        new BorderRadius.circular(50.0),
                                                        child: Image.file(
                                                          //File("/storage/emulated/0/DCIM/SharedFolder/mohamed.jpeg"),
                                                          File(snapshot.data),
                                                          // SelectedImage,
                                                          height: 100.0,
                                                          width: 100.0,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      )
                                                        : Text(AppLocalizations.of(context).translate("No_image_selected_str")) ,
                                                  );
                                                }
                                              ),
                                              Container(
                                                height: 15.0,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: RaisedButton(
                                                      color: accentColor,

                                                      child: FittedBox(
                                                        child: Text(AppLocalizations.of(context).translate("From_Camera_str"),
                                                          style: TextStyle(color: Colors.white),),
                                                      ),
                                                      onPressed: () {
                                                        getImageCamera();
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8.0,
                                                  ),
                                                  Expanded(
                                                    child: FlatButton(
                                                      color: accentColor,
                                                      child:
                                                      FittedBox(
                                                        child: Text(AppLocalizations.of(context).translate("From_Gallery_str"),
                                                        style: TextStyle(color: Colors.white),),
                                                      ),
                                                      onPressed: () {
                                                        getImageGallery();
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: 15.0,
                                              ),
                                              _namesFiled(),
                                              Container(
                                                height: 20.0,
                                              ),
                                              _emailFiled(),
                                              Container(
                                                height: 20.0,
                                              ),
                                              _phoneFiled(),
                                              Container(
                                                height: 15.0,
                                              ),
                                              _whatsappFiled(),
                                              Container(
                                                height: 15.0,
                                              ),
                                              _numberCashFiled(snapshot),
                                              Container(
                                                height: 15.0,
                                              ),
                                              Center(
                                                child: ButtonTheme(
                                                  height: 60.0,
                                                  child: RaisedButton(
                                                    color: Theme.of(context).accentColor,
                                                    onPressed: (){


                                                print("firstValueXxX${first.value}");
                                                print("firstValueXxX${second.value}");


print("${firstNameController.text}  ${secondNameController.text}    ${PhoneController.text}   ${wharsAppController.text}  ${emailController.text}  ${locator<UpdateProfileBloc>().currentimagePath} whwhw}");

                                                      if(firstNameController.text == ""  && secondNameController.text == ""  && PhoneController.text == "" && wharsAppController.text == "" && emailController.text == "" && locator<UpdateProfileBloc>().currentimagePath == null ){
                                                        showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                    context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            AppLocalizations.of(context).translate("sorry_no_str")),
                                                      );
               }
                                                  );
                                                      }else{


                                                        isDialogAdd.add(true);
                                                        ApiService.UserProfileUpdate(
                                                            firstNameController.text,
                                                            secondNameController.text,
                                                            PhoneController.text,
                                                            wharsAppController.text,
                                                            SelectedImage,
                                                            locator<UpdateProfileBloc>().currentimagePath,
                                                            emailController.text,
                                                            first.value,
                                                            second.value,
                                                            cashNumber.text
                                                        ).then((onValue){
                                                          if (onValue.key == "1") {
                                                            isDialogAdd.add(false);



                                                            locator<PrefsService>().userImageProfile = onValue.data.avatar;
                                                            locator<PrefsService>().userNameProfile = onValue.data.firstName;
                                                            locator<PrefsService>().userEmailProfile = onValue.data.email;
                                                            locator<PrefsService>().userLastName = onValue.data.lastName;
                                                            locator<PrefsService>().userPhoneProfile = onValue.data.phone;
                                                            locator<PrefsService>().userPhoneCodeProfile = onValue.data.phoneCode;
                                                            locator<PrefsService>().userWhatsAppProfile = onValue.data.whatsapp;
                                                            locator<PrefsService>().userWhatsAppCodeProfile = onValue.data.whatsappCode;
                                                            // locator<PrefsService>().CounteryIdProfile = onValue.data.;
                                                            // locator<PrefsService>().CityIdProfile = onValue.data.cityId;

                                                            // locator<PrefsService>().removeUserImageProfile();
                                                            // locator<PrefsService>().removeUserNameProfile();
                                                            // locator<PrefsService>().removeUserEmailProfile();
                                                            // locator<PrefsService>().removeUserLastName();
                                                            // locator<PrefsService>().removeUserPhoneProfile();
                                                            // locator<PrefsService>().removeUserPhoneCodeProfile();
                                                            // locator<PrefsService>().removeUserWhatsAppProfile();
                                                            // locator<PrefsService>().removeUserWhatsAppCodeProfile();
//                                              locator<PrefsService>().removeCounteryIdProfile();
//                                              locator<PrefsService>().removeCityIdProfile();

//                                                  showDialog(
//                                                    context: context,
//                                                    builder: (BuildContext
//                                                    context) {
//                                                      return AlertDialog(
//                                                        title: Text(
//                                                            onValue.msg),
//                                                      );
//               }
//                                                  );
//
//                                                  Navigator.pop(context);
//                                                  Navigator.pop(context);
//                                              Navigator.pushReplacement(
//                                                  context,
//                                                  new MaterialPageRoute(
//                                                      builder: (BuildContext context) => MyAccount()));
//
                                                            Fluttertoast.showToast(
                                                                msg: onValue.msg,
                                                                toastLength: Toast.LENGTH_SHORT,
                                                                gravity: ToastGravity.CENTER,
                                                                timeInSecForIosWeb: 1,
                                                                backgroundColor: Colors.red,
                                                                textColor: Colors.white,
                                                                fontSize: 16.0
                                                            );


                                                            setState(() {

                                                            });

                                                          } else {
                                                            isDialogAdd.add(false);

                                                            showDialog(
                                                              context: context,
                                                              builder: (BuildContext
                                                              context) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      onValue.msg),
                                                                );
                                                              },
                                                            );
                                                          }
                                                        });
                                                        print("${locator<UpdateProfileBloc>().currentName} & ${locator<UpdateProfileBloc>().currentSecondName}");
                                                        print('SelectedImage$SelectedImage');
//

                                                      }

                                                    },
                                                    child: Text(
                                                      AppLocalizations.of(context).translate("Update_Profile_str") ,style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: MainFont,
                                                      fontWeight: semiFont,
                                                    ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        isDialogAdd.value == true ?  Container(
                                          height: MediaQuery.of(context).size.height,
                                          width: MediaQuery.of(context).size.width,
                                          color: Colors.black.withOpacity(0.5),
                                          child: Center(child: CircularProgressIndicator()),
                                        ):Container(),
                                      ],
                                    );
                                  }
                                ),
                              );
                            });
                      },
                    ),
                  ),
                ],
              ),
            ):Center(child: CircularProgressIndicator(),);
          }),
    );
  }

  Widget _emailUser(snapshot) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: Expanded(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.mail_outline,
                        color: Colors.blue.withOpacity(.6),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        AppLocalizations.of(context).translate("E-Mail_str"),
                        style: TextStyle(
                          fontSize: PrimaryFont,
                          fontWeight: bolFont,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
//          SizedBox(
//            width: 5.0,
//          ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              snapshot.connectionState == ConnectionState.done
                  ? Text(
                snapshot.data.data.email,
                style: TextStyle(
                    fontSize: PrimaryFont,
                    fontWeight: semiFont,
                    color: lightText),
              )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _phoneUser(snapshot) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.local_phone,
                  color: Colors.blue.withOpacity(.6),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  AppLocalizations.of(context).translate("Phone_Number_str") ,
                  style: TextStyle(
                    fontSize: PrimaryFont,
                    fontWeight: bolFont,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              snapshot.connectionState == ConnectionState.done
                  ? Text(
                snapshot.data.data.phone,
                style: TextStyle(
                    fontSize: PrimaryFont,
                    fontWeight: semiFont,
                    color: lightText),
              )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _changePassword(snapshot) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => ChangePassword()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.lock_outline,
                    color: Colors.blue.withOpacity(.6),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    AppLocalizations.of(context).translate("Change_Password_str"),
                    style:
                        TextStyle(fontWeight: bolFont, fontSize: PrimaryFont),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15.0,
                  color: lightText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _firstCard(snapshot) {
    return Wrap(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Wrap(
              children: <Widget>[
                Container(
                  height: 100.0,
                ),
                _emailUser(snapshot),
            Divider(),

                Container(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.money_sharp, color: Colors.blue.withOpacity(.6),),
                          Container(
                            width: 8,
                          ),
                          Text(
                            AppLocalizations.of(context).translate('number_cash'),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            snapshot.data.data.accountNumber,
                            style: TextStyle(
                                fontSize: PrimaryFont,
                                fontWeight: semiFont,
                                color: lightText),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                Divider(
                  //  color: Colors.blueGrey,
                  indent: 5.0,
                  endIndent: 5.0,
                ),
                _phoneUser(snapshot),
                Divider(
                  color: Colors.blueGrey,
                  indent: 5.0,
                  endIndent: 5.0,
                ),
                _changePassword(snapshot)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _secondCard(snapshot) {
    return Wrap(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Wrap(
              children: <Widget>[
                _wallet(snapshot.data.data),
                Divider(
                  color: Colors.blueGrey.withOpacity(.3),
                  indent: 5.0,
                  endIndent: 5.0,
                  height: 1.0,
                ),
                _notifications(snapshot.data.data),
                Divider(
                  color: Colors.blueGrey.withOpacity(.3),
                  indent: 5.0,
                  endIndent: 5.0,
                  height: 1.0,
                ),
                _language(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _wallet(data) {
    return InkWell(
      onTap: () {
        // print("locator<PrefsService>().notificationFlag${locator<PrefsService>().notificationFlag}");

        print(data.name);
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) => WalletDelivery(data)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.account_balance_wallet,
                    color: Colors.blue.withOpacity(.6),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    AppLocalizations.of(context).translate("My_Wallet_str"),
                    style:
                        TextStyle(fontWeight: bolFont, fontSize: PrimaryFont),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15.0,
                    color: lightText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _language() {
    String lang = "English";

    bool lango = false;
    var prefs = locator<PrefsService>();
    var appLanguage = Provider.of<AppLanguage>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.language,
                  color: Colors.blue.withOpacity(.6),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  AppLocalizations.of(context).translate("Language_str") ,
                  style: TextStyle(fontWeight: bolFont, fontSize: PrimaryFont),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<Object>(
                stream: locator<SwitchNotyBloc>().switchLangStream$,
                initialData: false,
                builder: (context, snapshot) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        locator<SwitchNotyBloc>().currentLang == false
                            ? "English"
                            : "العربية",
                        style: TextStyle(
                            color: greyBlue,
                            fontWeight: bolFont,
                            fontSize: PrimaryFont),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      CupertinoSwitch(
                          activeColor: Colors.greenAccent,
                          value: snapshot.data,
                          onChanged: (bool flag) {
                            locator<SwitchNotyBloc>().onSwitchLangChanged();
                            print(locator<SwitchNotyBloc>().currentLang);

                            setState(() {
                              // Localizations.localeOf(context).languageCode == 'en'
                              //     ? Provider.of<AppLanguage>(context).changeLanguage(Locale('ar'))
                              //     : Provider.of<AppLanguage>(context).changeLanguage(Locale('en'));

                          if(Localizations.localeOf(context).languageCode == 'en'){
                            appLanguage.changeLanguage(Locale('ar'));
                            prefs.appLanguage ='ar';
                          }else{
                            appLanguage.changeLanguage(Locale('en'));
                            prefs.appLanguage ='en';
                          }


                            });

                          }
//                              (bool flag) {
//                            setState(() {
//                              switchOn = flag;
//                            });
//                          }
                          )
//                StreamBuilder<Object>(
//                    stream: locator<SwitchNotyBloc>().switchLangStream$,
//                    initialData: false,
//                    builder: (context, snapshot) {
//                      return ;
//                    }),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget _notifications(data) {
    return InkWell(
      onTap: null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.notifications_none,
                    color: Colors.blue.withOpacity(.6),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    AppLocalizations.of(context).translate("Notifications_str"),
                    style:
                        TextStyle(fontWeight: bolFont, fontSize: PrimaryFont),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  StreamBuilder<Object>(
                      stream: locator<SwitchNotyBloc>().switchStream$,
                      initialData: locator<PrefsService>().notificationFlag ?? true,
                      builder: (context, snapshot) {
                        return CupertinoSwitch(
                            activeColor: Colors.greenAccent,
                            value:  locator<PrefsService>().notificationFlag ?? true,
                            onChanged: (bool flag) {
                              print("locator<PrefsService>().notificationFlag${locator<PrefsService>().notificationFlag}");
                              locator<SwitchNotyBloc>().onSwitchChanged();
                              // setState(() {


                              print("locator<PrefsService>().notifySend ${locator<PrefsService>().notifySend } locator<PrefsService>().notifySend ${locator<PrefsService>().notificationFlag}");

                              print("xXxlocator<PrefsService>().notificationFlag${locator<PrefsService>().notificationFlag}");

                                locator<PrefsService>().notificationFlag = !locator<PrefsService>().notificationFlag;
                              if( locator<PrefsService>().notificationFlag == false){
                                locator<PrefsService>().notifySend = 0;
                                print("xXxtx 000000");
                              }else{
                                locator<PrefsService>().notifySend  =1;
                                print("xXxtx 111111");

                              }


                              print("xXxcurrentName${locator<UpdateProfileBloc>().currentName}");
                              print("xXxcurrentSecondName${locator<UpdateProfileBloc>().currentSecondName}");
                              print("xXx${locator<UpdateProfileBloc>().currentName == "" || locator<UpdateProfileBloc>().currentName == null}");
                              print("xXx${locator<UpdateProfileBloc>().currentSecondName == "" || locator<UpdateProfileBloc>().currentSecondName == null}");
                              print("xXx${locator<UpdateProfileBloc>().currentName}");
                              print("xXx${locator<UpdateProfileBloc>().currentName}");
                              print("xXxcurrentMobile${locator<UpdateProfileBloc>().currentMobile == null}");
                              locator<IsLoadingManager>().isLoading.add(true);
                              ApiService.UserProfileUpdateNotification(
                                  data.phoneCode,
                                  data.whatsappCode
                              ).then((value) {
                                locator<IsLoadingManager>().isLoading.add(false);
                                Fluttertoast.showToast(
                                    msg: value.msg,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              });
                              // });
                            }
                            );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _namesFiled() {
    return Row(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<Object>(
              stream: locator<UpdateProfileBloc>().name,
              builder: (context, snapshot) {
                return TextField(
                  controller: firstNameController,
                  onChanged: locator<UpdateProfileBloc>().changeName,
                  decoration: InputDecoration(
                      errorText: snapshot.error,
                      hintText: AppLocalizations.of(context)
                          .translate('first_name_str'),
                      labelText: AppLocalizations.of(context)
                          .translate('first_name_str'),
                      border: OutlineInputBorder()),
                );
              }),
        ),
        SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: StreamBuilder<Object>(
              stream: locator<UpdateProfileBloc>().secondname,
              builder: (context, snapshot) {
                return TextField(
                  controller: secondNameController,
                  onChanged: locator<UpdateProfileBloc>().changeSecondName,
                  decoration: InputDecoration(
                      errorText: snapshot.error,
                      hintText: AppLocalizations.of(context)
                          .translate("family_name_str"),
                      labelText: AppLocalizations.of(context)
                          .translate("family_name_str"),
                      border: OutlineInputBorder()),
                );
              }),
        ),
      ],
    );
  }

  Widget _emailFiled() {
    return StreamBuilder<Object>(
        stream: locator<UpdateProfileBloc>().email,
        builder: (context, snapshot) {
          return TextField(
            controller: emailController,
            onChanged: locator<UpdateProfileBloc>().changeEmail,
            //  onChanged: UpdateProfileBloc.changeName,
            decoration: InputDecoration(
                errorText: snapshot.error,
                hintText: AppLocalizations.of(context).translate('email_str'),
                labelText: AppLocalizations.of(context).translate('email_str'),
                //errorText: snapshot.error,
                border: OutlineInputBorder()),
          );
        });
  }

  Widget _phoneFiled() {
    return Row(
      children: <Widget>[
        StreamBuilder(
          initialData: "+${locator<PrefsService>().userPhoneCodeProfile.replaceAll(new RegExp(r'[^\w\s]+'),'') }",
          stream: first.stream,
          builder: (context, snapshot) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                    color: Colors.grey, style: BorderStyle.solid, width: 0.80),
              ),
              child: DropdownButton<dynamic>(
                //hint: Text(dropFirstVal),
                onChanged: (dropFirstChanged){
                  first.add(dropFirstChanged);
                },
                value: snapshot.data,
                items: [
                  //  "+20", "+65", "+95"
                  "+93","+213","+973","+269","+20","+251","+62","+98","+964","+962","+965","+961","+218","+60","+212","+234","+968","+92","+970","+974","+966","+249","+963","+216","+90","+971","+967"
                ]
                    .map<DropdownMenuItem<dynamic>>((dynamic value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
              ),
            );
          }
        ),
        SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: StreamBuilder<Object>(
              stream: locator<UpdateProfileBloc>().mobile,
              builder: (context, snapshot) {
                return TextField(
                  controller: PhoneController,
                  onChanged: locator<UpdateProfileBloc>().changeMobile,
                  keyboardType: TextInputType.number,
                  //  onChanged: UpdateProfileBloc.changeName,
                  decoration: InputDecoration(
                      errorText: snapshot.error,
                      hintText:
                          AppLocalizations.of(context).translate('phone_str'),
                      labelText:
                          AppLocalizations.of(context).translate('phone_str'),
                      //errorText: snapshot.error,
                      border: OutlineInputBorder()),
                );
              }),
        ),
      ],
    );
  }


  Widget _numberCashFiled(cashSnapshot) {
    return StreamBuilder<Object>(
        stream: locator<UpdateProfileBloc>().cash.stream,
        builder: (context, snapshot) {
          return TextField(
            controller: cashNumber,
            onChanged: locator<UpdateProfileBloc>().changeCash,
            // keyboardType: TextInputType.number,
            //  onChanged: UpdateProfileBloc.changeName,
            decoration: InputDecoration(
                errorText: snapshot.error,
                hintText:
                AppLocalizations.of(context).translate('number_cash'),
                labelText:
                AppLocalizations.of(context).translate('number_cash'),
                //errorText: snapshot.error,
                border: OutlineInputBorder()),
          );
        });
  }


  Widget _whatsappFiled() {
    return Row(
      children: <Widget>[
        StreamBuilder(
          initialData: "+${locator<PrefsService>().userWhatsAppCodeProfile.replaceAll(new RegExp(r'[^\w\s]+'),'') }",
          stream: second.stream,
          builder: (context, snapshot) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                    color: Colors.grey, style: BorderStyle.solid, width: 0.80),
              ),
              child: DropdownButton<dynamic>(
                //hint: Text(dropFirstVal),
                onChanged: (dropSecChanged){
                  second.sink.add(dropSecChanged);
                },
                value: snapshot.data,
                items: [
                //  "+20", "+65", "+95"
                "+93","+213","+973","+269","+20","+251","+62","+98","+964","+962","+965","+961","+218","+60","+212","+234","+968","+92","+970","+974","+966","+249","+963","+216","+90","+971","+967"
                ]
                    .map<DropdownMenuItem<dynamic>>((dynamic value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
              ),
            );
          }
        ),
        SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: StreamBuilder<Object>(
              stream: locator<UpdateProfileBloc>().whatsapp,
              builder: (context, snapshot) {
                return TextField(
                  controller: wharsAppController,
                  onChanged: locator<UpdateProfileBloc>().changeWhatsapp,
                  keyboardType: TextInputType.number,
                  //  onChanged: UpdateProfileBloc.changeName,
                  decoration: InputDecoration(
                      errorText: snapshot.error,
                      hintText:
                          AppLocalizations.of(context).translate('phone_str'),
                      labelText:
                          AppLocalizations.of(context).translate('phone_str'),
                      //errorText: snapshot.error,
                      border: OutlineInputBorder()),
                );
              }),
        ),
      ],
    );
  }

  // dynamic dropFirstVal = "+966";
  bool isSecuredPassword = true;
  bool isSecuredConfirm = true;
  int radioGroup = 1;

  String phoneCode;
  String whatsAppCode;

  // void dropFirstChanged(dynamic val) {
  //   setState(() {
  //     dropFirstVal = val;
  //     //   locator<UpdateProfileBloc>().phoneCodeSubjectSink.add(dropFirstVal);
  //   });
  // }

  // dynamic dropSecVal = "+966";

  // void dropSecChanged(dynamic val) {
  //   setState(() {
  //     dropSecVal = val;
  //     //   locator<UpdateProfileBloc>().whastappCodeSubjectSink.add(dropSecVal);
  //   });
  // }
  void dispose() {
    firstNameController.dispose();
    secondNameController.dispose();
    PhoneController.dispose();
    phoneCodeController.dispose();
    wharsAppController.dispose();
    whatsAppCodeController.dispose();
    emailController.dispose();
    first.close();
    second.close();
    super.dispose();
  }
}


