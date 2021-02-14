import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:orion/Tile.dart';

class OrionHomePage extends StatefulWidget {
  OrionHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  OrionHomePageState createState() => OrionHomePageState();
}

class OrionHomePageState extends State<OrionHomePage> {

  TextEditingController _nameCtrl;
  TextEditingController _urlCtrl;

  var tilesMap = new HashMap<String,Tile>();

   String stripString(String input, String strip) {
    var tokens = input.split(".");
    if (tokens[0].toLowerCase().startsWith(strip.toLowerCase())) {
      tokens.removeAt(0);
    }
    return tokens[0];
  }

  void onSaveButton() {
    setState(() {

      var name = "";
      if (_nameCtrl == null || _nameCtrl.text.isEmpty) {
        var urlStr = _urlCtrl.text;
        name = Uri.parse(urlStr).host.toLowerCase();
        name = stripString(name, "www");

      } else {
        name = _nameCtrl.text;
      }

      // TODO: add name and url properly
      Tile tile = Tile(name,  _urlCtrl.text);
      tilesMap[name]=tile;
    });
    Navigator.pop(context);
  }

  void createInputPopUp() {
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
                  decoration: new InputDecoration(hintText: "Enter App URL"),
                  controller: _urlCtrl),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text("Enter URL :"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new TextField(
                  decoration: new InputDecoration(hintText: "Enter App Name"),
                 controller: _nameCtrl),
            ),
            new ElevatedButton(
              child: new Text("Add"),
              onPressed: onSaveButton,
            )
          ]
      ),
    );

    showDialog(child: popDialog, context: context);
  }

  @override
  void initState() {
     _nameCtrl = new TextEditingController();
     _urlCtrl = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tiles = tilesMap.values.toList();
     return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body : GridView.count(crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        padding: EdgeInsets.all(10.0),
        children: List.generate(tiles.length, (index) {
          return Center(child: TileCard(tile : tiles[index]));
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createInputPopUp,
        tooltip:  'ShowDialog',
        child: Icon(Icons.add),
      ),
      // child: Icon(Icons.add), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
