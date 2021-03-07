import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orion/Tile.dart';
import 'package:orion/StringUtils.dart';
import 'package:orion/Preferences.dart';

class OrionHomePage extends StatefulWidget {
  OrionHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  OrionHomePageState createState() => OrionHomePageState();
}

class OrionHomePageState extends State<OrionHomePage> {
  TextEditingController nameCtrl;
  TextEditingController urlCtrl;
  String oldName;
  String oldUrl;
  HashMap<String, Tile> tilesMap = new HashMap<String, Tile>(); 

  void setNameCtrl(String name) {
    nameCtrl.text = name;
  }
  void setUrlCtrl(String url) {
    urlCtrl.text = url;
  }

  loadAppsFromPref() async {
    final appNames = await loadAppNameValue();

    setState(() {
      tilesMap.clear();
      appNames.forEach((key, value) {
        tilesMap[key] = Tile(key, value);
      });
    });
  }

  void onSaveButton() {
    setState(() {
      saveApp();
    });
    Navigator.pop(context);
  }

  void saveApp() {
    var name = "";
    if (nameCtrl == null || nameCtrl.text.isEmpty) {
      name = getDomain(urlCtrl.text);
    } else {
      name = nameCtrl.text;
    }
    
    if(name.isNotEmpty && urlCtrl.text.isNotEmpty) {
      Tile tile = Tile(name, urlCtrl.text);
      tilesMap[name] = tile;
    
      // save in preferences
      saveAppNameValue(name, urlCtrl.text);
    }
  }

  void deleteApp() {
    deleteFromPref(oldName);
    tilesMap.remove(oldName);
  }

  onUpdateButton () {
    setState(() {
      deleteApp();
      saveApp();
    });
    Navigator.pop(context);
  }

  onDeleteButton() {
    setState(() {
      deleteApp();
    });
    Navigator.pop(context);
  }

  Row createRowButtons(List<String> btnNames) {
    List<Widget> btns = new List<Widget>();

    btnNames.forEach((e) =>
    {
      if (e == "ADD") {
        btns.add(
            new ElevatedButton(
              child: new Text("Add"),
              onPressed: onSaveButton,
            )
        )
      }
      else
        if(e == "UPDATE") {
          btns.add(
              new ElevatedButton(
                child: new Text("Update"),
                onPressed: onUpdateButton,
              )
          )
        }
        else
          if (e == "DELETE") {
            btns.add(
                new ElevatedButton(
                  child: new Text("Delete"),
                  onPressed: onDeleteButton,
                )
            )
          }
    });

    return new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: btns
    );
  }

  void createInputPopUp(List<String> btnNames) {
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
            createRowButtons(btnNames)
          ]
      ),
    );

    showDialog(child: popDialog, context: context);
  }

  @override
  void initState() {
    nameCtrl = new TextEditingController();
    urlCtrl = new TextEditingController();
    super.initState();
    loadAppsFromPref();
  }

  @override
  Widget build(BuildContext context) {
    var tiles = tilesMap.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.count(crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        padding: EdgeInsets.all(10.0),
        children: List.generate(tiles.length, (index) {
          return Center(child: TileCard(tile: tiles[index], parent: this));
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          nameCtrl.clear();
          urlCtrl.clear();
          List<String> btns = new List<String>();
          btns.add("ADD");
          createInputPopUp(btns);
        },
        tooltip: 'ShowDialog',
        child: Icon(Icons.add),
      ),
      // child: Icon(Icons.add), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
