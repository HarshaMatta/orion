import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:orion/WebViewPage.dart';
import 'package:orion/OrionHomePage.dart';

class Tile {
  String name;
  String url;
  int iconCodePoint;
  int color;

  Tile(String xName, String xUrl, int xCodePoint, int xColor) {
    this.name = xName;
    this.url = xUrl;
    this.iconCodePoint = xCodePoint;
    this.color = xColor;
  }
}

class TileCard extends StatelessWidget {
  final Tile tile;
  final OrionHomePageState parent;

  TileCard({this.tile, this.parent});

  getCard() {

    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        color: Color(tile.color),    // RandomColor().getColor(),
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(IconData(tile.iconCodePoint, fontFamily: 'MaterialIcons'), size: 50),  //Icon(Icons.link, size: 50),
                  Text(tile.name, style: TextStyle(fontSize: 12))
                ]
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
        borderRadius: BorderRadius.circular(20),
        child: GestureDetector(
          onTap: () =>  handleTap(context, tile.url),
          child: getCard(),
          onLongPress: (){
              List<String> btns = new List<String>();
              btns.add("UPDATE");
              btns.add("DELETE");

              parent.oldName = tile.name;
              parent.oldUrl = tile.url;
              parent.createInputPopUp(
                  btns,
                  tile.url,
                  tile.name,
                  tile.color,
                  tile.iconCodePoint);

          },
        )
    );
  }
}