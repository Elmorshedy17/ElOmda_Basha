// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:medicine/localizations/app_localizations.dart';
// import 'package:medicine/service/service_locator.dart';
// import 'package:medicine/src/blocs/user_type_bloc.dart';
// import 'package:medicine/src/views/screens/delivery_money_transfere.dart';
// import 'package:medicine/src/views/screens/money_transform.dart';
// import 'package:medicine/theme_setting.dart';
//
// class Wallet extends StatefulWidget {
//   var data;
//   Wallet(this.data);
//   @override
//   _WalletState createState() => _WalletState();
// }
//
// class _WalletState extends State<Wallet> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: Text(AppLocalizations.of(context).translate("Wallet")),
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios,
//             size: 25.0,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Stack(
//         children: <Widget>[
//           Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             //     color: Colors.yellow,
//           ),
//           Container(
//             child: ClipRRect(
//               borderRadius:
//                   BorderRadius.only(bottomRight: Radius.circular(50.0)),
//               child: Container(
//                 height: 100.0,
//                 color: Theme.of(context).primaryColor,
//               ),
//             ),
//           ),
//           Positioned(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             top: 30.0,
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: SingleChildScrollView(
//                 child: Wrap(
//                   children: <Widget>[
//                     _firstStatistics(),
//                     Container(
//                       height: 15.0,
//                     ),
//                     _secondStatistics(),
//                  Container(
//                    height: 15.0,
//                  ),
//                     locator<UserTypeBloc>().currentUserType !="delegate"?  _thidStatistics():Container(),
//                     Container(
//                       height: 15.0,
//                     ),
//                     _transfrerOrder(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _firstStatistics() {
//     return Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         elevation: 2.0,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20.0),
//           child: Row(
//             children: <Widget>[
//               Expanded(
//                 child: Wrap(
//                   children: <Widget>[
//                     Center(
//                         child: Text(
//                           AppLocalizations.of(context).translate("Tottal_Amount_str"),
//                       style:
//                           TextStyle(fontWeight: bolFont, fontSize: MediumFont),
//                     )),
//                     Container(
//                       height: 15.0,
//                     ),
//                     Center(
//                         child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Text(
// //                          "1000",
//                          widget.data.totalCommission.toString(),
//                           style: TextStyle(
//                               fontWeight: semiFont,
//                               fontSize: PrimaryFont,
//                               color: Colors.redAccent),
//                         ),
//                         SizedBox(
//                           width: 5.0,
//                         ),
//                         Text(
//                           "RS",
//                           style: TextStyle(
//                               fontWeight: semiFont,
//                               fontSize: SecondaryFont,
//                               color: lightText),
//                         ),
//                       ],
//                     )),
//                   ],
//                 ),
//               ),
//               locator<UserTypeBloc>().currentUserType !="delegate"?    Container(
//                 height: 45.0,
//                 child: VerticalDivider(
//                   color: Colors.blue,
//                 ),
//               ):Container(),
//               locator<UserTypeBloc>().currentUserType !="delegate"?   Expanded(
//                 child: Wrap(
//                   children: <Widget>[
//                     Center(
//                         child: Text( AppLocalizations.of(context).translate('Total_Points_str')
//                       ,
//                       style:
//                           TextStyle(fontWeight: bolFont, fontSize: MediumFont),
//                     )),
//                     Container(
//                       height: 15.0,
//                     ),
//                     Center(
//                         child: Text(
//                         widget.data.totalPoint.toString(),
//                             //"2,4243",
//                             style: TextStyle(
//                                 fontWeight: semiFont,
//                                 fontSize: PrimaryFont,
//                                 color: Colors.redAccent))),
//                   ],
//                 ),
//               ):Container(),
//             ],
//           ),
//         ));
//   }
//
//   Widget _secondStatistics() {
//     return Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         elevation: 2.0,
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Wrap(
//             children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   Image.asset(
//                     "assets/images/cost.png",
//                     height: 25.0,
//                     width: 25.0,
//                   ),
//                   SizedBox(
//                     width: 8.0,
//                   ),
//                   Text(
//                     AppLocalizations.of(context).translate("Amounts_str") ,
//                     style: TextStyle(fontWeight: bolFont, fontSize: MediumFont),
//                   ),
//                 ],
//               ),
//               Container(
//                 height: 25.0,
//               ),
//               ////1 ////
//               Container(
//                 margin: EdgeInsets.only(bottom: 10.0),
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: Text(
//                         AppLocalizations.of(context).translate("Tottal_Recived_Amounts_str") ,
//                         style: TextStyle(
//                             fontWeight: bolFont, fontSize: MediumFont),
//                       ),
//                     ),
//                     Expanded(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: <Widget>[
//                           Text(
//                             widget.data.totalCommission.toString(),
//                             style: TextStyle(
//                                 fontWeight: semiFont,
//                                 fontSize: PrimaryFont,
//                                 color: Colors.redAccent),
//                           ),
//                           SizedBox(
//                             width: 8.0,
//                           ),
//                           Text(
//                             AppLocalizations.of(context).translate("real_suadi"),
//                             style: TextStyle(
//                                 fontSize: PrimaryFont,
//                                 fontWeight: semiFont,
//                                 color: lightText),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               ////2 ////
//               Container(
//                 margin: EdgeInsets.only(bottom: 10.0),
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: Text(
//                         AppLocalizations.of(context).translate("Tottal_Worthy_Amounts_str") ,
//                         style: TextStyle(
//                             fontWeight: bolFont, fontSize: MediumFont),
//                       ),
//                     ),
//                     Expanded(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: <Widget>[
//                           Text(
//                             widget.data.needCommission.toString(),
//                             style: TextStyle(
//                                 fontWeight: semiFont,
//                                 fontSize: PrimaryFont,
//                                 color: Colors.redAccent),
//                           ),
//                           SizedBox(
//                             width: 8.0,
//                           ),
//                           Text(
//                             AppLocalizations.of(context).translate("real_suadi"),
//                             style: TextStyle(
//                                 fontSize: PrimaryFont,
//                                 fontWeight: semiFont,
//                                 color: lightText),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               ////3 ////
//               Container(
//                 margin: EdgeInsets.only(bottom: 10.0),
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: FittedBox(
//                         child: Text(
//                           AppLocalizations.of(context).translate("Tottal_Transfered_Amounts_str") ,
//                           style: TextStyle(
//                               fontWeight: bolFont, fontSize: MediumFont),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: <Widget>[
//                           Text(
//                             (widget.data.totalCommission - widget.data.needCommission).toString(),
//                             style: TextStyle(
//                                 fontWeight: semiFont,
//                                 fontSize: PrimaryFont,
//                                 color: Colors.redAccent),
//                           ),
//                           SizedBox(
//                             width: 8.0,
//                           ),
//                           Text(
//                             AppLocalizations.of(context).translate("real_suadi") ,
//                             style: TextStyle(
//                                 fontSize: PrimaryFont,
//                                 fontWeight: semiFont,
//                                 color: lightText),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
//
//   Widget _thidStatistics() {
//     return Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         elevation: 2.0,
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Wrap(
//             children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   Image.asset(
//                     "assets/images/medicines.png",
//                     height: 25.0,
//                     width: 25.0,
//                   ),
//                   SizedBox(
//                     width: 8.0,
//                   ),
//                   Text(
//                     AppLocalizations.of(context).translate("Medecine_Packages_str") ,
//                     style: TextStyle(fontWeight: bolFont, fontSize: MediumFont),
//                   ),
//                 ],
//               ),
//               Container(
//                 height: 25.0,
//               ),
//               Container(
//                 margin: EdgeInsets.only(bottom: 10.0),
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: Text(
//                         AppLocalizations.of(context).translate("Tottal_Recived_Packages_str") ,
//                         style: TextStyle(
//                             fontWeight: bolFont, fontSize: MediumFont),
//                       ),
//                     ),
//                     Expanded(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: <Widget>[
//                           Text(
//                             widget.data.doneGifts.toString(),
//                             style: TextStyle(
//                                 fontWeight: semiFont,
//                                 fontSize: PrimaryFont,
//                                 color: Colors.redAccent),
//                           ),
//                           SizedBox(
//                             width: 8.0,
//                           ),
//                           Text(
//                             AppLocalizations.of(context).translate("package")  ,
//                             style: TextStyle(
//                                 fontSize: PrimaryFont,
//                                 fontWeight: semiFont,
//                                 color: lightText),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(bottom: 10.0),
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: Text(
//                         AppLocalizations.of(context).translate("Tottal_Rested_Amounts_str"),
//                         style: TextStyle(
//                             fontWeight: bolFont, fontSize: MediumFont),
//                       ),
//                     ),
//                     Expanded(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: <Widget>[
//                           Text(
//                             widget.data.needGifts.toString(),
//                             style: TextStyle(
//                                 fontWeight: semiFont,
//                                 fontSize: PrimaryFont,
//                                 color: Colors.redAccent),
//                           ),
//                           SizedBox(
//                             width: 8.0,
//                           ),
//                           Text(
//                             AppLocalizations.of(context).translate("package"),
//                             style: TextStyle(
//                                 fontSize: PrimaryFont,
//                                 fontWeight: semiFont,
//                                 color: lightText),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
//
//   Widget _transfrerOrder(){
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       elevation: 2.0,
//     child: Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: ListTile(
//           dense: true,
//         onTap: (){
//
//           Navigator.push(
//               context,
//               new MaterialPageRoute(
//                   builder: (BuildContext context) => locator<UserTypeBloc>().currentUserType !="delegate"? MoneyTransform():DeliveryMoneyTransfere()));
//         },
//         leading:  Image.asset(
//           "assets/images/payment.png",
//           height: 25.0,
//           width: 25.0,
//         ),
//         title: Align(
//           child: Text(
//             locator<UserTypeBloc>().currentUserType !="delegate"?  AppLocalizations.of(context).translate("Amount_Transfere_Orders_str") : AppLocalizations.of(context).translate("Amount_Transfere_str") ,
//             style:
//             TextStyle(fontWeight: bolFont, fontSize: MediumFont),
//           ),
//           alignment: Alignment(-1.2, 0),
//         ),
//         trailing: Icon(Icons.arrow_forward_ios),
//       ),
//     ),
//     );
//   }
// }
