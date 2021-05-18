import 'package:flutter/material.dart';


Widget loadingIndicator(bool ,context){
  return bool == true
      ? Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    color: Colors.black.withOpacity(0.5),
    child: Center(
        child: Container(
//                      color: mainColor,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )),
  )
      : Container();
}

