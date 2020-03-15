import 'package:flutter/material.dart';

class FavoritesContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
      itemBuilder: (BuildContext context, int index) {
        return FittedBox(
          fit: BoxFit.fill,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 16),
                width: 200,
                height: 200,
                child: Card(
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/icon.png',
                        fit: BoxFit.fill,
                        width: 200,
                        height: 120,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('title'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('description'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('price'),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 15,
                  right: 5,
                  child: IconButton(
                      icon: Icon(
                        Icons.star,
                        color: Color(0xffF52B57),
                      ),
                      onPressed: () {}))
            ],
          ),
        );
      },
    );
  }
}

List<Widget> favoritesContent = [
  FavoritesContent(),
  FavoritesContent(),
  FavoritesContent(),
];
