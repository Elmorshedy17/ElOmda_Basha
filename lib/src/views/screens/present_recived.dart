import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/theme_setting.dart';

class PresentRecived extends StatefulWidget {
  @override
  _PresentRecivedState createState() => _PresentRecivedState();
}

class _PresentRecivedState extends State<PresentRecived> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 55.0,
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
          height: 15.0,
        ),
        Container(
          height: MediaQuery.of(context).size.height /4,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width /5),
          child: Image.asset("assets/images/gift_vector.png",fit: BoxFit.fill,),
        ),
        SizedBox(
          height: 60.0,
        ),
        Text(
          "You recived a Prsent from admin",
          style: TextStyle(
            fontSize: MainFont,
            fontWeight: bolFont
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Present Details : ",
              style: TextStyle(
                  fontSize: PrimaryFont,
                  fontWeight: bolFont
              ),
            ),
            Text(
              "20 Medicine Packages - Panadol",
              style: TextStyle(
                  fontSize: PrimaryFont,
                  fontWeight: semiFont,
                color: lightText
              ),
            ),
          ],
        ),
        SizedBox(
          height: 60.0,
        ),
        Row(
          children: <Widget>[



            Expanded(
              child:
              ButtonTheme(
                height: 60.0,
                child: FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                  color: Theme.of(context).accentColor,
                  child:
                  FittedBox(
                    child: Text( "Go to Wallet",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MainFont,
                        fontWeight: semiFont,
                      ),
                    ),
                  ),
                  onPressed: (){
                  },
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),

            Expanded(
              child:
              ButtonTheme(
                height: 60.0,
                child: OutlineButton(
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
//                    color: Theme.of(context).primaryColor,
                  child:
                  FittedBox(
                    child:   Text(
                      "Go Home",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: MainFont,
                        fontWeight: semiFont,
                      ),
                    ),
                  ),
                  onPressed: (){},
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, //Color of the border
                    style: BorderStyle.solid, //Style of the border
                    width: 1.5, //width of the border
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ),
),
    );
  }
}
