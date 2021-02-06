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

  var tiles = new List<Tile>();

  void onSaveButton() {
    setState(() {

      var name = "";
      if (_nameCtrl == null || _nameCtrl.text.isEmpty) {
        var urlStr = _urlCtrl.text;
        print(name);
        if( urlStr.startsWith("http")){
          print("if");
          name = Uri.parse(urlStr).host.toLowerCase();
          name = name.split(".")[1];
        } else {
          print(name);
          name = urlStr.split(".")[0];
        }

      } else {
        name = _nameCtrl.text;
      }

      // TODO: add name and url properly
      Tile tile = Tile(name,  _urlCtrl.text);
      tiles.add(tile);
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
                 controller: _nameCtrl,
              ),
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
    _urlCtrl = new TextEditingController();
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
