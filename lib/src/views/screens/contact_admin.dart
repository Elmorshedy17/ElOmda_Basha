import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/contact_admin_bloc.dart';
import 'package:medicine/src/blocs/loading_manger.dart';
import 'package:medicine/theme_setting.dart';

class ContactAdmin extends StatefulWidget {
  @override
  _ContactAdminState createState() => _ContactAdminState();
}

class _ContactAdminState extends State<ContactAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text(AppLocalizations.of(context).translate('Contact_Admin_str')),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 25.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            Container(
              height: 30.0,
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 25.0,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Image.asset(
                "assets/images/contactus.png",
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height / 3.4,
              ),
            ),
            SizedBox(
              height: 45.0,
            ),
            _emailFiled(),
            SizedBox(
              height: 30.0,
            ),
            _textErea(),
            SizedBox(
              height: 30.0,
            ),
            _submitButtom(),
          ],
        ),
      ),
    );
  }

  Widget _emailFiled() {
    return StreamBuilder(
      stream: locator<ContactAdminBloc>().email,
      builder: (context, snapshot) {
        return TextField(
          onChanged: locator<ContactAdminBloc>().changeEmail,
          //  onChanged: signupBloc.changeName,
          decoration: InputDecoration(
            errorText: snapshot.error,
              hintText: AppLocalizations.of(context).translate('email_str'),
              labelText: AppLocalizations.of(context).translate('email_str'),
              //errorText: snapshot.error,
              border: OutlineInputBorder()),
        );
      }
    );
  }

  Widget _textErea() {
    return StreamBuilder(
      stream: locator<ContactAdminBloc>().textArea,
      builder: (context, snapshot) {
        return new TextField(
          onChanged: locator<ContactAdminBloc>().changeTextArea,
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            errorText: snapshot.error,
            alignLabelWithHint: true,
              hintText: AppLocalizations.of(context).translate("your_Message_str"),
             labelText: AppLocalizations.of(context).translate("your_Message_str"),
              //errorText: snapshot.error,
              border: OutlineInputBorder()),
        );
      }
    );
  }


  _submitButtom(){
    return Container(
      width: double.infinity,
      child:
      ButtonTheme(
        height: 60.0,
        child: StreamBuilder(
          stream: locator<ContactAdminBloc>().registerValid,
          builder: (context, snapshot) {
            return RaisedButton(
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
//                    color: Theme.of(context).primaryColor,
              child:
              Text(
                AppLocalizations.of(context).translate('con_send_str'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MainFont,
                  fontWeight: semiFont,
                ),
              ),
              onPressed: snapshot.hasData? (){

                locator<IsLoadingManager>().isLoading.add(true);

                ApiService.StoreContactUs().then((data) {
                  locator<IsLoadingManager>().isLoading.add(false);

                  data.key == "0" ? AlertDialog(
                    title:  Text(data.msg),
                  ): showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return  AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0))),
                        // contentPadding: EdgeInsets.only(top: 10.0),
                        title: Image.asset("assets/images/doneBig.png",),
                        content: Wrap(
                          children: <Widget>[
                            Container(
                              height: 8.0,
                            ),
                            Center(
                              child: Text("${data.msg}",style: TextStyle(
                                fontWeight: bolFont,
                                fontSize: MainFont,
                              ),),
                            ),
                            Container(
                              height: 8.0,
                            ),
//                          Center(
//                            child: Text("Your message has been sent succesfuly to admin",style: TextStyle(
//                                fontWeight: semiFont,
//                                fontSize: PrimaryFont,
//                                color: lightText
//                            ),),
//                          ),
                            Container(
                              height: 8.0,
                            ),
                          ],
                        ),

                      );
                    },
                  );
                }
              );

//                _showSuccesDialog();
              }:null,
            );
          }
        ),
      ),
    );
  }

Widget _showSuccesDialog(){
  showDialog(
      context: context,
      builder: (BuildContext context){
        return Container(
          child: StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return
                AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
               // contentPadding: EdgeInsets.only(top: 10.0),
                title: Image.asset("assets/images/doneBig.png",),
                content: Wrap(
                  children: <Widget>[
                    Container(
                      height: 8.0,
                    ),
                    Center(
                      child: Text("Send Succesfuly",style: TextStyle(
                        fontWeight: bolFont,
                        fontSize: MainFont,
                      ),),
                    ),
                    Container(
                      height: 8.0,
                    ),
                    Center(
                      child: Text(AppLocalizations.of(context).translate("your_Message_sent_str"),style: TextStyle(
                      fontWeight: semiFont,
                      fontSize: PrimaryFont,
                        color: lightText
                      ),),
                    ),
                    Container(
                      height: 8.0,
                    ),
                  ],
                ),

              );
            }
          ),
        );
      }
  );
}
}
