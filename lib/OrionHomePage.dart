import 'package:flutter/material.dart';
import 'package:orion/Tile.dart';

class OrionHomePage extends StatefulWidget {
  OrionHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  OrionHomePageState createState() => OrionHomePageState();
}

class OrionHomePageState extends State<OrionHomePage> {

  TextEditingController _c;
  String currentUrl = "Test";
  var tiles = new List<Tile>();

  void onSaveButton() {
    setState(() {
      currentUrl = _c.text;
      Tile tile = new Tile();
      tile.name = _c.text;
      tiles.add(tile);
    });
    Navigator.pop(context);
  }

  void createInputPopUp() {
    var popDialog = new Dialog(
      child: new Column(
          children: <Widget>[
            new TextField(
                decoration: new InputDecoration(hintText: "Enter URL"),
                controller: _c),
            new FlatButton(
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
    _c = new TextEditingController();
    currentUrl = "EMPTY";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Entered URL :',
            ),
            Text(
              currentUrl,
            ),
          ],
        ),
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
