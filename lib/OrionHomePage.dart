import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orion/IconEditor.dart';
import 'package:orion/Tile.dart';
import 'package:orion/StringUtils.dart';
import 'package:orion/Preferences.dart';
import 'dart:async';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class OrionHomePage extends StatefulWidget {
  OrionHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  OrionHomePageState createState() => OrionHomePageState();
}

class OrionHomePageState extends State<OrionHomePage> {
  StreamSubscription intentDataStreamSubscription;
  TextEditingController nameCtrl;
  TextEditingController urlCtrl;
  IconEditor iconEditor = new IconEditor(0, 0);
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
        tilesMap[key] = Tile(key, value.url, value.iconCodePoint, value.color);
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
    if (nameCtrl != null && nameCtrl.text.isNotEmpty) {
      name = nameCtrl.text;
    }
    
    if(name.isNotEmpty && urlCtrl.text.isNotEmpty) {
      Tile tile = Tile(name, urlCtrl.text, iconEditor.getIcon(), iconEditor.getColor());
      tilesMap[name] = tile;
    
      // save in preferences
      saveAppNameValue(name, urlCtrl.text, iconEditor.getIcon(), iconEditor.getColor());
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

  void createInputPopUp(
      List<String> btnNames,
      String url,
      String name,
      int colorVal,
      int codePoint) {
    int colIdx = MaterialResources.getColorIndex(colorVal);
    int iconIdx = MaterialResources.getIconIndex(codePoint);
    iconEditor.setColorIdx(colIdx);
    iconEditor.setIconIdx(iconIdx);

    urlCtrl.text = url;
    nameCtrl.text = name;

    var popDialog = new Dialog(
      child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: new Text("Enter URL :"),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: new TextField(
                  decoration: new InputDecoration(hintText: "Enter Url"),
                  controller: urlCtrl),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: new Text("Enter App Name :"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: new TextField(
                  decoration: new InputDecoration(hintText: "Enter App Name"),
                 controller: nameCtrl),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: iconEditor
            ),
            createRowButtons(btnNames)
          ]
      ),
    );

    showDialog(context: context, builder: (_) => popDialog);
  }

  void createInputPopUpWithAddBtn(String url, String name) {
    List<String> btns = new List<String>();
    btns.add("ADD");
    createInputPopUp(btns, url, name, 0, 0);
  }

  @override
  void initState() {
    nameCtrl = new TextEditingController();
    urlCtrl = new TextEditingController();
    super.initState();
    loadAppsFromPref();

    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
          setState(() {
            var name = getDomain(value);
            createInputPopUpWithAddBtn(value, name);
          });
        }, onError: (err) {
          print("getLinkStream error: $err");
        });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String value) {
      setState(() {
        if(value.isNotEmpty) {
          var name = getDomain(value);
          createInputPopUpWithAddBtn(value, name);
        }
      });
    });
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
          // nameCtrl.clear();
          // urlCtrl.clear();
          List<String> btns = new List<String>();
          btns.add("ADD");
          // TODO:
          createInputPopUp(btns, "", "", 0, 0);
        },
        tooltip: 'ShowDialog',
        child: Icon(Icons.add),
      ),
      // child: Icon(Icons.add), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
