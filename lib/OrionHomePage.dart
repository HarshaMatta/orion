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
  var tiles = new List<Tile>();

  void onSaveButton() {
    setState(() {
      var tokens = _c.text.split(".");
      String name = tokens.length > 1 ? tokens[1] : tokens[tokens.length-1];

      // TODO: add name and url properly
      Tile tile = Tile( name,  _c.text);
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
