import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momentoo/features/edit_profile/_repo.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/helper/main_background.dart';
import 'package:momentoo/shared/services/localizations/app_localizations.dart';
import 'package:momentoo/shared/services/prefs_service.dart';
import 'package:rxdart/rxdart.dart';


class EditProfileScreen extends StatefulWidget {
  var user;
  EditProfileScreen(this.user);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  BehaviorSubject isLoading = new BehaviorSubject.seeded(false);
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middelNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();



  @override
  void initState() {
    super.initState();
    firstNameController = new TextEditingController(text: widget.user.firstName);
    middelNameController = new TextEditingController(text: widget.user.middleName);
    lastNameController = new TextEditingController(text: widget.user.lastName);
    phoneController = new TextEditingController(text: widget.user.phone);
  }

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                ),
                Text(
                  AppLocalizations.of(context).translate('back_str'),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: locator<PrefsService>().appLanguage == 'en'
                        ? 'en'
                        : 'ar',
                  ),
                ),
              ],
            ),
          ),
          title: Text(
            AppLocalizations.of(context).translate('editProfile_str'),
            style: TextStyle(
              color: Colors.white,
              fontFamily:
              locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar',
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
//            Padding(
//              padding: const EdgeInsets.all(4.0),
//              child: Center(
//                child: ButtonTheme(
//                  child: RaisedButton(
//                      color: Colors.teal.shade900,
//                      shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(18.0),
//                        side: BorderSide(color: Colors.teal.shade900),
//                      ),
//                      child: Text(
//                        AppLocalizations.of(context).translate('save_str'),
//                        style: TextStyle(
//                          color: Colors.white,
//                          fontWeight: FontWeight.bold,
//                          fontFamily:
//                              locator<PrefsService>().appLanguage == 'en'
//                                  ? 'en'
//                                  : 'ar',
//                        ),
//                      ),
//                      onPressed: () {
//                        Navigator.of(context).pushNamed('/editProfileScreen');
//                      }),
//                ),
//              ),
//            ),
          ],
        ),
        body: StreamBuilder(
            stream: isLoading.stream,
            builder: (context, isLoadingSnapshot) {
            return Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
                Column(
                  children: <Widget>[
                    ListTile(
                      title: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        margin: EdgeInsets.only(top: 12),
                        elevation: 5,
                        child: TextField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                              filled: true,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),focusedBorder:  OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                              disabledBorder:  OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),

                              hintStyle: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                              ),
                              hintText: AppLocalizations.of(context)
                                  .translate('firstName_str'),
                              fillColor: Colors.white),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 0.0),
                        elevation: 5,
                        child: TextField(
                          controller: middelNameController,
                          decoration: InputDecoration(
                              filled: true,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),focusedBorder:  OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                              disabledBorder:  OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              hintStyle: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                              ),
                              hintText: AppLocalizations.of(context)
                                  .translate('middleName_str'),
                              fillColor: Colors.white),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 0.0),
                        elevation: 5,
                        child: TextField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                              filled: true,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),focusedBorder:  OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                              disabledBorder:  OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              hintStyle: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                              ),
                              hintText: AppLocalizations.of(context)
                                  .translate('lastName_str'),
                              fillColor: Colors.white),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 0.0),
                        elevation: 5,
                        child: TextField(
                          controller: phoneController,
                          decoration: InputDecoration(
                              filled: true,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),focusedBorder:  OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                              disabledBorder:  OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              hintStyle: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                              ),
                              hintText: AppLocalizations.of(context)
                                  .translate('phoneNumber_str'),
                              fillColor: Colors.white),
                        ),
                      ),
                    ),


                    SizedBox(
                      height: 120.0,
                    ),

//            ListTile(
//              title: Card(
//  shape: RoundedRectangleBorder(
//    borderRadius: BorderRadius.circular(8.0),
//  ),
//                margin: EdgeInsets.symmetric(vertical: 0.0),
//                elevation: 5,
//                child: TextField(
//                  decoration: InputDecoration(
//                      filled: true,
//                      border: InputBorder.none,
//                      enabledBorder: OutlineInputBorder(
//                        borderSide: BorderSide(color: Colors.transparent),
//                        borderRadius: const BorderRadius.all(
//                          const Radius.circular(10.0),
//                        ),
//                      ),
//                      hintStyle: TextStyle(
//                        color: Colors.grey[600],
//                        fontFamily: locator<PrefsService>().appLanguage == 'en'
//                            ? 'en'
//                            : 'ar',
//                      ),
//                      hintText:
//                          AppLocalizations.of(context).translate('email_str'),
//                      fillColor: Colors.white),
//                ),
//              ),
//            ),
                  ],
                ),
                Positioned(
                  bottom: 15.0,
                  width: MediaQuery.of(context).size.width,
//              height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonTheme(
                      height: 50,
                      minWidth: MediaQuery.of(context).size.width * 0.8,
                      child: RaisedButton(
                        color: Colors.teal.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.white24),
                        ),
                        child: Text(
                          AppLocalizations.of(context).translate('update_profile_str'),
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18.0,
                            fontFamily:
                            locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar',
                          ),
                        ),
                        onPressed: () {
                          isLoading.add(true);

                          EditProfileRepo.postEditProfileData(firstNameController.text,middelNameController.text,lastNameController.text,phoneController.text).then((onValue){
                            isLoading.add(false);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(onValue.message),
                                );
                              },
                            );
                          });

//                Navigator.of(context).pushNamed('/changePasswordScreen');
                        },
                      ),
                    ),
                  ),
                ),
                isLoading.value == true
                    ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black.withOpacity(0.5),
                  child: Center(child: Container(
//                      color: mainColor,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )),
                )
                    : Container(),
              ],
            );
          }
        ),

//        bottomNavigationBar: ListTile(
//          title: ,
//        ),
      ),
    );
  }
  @override
  void dispose() {
    firstNameController.dispose();
    middelNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    isLoading.close();
    super.dispose();
  }
}

