import 'package:flutter/material.dart';
import 'package:momentoo/features/home/home_widgets/ads_list.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Ads'),
        ),
        // Ads
        CardsHorizontalList(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Trending'),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/trendingStoresScreen');
                },
                child: Text('View all >>'),
              )
            ],
          ),
        ),
        // Trending
        CardsHorizontalList(),
      ],
    );
  }
}

List<Widget> content = [
  HomeContent(),
  HomeContent(),
  HomeContent(),
];
