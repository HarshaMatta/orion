import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:orion/WebViewPage.dart';
import 'package:orion/OrionHomePage.dart';

class Tile {
  String name;
  String url;

  Tile(String xName, String xUrl) {
    this.name = xName;
    this.url = xUrl;
  }
}

class TileCard extends StatelessWidget {
  final Tile tile;
  final OrionHomePageState parent;

  TileCard({this.tile, this.parent});

  getCard() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Card(
            elevation: 1,
            color: RandomColor().getColor(),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.link, size: 40),
                      Text(tile.name, style: TextStyle(fontSize: 24))
                    ]
                )
            )
        )
    );
  }

  void handleTap(BuildContext context, String url) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WebViewPage(url : url)));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: GestureDetector(
          onTap: () =>  handleTap(context, tile.url),
          child: getCard(),
          onLongPress: (){
              List<String> btns = new List<String>();
              btns.add("UPDATE");
              btns.add("DELETE");
              parent.setNameCtrl(tile.name);
              parent.setUrlCtrl(tile.url);
              parent.oldName = tile.name;
              parent.oldUrl = tile.url;
              parent.createInputPopUp(btns,);
          },
        )
    );
  }
}

class RandomColor {
  Random random = Random();
  Color getColor() {
    return Color.fromARGB(random.nextInt(255), random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}