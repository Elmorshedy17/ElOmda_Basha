import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:medicine/localizations/app_localizations.dart';
import 'package:medicine/service/api.dart';
import 'package:medicine/service/prefs_Service.dart';
import 'package:medicine/service/service_locator.dart';
import 'package:medicine/src/blocs/api_blocs/show_service_bloc.dart';
import 'package:medicine/theme_setting.dart';
void main() {
  int a;
  a = null;
  print('a is $a.');
}

DateTime fromDate ;

final now = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
// final ToastTemplate _showToast = locator<ToastTemplate>();
final yesterday = DateTime(now.year, now.month, now.day - 1);
final prefs = locator<PrefsService>();

class ShowServiceScreen extends StatefulWidget {




  @override
  _ShowServiceScreenState createState() => _ShowServiceScreenState();
}

class _ShowServiceScreenState extends State<ShowServiceScreen> {

  void filterBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15),
            child: new Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        main();
                        locator<ShowServiceBloc>().showServiceClear();
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: Text(prefs.appLanguage == "en" ? "Rest":"اعاده تهيئه",style: TextStyle(color: Colors.redAccent),),
                      ),
                    ),
                  ],
                ),
                _fromToDate(context),
                SizedBox(height: 15,),
                ButtonTheme(
                  height: 40.0,
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0)),
//                    color: Theme.of(context).primaryColor,
                    child: FittedBox(
                      child: Text(
                        AppLocalizations.of(context)
                            .translate("Filter_str"),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: PrimaryFont,
                          fontWeight: regFont,
                        ),
                      ),
                    ),

                    onPressed: () {

                      print("startDateFilterBloc => ${locator<ShowServiceBloc>().startDateFilterBloc.value}");
                      print("endDateFilterBloc => ${locator<ShowServiceBloc>().endDateFilterBloc.value}");

                      setState(() {
                      });
                      Navigator.pop(context);
                    },
                  ),
                )




              ],
            ),
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(AppLocalizations.of(context).translate("soled_packages")),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: InkWell(
              onTap: (){
                // locator<ShowServiceBloc>().showServiceClear();
                filterBottomSheet(context);
              },
              child: Icon(Icons.filter_alt_outlined,color: Colors.white,),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: FutureBuilder(
            future: ApiService.ShowServicesApi(),
            builder: (context,AsyncSnapshot snapshot) {
              return snapshot.hasData ? ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (BuildContext context, int index){

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Image.network(
                        snapshot.data.data[index].image,
                     fit: BoxFit.fill,
                     height: 75.0,
                     width: 75.0,
                   ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data.data[index].title,style: TextStyle(fontSize: 18),),
                            SizedBox(
                              width: 15,
                            ),
                            Row(
                              children: [
                                Text(" ${snapshot.data.data[index].solidTotal} ",style: TextStyle(fontSize: 18),),
                                Text(" ${AppLocalizations.of(context).translate("soled_packages") }",style: TextStyle(fontSize: 15,color: Colors.blueGrey),),
                              ],
                            )

                          ],
                        )
                      ],
                    ) ;
                  }
              ):Container();
            }),
      ),
    );
  }
}


Widget _fromToDate(context){
  return Row(
    children: [
      Expanded(
        child: Center(
          child: StreamBuilder(
              initialData: "",
              stream: locator<ShowServiceBloc>().startDateFilterBloc.stream,
              builder: (context, startDateSnapshot) {
                return TextButton(
                    onPressed: () {

                      Future<void> _selectDate(BuildContext context) async {
                        final DateTime picked = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2019, 8),
                          initialDate: DateTime(now.year, now.month, now.day ),
                          lastDate: new DateTime(now.year + 1, now.month, now.day ),);
                        if(picked != null){
                          fromDate = picked;
                          print("picked${picked}");
                          locator<ShowServiceBloc>().startDateFilterBloc.sink.add(formatter.format(picked));

                        }
                      }
                      _selectDate(context);
                    },
                    child: Column(
                      children: [
                        Text(
                          prefs.appLanguage == "en" ? "From Date":"من تاريخ",
                          style: TextStyle(color: Colors.blue),
                        ),

                        Text(
                          startDateSnapshot.data,
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ));
              }
          ),
        ),
      ),


      Expanded(
        child: Center(
          child: StreamBuilder(
            initialData: "",
              stream: locator<ShowServiceBloc>().endDateFilterBloc.stream,
              builder: (context, startDateSnapshot) {
                return TextButton(
                    onPressed: () {

                      Future<void> _selectDate(BuildContext context) async {
                        final DateTime picked = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2019, 8),
                          initialDate: DateTime(now.year, now.month, now.day ),
                          lastDate: new DateTime(now.year + 1, now.month, now.day ),);
                        if(locator<ShowServiceBloc>().startDateFilterBloc.value != ""){
                          if(picked.isAfter(fromDate)){
                            if(picked != null){
                              print("picked${picked}");
                              locator<ShowServiceBloc>().endDateFilterBloc.sink.add(formatter.format(picked));
                              // tripsManager.tripDateId.sink.add(formatter.format(picked));
                              // Navigator.pop(context);

                            }
                          }else{
                            Fluttertoast.showToast(
                                msg: prefs.appLanguage == "en" ? "select from date first":"برجاء اختيار من التاريخ اولا",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                        }else{
                          Fluttertoast.showToast(
                              msg: prefs.appLanguage == "en" ? "select from date first":"برجاء اختيار من التاريخ اولا",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }


                      }
                      _selectDate(context);
                    },
                    child: Column(
                      children: [
                        Text(
                          prefs.appLanguage == "en" ? "To Date":"الي تاريخ",
                          style: TextStyle(color: Colors.blue),
                        ),

                        Text(
                          startDateSnapshot.data,
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ));
              }
          ),
        ),
      ),

    ],
  );

}
