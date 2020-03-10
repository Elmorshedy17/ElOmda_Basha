import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:momentoo/shared/helper/main_background.dart';

class SearchResultScreen extends StatelessWidget {
  final String title;

  const SearchResultScreen({this.title = 'SearchResultScreen'});
  @override
  Widget build(BuildContext context) {
    return MainBackground(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              children: <Widget>[Icon(Icons.arrow_back_ios), Text('Back')],
            ),
          ),
          title: Text(title),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.filter,
                  size: 15,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/filterScreen');
                }),
          ],
        ),
      ),
    );
  }
}
