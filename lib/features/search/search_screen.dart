// import 'package:flutter/material.dart';
// import 'package:momentoo/features/search/search_manager.dart';
// import 'package:momentoo/features/search/search_model.dart';
// import 'package:momentoo/shared/helper/locator.dart';
// import 'package:momentoo/shared/helper/main_background.dart';
// import 'package:momentoo/shared/helper/observer_widget.dart';
// import 'package:momentoo/shared/services/localizations/app_localizations.dart';
// import 'package:momentoo/shared/services/prefs_service.dart';

// class SearchScreenArguments {
//   final int categoryId;

//   SearchScreenArguments({@required this.categoryId});
// }

// class SearchScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     SearchScreenArguments args = ModalRoute.of(context).settings.arguments;
//     locator<SearchManager>().inCategoryId.add(args.categoryId);
//     locator<SearchManager>().inQuery.add(locator<TextEditingController>().text);

//     return MainBackground(
//       height: MediaQuery.of(context).size.height * 0.3,
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0.0,
//           leading: InkWell(
//             onTap: () {
//               locator<TextEditingController>().clear();
//               Navigator.of(context).pop();
//             },
//             child: Row(
//               children: <Widget>[
//                 Icon(Icons.arrow_back_ios),
//                 Text(
//                   AppLocalizations.of(context).translate('back_str'),
//                   style: TextStyle(
//                     fontFamily: locator<PrefsService>().appLanguage == 'en'
//                         ? 'en'
//                         : 'ar',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           title: Text(
//             AppLocalizations.of(context).translate('search_str'),
//             style: TextStyle(
//               fontFamily:
//                   locator<PrefsService>().appLanguage == 'en' ? 'en' : 'ar',
//             ),
//           ),
//           centerTitle: true,
//         ),
//         body: Column(
//           children: <Widget>[
//             Container(
//               height: 55,
//               padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(19.0)),
//               ),
//               child: TextField(
//                 controller: locator<TextEditingController>(),
//                 onTap: () {},
//                 onChanged: (v) {
//                   locator<SearchManager>()
//                       .inQuery
//                       .add(locator<TextEditingController>().text);
//                 },
//                 onSubmitted: (value) {},
//                 decoration: InputDecoration(
//                     alignLabelWithHint: true,
//                     filled: true,
//                     border: InputBorder.none,
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.transparent),
//                       borderRadius: const BorderRadius.all(
//                         const Radius.circular(10.0),
//                       ),
//                     ),
//                     hintStyle: TextStyle(
//                       color: Colors.grey[600],
//                       fontSize: 13,
//                       fontFamily: locator<PrefsService>().appLanguage == 'en'
//                           ? 'en'
//                           : 'ar',
//                     ),
//                     prefixIcon: Icon(
//                       Icons.search,
//                       color: Colors.teal[900],
//                     ),
//                     hintText:
//                         AppLocalizations.of(context).translate('search..._str'),
//                     fillColor: Colors.white),
//               ),
//             ),
//             Expanded(
//               child: Card(
//                 elevation: 5,
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * 0.9,
//                   height: MediaQuery.of(context).size.height,
//                   child: CustomObserver(
//                     stream: locator<SearchManager>().searchResult$,
//                     onSuccess: (_, SearchModel model) => ListView.separated(
//                       shrinkWrap: true,
//                       itemCount: model.data.products?.length ?? 0,
//                       separatorBuilder: (BuildContext context, int index) {
//                         return Divider(
//                           color: Colors.grey,
//                         );
//                       },
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           onTap: () {
//                             Navigator.of(context)
//                                 .pushNamed('/searchResultScreen');
//                           },
//                           title: Text(model.data.products[index].name),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
