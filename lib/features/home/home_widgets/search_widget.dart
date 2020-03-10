// import 'package:flutter/material.dart';

// OverlayEntry overlayEntry;

// class SearchWidget extends StatefulWidget {
//   @override
//   _SearchWidgetState createState() => _SearchWidgetState();
// }

// class _SearchWidgetState extends State<SearchWidget> {
//   OverlayState overlayState;

//   @override
//   Widget build(BuildContext context) {
//     overlayState = Overlay.of(context);
//     overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         child: Material(
//           color: Colors.transparent,
//           child: Card(
//             elevation: 5,
//             child: Container(
//               width: MediaQuery.of(context).size.width * 0.9,
//               height: 100,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     'SALAH SALAH',
//                     style: TextStyle(
//                       color: Colors.teal.shade900,
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text('SalahSalah@email.com'),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         top: MediaQuery.of(context).size.height * 0.18,
//         right: 0.0,
//         left: 0.0,
//       ),
//     );

//     return Container(
//       height: 55,
//       padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(19.0)),
//       ),
//       child: TextField(
//         onTap: () {
//           overlayState.insert(overlayEntry);
//         },
//         onSubmitted: (value) {
//           overlayEntry?.remove();
//         },
//         decoration: InputDecoration(
//             alignLabelWithHint: true,
//             filled: true,
//             border: InputBorder.none,
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.transparent),
//               borderRadius: const BorderRadius.all(
//                 const Radius.circular(10.0),
//               ),
//             ),
//             hintStyle: TextStyle(color: Colors.grey[600], fontSize: 13),
//             prefixIcon: Icon(
//               Icons.search,
//               color: Colors.teal[900],
//             ),
//             hintText: "Search...",
//             fillColor: Colors.white),
//       ),
//     );
//   }
// }
