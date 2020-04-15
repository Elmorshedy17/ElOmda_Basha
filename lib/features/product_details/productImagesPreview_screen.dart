import 'dart:math';

import 'package:flutter/material.dart';
import 'package:momentoo/features/product_details/productDetails_model.dart';
import 'package:momentoo/shared/helper/locator.dart';
import 'package:momentoo/shared/services/prefs_service.dart';

int currentPageIndex = 0;

class ProductImagesScreen extends StatefulWidget {
  final List<Images> images;

  ProductImagesScreen({@required this.images});

  @override
  _ProductImagesScreenState createState() => _ProductImagesScreenState();
}

class _ProductImagesScreenState extends State<ProductImagesScreen> {
  PageController _productImagesController;

  @override
  void initState() {
    super.initState();
    _productImagesController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    _productImagesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView.builder(
            itemCount: widget.images?.length ?? 0,
            controller: _productImagesController,
            scrollDirection: Axis.horizontal,
            // physics: BouncingScrollPhysics(),
            onPageChanged: (index) {
              currentPageIndex = index;
            },
            itemBuilder: (_, index) {
              return Scaffold(
                body: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      widget.images[index].image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              );
            }),
        Positioned(
          bottom: 13,
          right: 0,
          left: 0,
          child: Container(
            color: Colors.transparent,
            child: DotsIndicator(
              controller: _productImagesController,
              itemCount:
                  widget.images.length > 1 ? widget.images?.length ?? 0 : 0,
            ),
          ),
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
// An Indicator showing the currently selected page of a PageController.
class DotsIndicator extends AnimatedWidget {
  /// The pageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController.
  final int itemCount;

  /// Called when a dot is tapped.
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to 'Colors.white'.
  final Color color;

  DotsIndicator(
      {this.controller,
      this.itemCount,
      this.onPageSelected,
      this.color: Colors.white})
      : super(listenable: controller);

  // The base size of the dots.
  static const double _DOT_SIZE = 13.0;

  // The increase in the size of selected dot.
  static const double _MAX_ZOOM = 2.0;

  // The distance between the center of each dot.
  static const double _DOT_SPACING = 10.0;

  Widget _buildDot(int index) {
    double selectness = Curves.easeOut.transform(
      max(0.0,
          1.0 - ((controller.page ?? controller.initialPage) - index).abs()),
    );
    double zoom = 1.0 + (_MAX_ZOOM - 1.0) * selectness;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1),
      width: _DOT_SIZE,
      child: Center(
        child: Material(
          color:
              index == currentPageIndex ? Colors.teal.shade900 : Colors.black12,
          type: MaterialType.circle,
          child: Container(
            width: _DOT_SPACING,
            height: 8 * zoom,
            // child: InkWell(
            //   onTap: () => onPageSelected(index),
            // ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runAlignment: WrapAlignment.center,
      alignment: WrapAlignment.center,
      verticalDirection: VerticalDirection.down,
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      textDirection: locator<PrefsService>().appLanguage == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      children: List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
