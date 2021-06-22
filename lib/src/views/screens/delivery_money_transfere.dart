import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/src/views/screens/my_account.dart';
import 'package:medicine/theme_setting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

class DeliveryMoneyTransfere extends StatefulWidget {
  @override
  _DeliveryMoneyTransfereState createState() => _DeliveryMoneyTransfereState();
}

class _DeliveryMoneyTransfereState extends State<DeliveryMoneyTransfere> {
  File imageUpload;

  BehaviorSubject isDialogAdd = new BehaviorSubject.seeded(false);

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageUpload = image;
    });
  }

  TextEditingController moneyController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  String transferePicture = "Transfere Picture";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(AppLocalizations.of(context).translate("Money Transfere")),
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
      body: StreamBuilder(
          stream: isDialogAdd.stream,
          builder: (context, snapshot) {
            return Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15.0),
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 75.0,
                      ),
                      Container(
                        child: Image.asset(
                          "assets/images/money.png",
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      TextField(
                        controller: nameController,
//              keyboardType: TextInputType.number,
                        //  onChanged: signupBloc.changeName,
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)
                                .translate("Name of person Transfered for"),
                            labelText: AppLocalizations.of(context)
                                .translate("Name of person Transfered for"),

                            //errorText: snapshot.error,
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      InkWell(
                        onTap: () {
                          getImage();

//            setState(() {
////              transferePicture = imageUpload.path.split('/').last;
//            });
                        },
                        child: Container(
                          height: 60.0,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 0.80),
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  transferePicture,
                                  style: TextStyle(
                                      color: lightText,
                                      fontSize: PrimaryFont,
                                      fontWeight: semiFont),
                                ),
                              ),
                              Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                                size: 35,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: imageUpload == null
                            ? Text(AppLocalizations.of(context)
                                .translate("No image selected."))
                            : Image.file(imageUpload),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 3.0),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('optional_str'),
                              style: TextStyle(
                                fontSize: SecondaryFont,
                                fontWeight: semiFont,
                                color: Theme.of(context).primaryColor,
                                // decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "${AppLocalizations.of(context).translate("currency_in_real")}",
                        style: TextStyle(
                            color: Colors.redAccent
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: moneyController,
                        keyboardType: TextInputType.number,
                        //  onChanged: signupBloc.changeName,
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)
                                .translate("Amount"),
                            labelText: AppLocalizations.of(context)
                                .translate("Amount"),
                            //errorText: snapshot.error,
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      Container(
                        width: double.infinity,
                        child: ButtonTheme(
                          height: 60.0,
                          child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15.0)),
//                    color: Theme.of(context).primaryColor,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("Transfere_str"),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: MainFont,
                                fontWeight: semiFont,
                              ),
                            ),
                            onPressed: () {
                              print(imageUpload);
                              isDialogAdd.add(true);

                              ApiService.SendTransfer(
                                      imageUpload,
                                      imageUpload == null
                                          ? null
                                          : imageUpload.path,
                                      moneyController.text,
                                      nameController.text)
                                  .then((data) {
                                print(data);
                                isDialogAdd.add(false);

                                // showDialog(
                                //   context: context,
                                //   builder: (BuildContext context) {
                                //     return AlertDialog(
                                //       title: Text(data.msg),
                                //     );
                                //   },
                                // );
                                Fluttertoast.showToast(
                                    msg: data.msg,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                                if(data.key == "1"){
                                             Navigator.pushReplacement(
               context,
               new MaterialPageRoute(
                   builder: (BuildContext
                   context) => MyAccount()
               ));
                                }

                              });

//        ApiService.MoneyRequest(moneyController.text).then((data) {
////              locator<UserIdBloc>().UserIdSink.add(data.data.id.toString().toString());
//          data.key == "1" ?   _showSuccesDialog()
//              : showDialog(
//            context: context,
//            builder: (BuildContext context) {
//              return AlertDialog(
//                title:  Text(data.msg),
//              );
//            },
//          );});
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                isDialogAdd.value == true
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black.withOpacity(0.5),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : Container(),
              ],
            );
          }),
    );
  }
}
