//import 'package:flutter/material.dart';
//import 'dart:io';
//
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:medicine/localizations/app_language.dart';
//import 'package:medicine/localizations/app_localizations.dart';
//import 'package:medicine/service/api.dart';
//import 'package:medicine/service/service_locator.dart';
//import 'package:medicine/src/blocs/my_account_switch_bloc.dart';
//import 'package:medicine/src/blocs/update_profile.dart';
//import 'package:medicine/src/views/screens/change_password.dart';
//import 'package:medicine/src/views/screens/wallet.dart';
//import 'package:medicine/theme_setting.dart';
//import 'package:provider/provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shimmer/shimmer.dart';
//import 'package:image_picker/image_picker.dart';
//
//class UpdateProfileScreen extends StatefulWidget {
//  var snapShotData;
//  UpdateProfileScreen(this.snapShotData);
//  @override
//  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
//}
//
//class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
//  final firstNameController = TextEditingController();
//
//  final secondNameController = TextEditingController();
//
//  final PhoneController = TextEditingController();
//
//  final phoneCodeController = TextEditingController();
//
//  final wharsAppController = TextEditingController();
//
//  final whatsAppCodeController = TextEditingController();
//
//  final emailController = TextEditingController();
//
//  bool switchOn = false;
//
//  void _onSwitchChanged(bool value) {
//    switchOn = false;
//  }
//
//  File SelectedImage;
//
//  Future getImageGallery() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//    setState(() {
//      SelectedImage = image;
//    });
//
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setString('test_image', SelectedImage.path);
//    String imagePath = (prefs.getString('test_image'));
//    locator<UpdateProfileBloc>().imagePathSink(imagePath);
//  }
//
//  Future getImageCamera() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.camera);
//    setState(() {
//      SelectedImage = image;
//    });
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setString('test_image', SelectedImage.path);
//    String imagePath = (prefs.getString('test_image'));
//    locator<UpdateProfileBloc>().imagePathSink(imagePath);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        elevation: 0,
//        title: Text("Update Profile"),
//        leading: IconButton(
//          icon: Icon(
//            Icons.arrow_back_ios,
//            size: 25.0,
//          ),
//          onPressed: () {
//            Navigator.pop(context);
//          },
//        ),
//      ),
//      body: Container(
//        padding: EdgeInsets.all(25.0),
//        child: ListView(
//          children: <Widget>[
//Container(
//  height: 25.0,
//),
//                Center(
//                  child: locator<UpdateProfileBloc>()
//                      .currentimagePath ==
//                      null
//                      ? Text('No image selected.')
//                      : ClipRRect(
//                    borderRadius:
//                    new BorderRadius.circular(
//                        50.0),
//                    child: Image.file(
//                      //File("/storage/emulated/0/DCIM/SharedFolder/mohamed.jpeg"),
//                      File(locator<
//                          UpdateProfileBloc>()
//                          .currentimagePath),
//                      // SelectedImage,
//                      height: 100.0,
//                      width: 100.0,
//                    ),
//                  ),
//                ),
//                Container(
//                  height: 15.0,
//                ),
//                Row(
//                  children: <Widget>[
//                    Expanded(
//                      child: RaisedButton(
//                        child: Text("From Camera"),
//                        onPressed: () {
//                          getImageCamera();
////                          Navigator.pop(context);
//                        },
//                      ),
//                    ),
//                    Expanded(
//                      child: FlatButton(
//                        child: Text("From Gallery"),
//                        onPressed: () {
//                          getImageGallery();
////                          Navigator.pop(context);
//                        },
//                      ),
//                    ),
//                  ],
//                ),
//                _namesFiled(),
//                Container(
//                  height: 20.0,
//                ),
//                _emailFiled(),
//                Container(
//                  height: 20.0,
//                ),
//                _phoneFiled(),
//                Container(
//                  height: 15.0,
//                ),
//                _whatsappFiled(),
//                Container(
//                  height: 35.0,
//                ),
//                Center(
//                  child: ButtonTheme(
//                    height: 60.0,
//                    child: RaisedButton(
//                      color:
//                      Theme.of(context).accentColor,
//                      onPressed: () {
//                        ApiService.UserProfileUpdate(
//                            SelectedImage,
//                            SelectedImage.path,
//                            emailController.text);
//                        print(
//                            "${locator<UpdateProfileBloc>().currentName} & ${locator<UpdateProfileBloc>().currentSecondName}");
//                        print(
//                            'SelectedImage$SelectedImage');
//                        Navigator.pop(context);
//                      },
//                      child: Text(
//                        "Update Profile",
//                        style: TextStyle(
//                          color: Colors.white,
//                          fontSize: MainFont,
//                          fontWeight: semiFont,
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
//
//          ],
//        ),
//      ),
//    );
//  }
//  Widget _namesFiled() {
//    return Row(
//      children: <Widget>[
//        Expanded(
//          child: StreamBuilder<Object>(
//              stream: locator<UpdateProfileBloc>().name,
//              builder: (context, snapshot) {
//                return TextField(
//                  controller: firstNameController,
//                  onChanged: locator<UpdateProfileBloc>().changeName,
//                  decoration: InputDecoration(
//                      errorText: snapshot.error,
//                      hintText: AppLocalizations.of(context)
//                          .translate('first_name_str'),
//                      labelText: AppLocalizations.of(context)
//                          .translate('first_name_str'),
//                      border: OutlineInputBorder()),
//                );
//              }),
//        ),
//        SizedBox(
//          width: 15.0,
//        ),
//        Expanded(
//          child: StreamBuilder<Object>(
//              stream: locator<UpdateProfileBloc>().secondname,
//              builder: (context, snapshot) {
//                return TextField(
//                  controller: secondNameController,
//                  onChanged: locator<UpdateProfileBloc>().changeSecondName,
//                  decoration: InputDecoration(
//                      errorText: snapshot.error,
//                      hintText: AppLocalizations.of(context)
//                          .translate("family_name_str"),
//                      labelText: AppLocalizations.of(context)
//                          .translate("family_name_str"),
//                      border: OutlineInputBorder()),
//                );
//              }),
//        ),
//      ],
//    );
//  }
//
//  Widget _emailFiled() {
//    return StreamBuilder<Object>(
//        stream: locator<UpdateProfileBloc>().email,
//        builder: (context, snapshot) {
//          return TextField(
//            controller: emailController,
//            onChanged: locator<UpdateProfileBloc>().changeEmail,
//            //  onChanged: UpdateProfileBloc.changeName,
//            decoration: InputDecoration(
//                errorText: snapshot.error,
//                hintText: AppLocalizations.of(context).translate('email_str'),
//                labelText: AppLocalizations.of(context).translate('email_str'),
//                //errorText: snapshot.error,
//                border: OutlineInputBorder()),
//          );
//        });
//  }
//
//  Widget _phoneFiled() {
//    return Row(
//      children: <Widget>[
//        Container(
//          padding: EdgeInsets.symmetric(horizontal: 10.0),
//          decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(5.0),
//            border: Border.all(
//                color: Colors.grey, style: BorderStyle.solid, width: 0.80),
//          ),
//          child: DropdownButton<dynamic>(
//            //hint: Text(dropFirstVal),
//            onChanged: dropFirstChanged,
//            value: dropFirstVal,
//            items: ["+20", "+55", "+35"]
//                .map<DropdownMenuItem<dynamic>>((dynamic value) {
//              return DropdownMenuItem(
//                child: Text(value),
//                value: value,
//              );
//            }).toList(),
//          ),
//        ),
//        SizedBox(
//          width: 15.0,
//        ),
//        Expanded(
//          child: StreamBuilder<Object>(
//              stream: locator<UpdateProfileBloc>().mobile,
//              builder: (context, snapshot) {
//                return TextField(
//                  onChanged: locator<UpdateProfileBloc>().changeMobile,
//                  keyboardType: TextInputType.number,
//                  //  onChanged: UpdateProfileBloc.changeName,
//                  decoration: InputDecoration(
//                      errorText: snapshot.error,
//                      hintText:
//                      AppLocalizations.of(context).translate('phone_str'),
//                      labelText:
//                      AppLocalizations.of(context).translate('phone_str'),
//                      //errorText: snapshot.error,
//                      border: OutlineInputBorder()),
//                );
//              }),
//        ),
//      ],
//    );
//  }
//
//  Widget _whatsappFiled() {
//    return Row(
//      children: <Widget>[
//        Container(
//          padding: EdgeInsets.symmetric(horizontal: 10.0),
//          decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(5.0),
//            border: Border.all(
//                color: Colors.grey, style: BorderStyle.solid, width: 0.80),
//          ),
//          child: DropdownButton<dynamic>(
//            //hint: Text(dropFirstVal),
//            onChanged: dropFirstChanged,
//            value: dropSecVal,
//            items: ["+20", "+65", "+95"]
//                .map<DropdownMenuItem<dynamic>>((dynamic value) {
//              return DropdownMenuItem(
//                child: Text(value),
//                value: value,
//              );
//            }).toList(),
//          ),
//        ),
//        SizedBox(
//          width: 15.0,
//        ),
//        Expanded(
//          child: StreamBuilder<Object>(
//              stream: locator<UpdateProfileBloc>().whatsapp,
//              builder: (context, snapshot) {
//                return TextField(
//                  onChanged: locator<UpdateProfileBloc>().changeWhatsapp,
//                  keyboardType: TextInputType.number,
//                  //  onChanged: UpdateProfileBloc.changeName,
//                  decoration: InputDecoration(
//                      errorText: snapshot.error,
//                      hintText:
//                      AppLocalizations.of(context).translate('phone_str'),
//                      labelText:
//                      AppLocalizations.of(context).translate('phone_str'),
//                      //errorText: snapshot.error,
//                      border: OutlineInputBorder()),
//                );
//              }),
//        ),
//      ],
//    );
//  }
//
//  dynamic dropFirstVal = "+20";
//  bool isSecuredPassword = true;
//  bool isSecuredConfirm = true;
//  int radioGroup = 1;
//
//  String phoneCode;
//  String whatsAppCode;
//
//  void dropFirstChanged(dynamic val) {
//    setState(() {
//      dropFirstVal = val;
//      //   locator<UpdateProfileBloc>().phoneCodeSubjectSink.add(dropFirstVal);
//    });
//  }
//
//  dynamic dropSecVal = "+20";
//
//  void dropSecChanged(dynamic val) {
//    setState(() {
//      dropSecVal = val;
//      //   locator<UpdateProfileBloc>().whastappCodeSubjectSink.add(dropSecVal);
//    });
//  }
//
//  void dispose() {
//    firstNameController.dispose();
//    secondNameController.dispose();
//    PhoneController.dispose();
//    phoneCodeController.dispose();
//    wharsAppController.dispose();
//    whatsAppCodeController.dispose();
//    emailController.dispose();
//    super.dispose();
//  }
//}
