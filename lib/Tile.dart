import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:orion/WebViewPage.dart';

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

  TileCard({this.tile});

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