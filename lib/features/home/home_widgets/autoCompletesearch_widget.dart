import 'package:flutter/material.dart';
import 'package:momentoo/features/home/autoComplete_manager.dart';
// import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:momentoo/shared/helper/locator.dart';
// import 'package:momentoo/shared/helper/observer_widget.dart';

// OverlayEntry overlayEntry;

class AutoCompleteSearchWidget extends StatefulWidget {
  final int categoryId;

  const AutoCompleteSearchWidget({
    @required this.categoryId,
  });
  @override
  _AutoCompleteSearchWidgetState createState() =>
      _AutoCompleteSearchWidgetState();
}

class _AutoCompleteSearchWidgetState extends State<AutoCompleteSearchWidget> {
  // OverlayState overlayState;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // overlayState = Overlay.of(context);
    // overlayEntry = OverlayEntry(
    //   builder: (context) => Positioned(
    //     child: Material(
    //       color: Colors.transparent,
    //       child: Card(
    //         elevation: 5,
    //         child: Container(
    //             width: MediaQuery.of(context).size.width * 0.9,
    //             height: MediaQuery.of(context).size.height * 0.4,
    //             child: CustomObserver(
    //               stream: locator<SearchManager>().searchResult$,
    //               onSuccess: (_, SearchModel model) => ListView.separated(
    //                 itemCount: model.data.words?.length ?? 0,
    //                 separatorBuilder: (BuildContext context, int index) {
    //                   return Divider(
    //                     color: Colors.grey,
    //                   );
    //                 },
    //                 itemBuilder: (context, index) {
    //                   return ListTile(title: Text(model.data.words[index]));
    //                 },
    //               ),
    //             )),
    //       ),
    //     ),
    //     top: MediaQuery.of(context).size.height * 0.18,
    //     right: 0.0,
    //     left: 0.0,
    //   ),
    // );

    return Container(
      height: 55,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(19.0)),
      ),
      child: TextField(
        controller: locator<TextEditingController>(),
        onChanged: (value) {
          // setState(() {});
          locator<AutoCompleteManager>()
              .inQuery
              .add(locator<TextEditingController>().text);
          // locator<SearchManager>().inQuery.add(value);
          // print(value);
        },
        onTap: () {
          locator<AutoCompleteManager>().inCategoryId.add(widget.categoryId);
          // overlayState.insert(overlayEntry);
        },
        onSubmitted: (value) {
          // overlayEntry?.remove();
          locator<TextEditingController>().clear();
        },
        decoration: InputDecoration(
            alignLabelWithHint: true,
            filled: true,
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            hintStyle: TextStyle(color: Colors.grey[600], fontSize: 13),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.teal[900],
            ),
            hintText: "Search...",
            fillColor: Colors.white),
      ),
    );
  }
}
