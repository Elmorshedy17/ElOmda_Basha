import 'package:flutter/material.dart';

class MainBackground extends StatelessWidget {
  final Widget child;
  final double height;

  const MainBackground({@required this.child, @required this.height});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
          ),
        ),
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: height,
            color: Colors.transparent,
            child: Image.asset(
              'assets/images/home_header.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        child,
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////////////////

// class CurvedBottomClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     // I've taken approximate height of curved part of view
//     // Change it if you have exact spec for it
//     final roundingHeight = size.height * 3 / 7;

//     // this is top part of path, rectangle without any rounding
//     final filledRectangle =
//         Rect.fromLTRB(0, 0, size.width, size.height - roundingHeight);

//     // this is rectangle that will be used to draw arc
//     // arc is drawn from center of this rectangle, so it's height has to be twice roundingHeight
//     // also I made it to go 5 units out of screen on left and right, so curve will have some incline there
//     final roundingRectangle = Rect.fromLTRB(
//         -5, size.height - roundingHeight * 2, size.width + 5, size.height);

//     final path = Path();
//     path.addRect(filledRectangle);

//     // so as I wrote before: arc is drawn from center of roundingRectangle
//     // 2nd and 3rd arguments are angles from center to arc start and end points
//     // 4th argument is set to true to move path to rectangle center, so we don't have to move it manually
//     path.arcTo(roundingRectangle, pi, -pi, true);
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     // returning fixed 'true' value here for simplicity, it's not the part of actual question, please read docs if you want to dig into it
//     // basically that means that clipping will be redrawn on any changes
//     return true;
//   }
// }
