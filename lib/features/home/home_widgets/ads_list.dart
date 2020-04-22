import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:momentoo/features/home/home_model.dart';
import 'package:momentoo/features/product_details/productDetails_screen.dart';

// Home Carousel
class CarouselWidgetHome extends StatefulWidget {
  final int categoryId;
  final List<Ads> adsList;

  const CarouselWidgetHome({@required this.categoryId, @required this.adsList});
  @override
  _CarouselWidgetHomeState createState() => _CarouselWidgetHomeState();
}

class _CarouselWidgetHomeState extends State<CarouselWidgetHome> {
  carouselImagesList() {
    List<NetworkImage> widgetCarousel = widget.adsList
        .map((slider) => new NetworkImage(
              slider.image,
            ))
        .toList();
    return widgetCarousel;
  }

  @override
  Widget build(BuildContext context) {
    return widget.adsList.length == 0
        ? Container()
        : Card(
            child: Container(
              margin: EdgeInsets.all(8),
              height: 150.0,
              width: double.infinity,
              child: Carousel(
                boxFit: BoxFit.fill,
                autoplay: true,
                animationCurve: Curves.fastOutSlowIn,
                animationDuration: Duration(milliseconds: 1000),
                dotSize: 4.0,
                dotIncreasedColor: Theme.of(context).primaryColor,
                dotBgColor: Colors.transparent,
                dotPosition: DotPosition.bottomCenter,
                dotVerticalPadding: 2.0,
                showIndicator: widget.adsList.length < 2 ? false : true,
                indicatorBgPadding: 2.0,
                images: carouselImagesList(),
                onImageTap: (int index) {
                  Navigator.of(context).pushNamed('/productDetailsScreen',
                      arguments: ProductDetailsArguments(
                        sellerId: widget.adsList[index].sellerId,
                        productId: widget.adsList[index].id,
                      ));
                  // if (carouselList[index].clinicId != 0) {
                  //   Navigator.push(context, MaterialPageRoute(builder: (_) {
                  //     return ClinicSectionsScreen(
                  //       id: carouselList[index].clinicId,
                  //     );
                  //   }));
                  // }
                },
              ),
            ),
          );
  }
}
