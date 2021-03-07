import 'package:flutter/material.dart';

void createOrEditInputPopUp(
    TextEditingController nameCtrl,
    TextEditingController urlCtrl,
    Row buttons,
    BuildContext context) {
  var popDialog = new Dialog(
    child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: new Text("Enter URL :"),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: new TextField(
                decoration: new InputDecoration(hintText: "Enter Url"),
                controller: urlCtrl),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text("Enter App Name :"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextField(
                decoration: new InputDecoration(hintText: "Enter App Name"),
                controller: nameCtrl),
          ),
          buttons
        ]
    ),
  );

  showDialog(child: popDialog, context: context);
}