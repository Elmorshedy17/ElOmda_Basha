import 'package:flutter/material.dart';
import 'package:momentoo/features/favorites/favoriteActions_manager.dart';
import 'package:momentoo/features/favorites/favorites_manager.dart';
import 'package:momentoo/features/favorites/favorites_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

class FavoritesContent extends StatelessWidget {
  final int pageIndex;
  final List<Categories> categories;

  const FavoritesContent(
      {Key key, @required this.pageIndex, @required this.categories})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: categories[pageIndex].products?.length ?? 0,
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
                height: 210,
                child: Card(
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.network(
                        categories[pageIndex].products[index].image,
                        fit: BoxFit.fill,
                        width: 200,
                        height: 120,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          categories[pageIndex].products[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily:
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          categories[pageIndex].products[index].section,
                          style: TextStyle(
                            fontFamily:
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'en'
                                    : 'ar',
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 8.0),
                      //   child: Text('price'),
                      // ),
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
                  onPressed: () {
                    locator<FavoritesActionsManager>().addOrRemoveFavorite(
                        'product',
                        'remove',
                        categories[pageIndex].products[index].id.toString());
                    locator<FavoritesManager>().getData();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// List<Widget> favoritesContent = [
//   FavoritesContent(),
//   FavoritesContent(),
//   FavoritesContent(),
// ];
