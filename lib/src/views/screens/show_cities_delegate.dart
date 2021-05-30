import 'package:flutter/material.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/src/models/super_visor_marketers/show_cities_delgates.dart';
import 'package:medicine/src/views/screens/delegates_from_city.dart';


class ShowCitiesDelegates extends StatefulWidget {


  @override
  _ShowCitiesDelegatesState createState() =>
      _ShowCitiesDelegatesState();
}

class _ShowCitiesDelegatesState extends State<ShowCitiesDelegates> {


  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(AppLocalizations.of(context).translate("cities_delegates")),
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
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: FutureBuilder<ShowCitiesDelegatesModel>(
            future: ApiService.ShowCitiesDelegatesApi(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Container(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) => CityDelegates(snapshot.data.data[index])));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text("${snapshot.data.data[index].title}",style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),),
                      ),
                    );
                  },
                ),
              )
                  : Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
