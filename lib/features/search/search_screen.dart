import 'package:flutter/material.dart';
import 'package:momentoo/shared/helper/main_background.dart';

class SearchScreen extends StatelessWidget {
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
          title: Text('Search'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 55,
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(19.0)),
              ),
              child: TextField(
                onTap: () {},
                onSubmitted: (value) {},
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    filled: true,
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    hintStyle: TextStyle(color: Colors.grey[600], fontSize: 13),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.teal[900],
                    ),
                    hintText: "Search...",
                    fillColor: Colors.white),
              ),
            ),
            Expanded(
              child: Card(
                elevation: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed('/searchResultScreen');
                        },
                        title: Text('Name'),
                        subtitle: Text('Salah'),
                      ),
                      ListTile(
                        title: Text('Name'),
                        subtitle: Text('Salah'),
                      ),
                      ListTile(
                        title: Text('Name'),
                        subtitle: Text('Salah'),
                      ),
                      ListTile(
                        title: Text('Name'),
                        subtitle: Text('Salah'),
                      ),
                      ListTile(
                        title: Text('Name'),
                        subtitle: Text('Salah'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
