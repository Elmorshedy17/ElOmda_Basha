import 'package:flutter/material.dart';

// Colors
const drawerColor = const Color(0xFFffffff);
const primaryColor = const Color(0xFF166EDC);
const accentColor = const Color(0xFFFF6768);
const lightText = const Color(0xFF888888); // light grey
const blackColor = const Color(0xFF000000); // grey color
/////
const darkGrey = const Color(0xFF495059); // dark grey
const midGrey = const Color(0xFF707070); // dark grey
const greyBlue = const Color(0xFF454D53); // grey blue
const littleGrey = const Color(0xFF95989A); // grey blue
Color dividerColor = Colors.blue[100];

//
//// Font Sizes
//const PrimaryFont = 30.0;
//const SecondaryFont = 24.0;
//const MainFont = 40.0;
//const MediumFont = 35.0;
//const LargeFont = 50.0;

//
//// Font Sizes
const PrimaryFont = 16.0;
const SecondaryFont = 14.0;
const MainFont = 20.0;
const MediumFont = 18.0;
const LargeFont = 24.0;
//
// Font weights
FontWeight regFont = FontWeight.w400;
FontWeight medFont = FontWeight.w500;
FontWeight semiFont = FontWeight.w600;
FontWeight bolFont = FontWeight.w700;


class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = MediaQuery.of(context).size.width;
        final dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}