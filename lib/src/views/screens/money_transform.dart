import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/theme_setting.dart';
import 'package:rxdart/rxdart.dart';

class MoneyTransform extends StatefulWidget {
  @override
  _MoneyTransformState createState() => _MoneyTransformState();
}

class _MoneyTransformState extends State<MoneyTransform> {

  TextEditingController moneyController = TextEditingController();

  BehaviorSubject isDialogAdd = new BehaviorSubject.seeded(false);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text(AppLocalizations.of(context).translate("Money_Transfere_Order_str")),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 25.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: StreamBuilder(
          stream: isDialogAdd.stream,
          builder: (context, snapshot) {
          return Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15.0),
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 30.0,
                    ),
//                    Row(
//                      children: <Widget>[
//                        IconButton(
//                          icon: Icon(
//                            Icons.arrow_back_ios,
//                            size: 25.0,
//                          ),
//                          onPressed: () {
//                            Navigator.pop(context);
//                          },
//                        ),
//                      ],
//                    ),
                    SizedBox(
                      height: 50.0,
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
                    _moeneyTransFiled(),
                    SizedBox(
                      height: 30.0,
                    ),

                    _submitButtom(),
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

  }

  Widget _moeneyTransFiled() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              hintText: AppLocalizations.of(context).translate("Amount_of_money_str") ,
              labelText: AppLocalizations.of(context).translate("Amount_of_money_str") ,
              //errorText: snapshot.error,
              border: OutlineInputBorder()),
        ),
      ],
    );
  }



  _submitButtom(){
    return Container(
      width: double.infinity,
      child:
      ButtonTheme(
        height: 60.0,
        child: RaisedButton(
          color: Theme.of(context).accentColor,
          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
//                    color: Theme.of(context).primaryColor,
          child:
          Text(
            AppLocalizations.of(context).translate("Send_Order_str") ,
            style: TextStyle(
              color: Colors.white,
              fontSize: MainFont,
              fontWeight: semiFont,
            ),
          ),
          onPressed: (){
            isDialogAdd.add(true);

            ApiService.MoneyRequest(moneyController.text).then((data) {
              isDialogAdd.add(false);

//              locator<UserIdBloc>().UserIdSink.add(data.data.id.toString().toString());
              data.key == "1" ?   _showSuccesDialog()
                  : showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title:  Text(data.msg),
                  );
                },
              );});

          },
        ),
      ),
    );
  }

  Widget _showSuccesDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return Container(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              // contentPadding: EdgeInsets.only(top: 10.0),
              title: Image.asset("assets/images/money.png",),
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
                    child: Text(AppLocalizations.of(context).translate("Your message has been sent succesfuly to admin"),style: TextStyle(
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

            ),
          );
        }
    );
  }
  void dispose() {
    moneyController.dispose();
    super.dispose();
  }
}
