import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:momentoo/shared/helper/wave_background.dart';

class StoreDetailsScreen extends StatefulWidget {
  const StoreDetailsScreen({Key key}) : super(key: key);

  @override
  _StoreDetailsScreenState createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return WaveBackground(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Scaffold(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                ),
                Text('Back'),
              ],
            ),
          ),
        ),
        body: Column(
//          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50),
            Text(
              'Store Name',
              style: TextStyle(fontSize: 20, color: Colors.teal.shade900),
            ),
            Text(
              'Store Area',
              style: TextStyle(fontSize: 16, color: Colors.black38),
            ),
            Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.solidStar),
                Icon(FontAwesomeIcons.solidStar),
                Icon(FontAwesomeIcons.solidStar),
                Icon(FontAwesomeIcons.solidStar),
                Icon(FontAwesomeIcons.star),
                Spacer(
                  flex: 1,
                ),
                Text('(333 Reviews)')
              ],
            )
          ],
        ),
      ),
    );
  }
}
