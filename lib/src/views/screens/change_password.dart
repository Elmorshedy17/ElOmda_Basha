import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/change_password_bloc.dart';
import 'package:medicine/src/blocs/loading_manger.dart';
import 'package:medicine/theme_setting.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isSecuredFirst = true;
  bool isSecuredSecond = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 0,right: 20.0,left: 20.0,bottom: 20.0),
          child:
          ListView(
            children: <Widget>[

              Container(
                height: 30.0,
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios,size: 25.0,),
                    onPressed: (){
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
                  "assets/images/login.png",
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height / 3.4,
                ),
              ),
              SizedBox(
                height: 45.0,
              ),
              Row(
                //  mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).translate("Change_Password_Str :") ,
                    style: TextStyle(
                        color: blackColor,
                        fontSize: MainFont,
                        fontWeight: semiFont),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              _changePasswordFiled(),
              SizedBox(
                height: 30.0,
              ),
              _newPasswordFiled(),
              SizedBox(
                height: 30.0,
              ),
              _submitButtom(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _changePasswordFiled() {
    return StreamBuilder<Object>(
      stream: locator<ChangePasswordBloc>().password,
      builder: (context, snapshot) {
        return TextField(
          onChanged: locator<ChangePasswordBloc>().changePassword,
      
          obscureText: isSecuredFirst,
          //  onChanged: signupBloc.changeName,
          decoration: InputDecoration(
            errorText: snapshot.error,
              suffixIcon: isSecuredFirst?IconButton(
                icon: Icon(Icons.visibility_off),
                onPressed: (){
                  setState(() {
                    isSecuredFirst =! isSecuredFirst;
                  });
                },
              ):IconButton(
                icon: Icon(Icons.visibility),
                onPressed: (){
                  setState(() {
                    isSecuredFirst =! isSecuredFirst;
                  });
                },
              ),
              hintText: AppLocalizations.of(context).translate('old_password_str'),
              labelText: AppLocalizations.of(context).translate('old_password_str'),
              //errorText: snapshot.error,
              border: OutlineInputBorder()),
        );
      }
    );
  }



  Widget _newPasswordFiled() {
    return StreamBuilder<Object>(
      stream: locator<ChangePasswordBloc>().newPassword,
      builder: (context, snapshot) {
        return TextField(
          onChanged: locator<ChangePasswordBloc>().changeNewPassword,
          obscureText: isSecuredSecond,
          //  onChanged: signupBloc.changeName,
          decoration: InputDecoration(
            errorText: snapshot.error,
              suffixIcon: isSecuredSecond?IconButton(
                icon: Icon(Icons.visibility_off),
                onPressed: (){
                  setState(() {
                    isSecuredSecond =! isSecuredSecond;
                  });
                },
              ):IconButton(
                icon: Icon(Icons.visibility),
                onPressed: (){
                  setState(() {
                    isSecuredSecond =! isSecuredSecond;
                  });
                },
              ),
              hintText: AppLocalizations.of(context).translate('new_password_str'),
              labelText: AppLocalizations.of(context).translate('new_password_str'),
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
        child: StreamBuilder<Object>(
          stream: locator<ChangePasswordBloc>().registerValid,
          builder: (context, snapshot) {
            return RaisedButton(
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
//                    color: Theme.of(context).primaryColor,
              child:
              Text(
                AppLocalizations.of(context).translate("Change_Password_str"),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MainFont,
                  fontWeight: semiFont,
                ),
              ),
              onPressed: snapshot.hasData? (){
                locator<IsLoadingManager>().isLoading.add(true);

                ApiService.UpdatePassword().then((value) {
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
                }

                );
              }:null,
            );
          }
        ),
      ),
    );
  }}
