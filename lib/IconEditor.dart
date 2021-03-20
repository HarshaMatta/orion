import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconEditor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new IconEditorState();
  }
}
class IconEditorState extends State<IconEditor> {

  int tabIndex = 0;
  var activeColor = Colors.blue;
  var activeIconIdx = 0;
  var activeColorIdx = 0;

  List <IconData> iconNames =
  [
    Icons.camera_alt_outlined,
    Icons.account_circle,
    Icons.android,
    Icons.done_outline,
    Icons.camera_alt_outlined,
    Icons.account_circle,
    Icons.android,
    Icons.done_outline,
  ];

  List <Color> colors =
  [Colors.cyan,
    Colors.blue,
    Colors.purple,
    Colors.red];

  getIconButton(IconData icon, Color color, int idx, bool select) {
    return Container(
        color: (select == true) ? Colors.black:
        Colors.white,
        padding: EdgeInsets.all(5),
      child: Container(
        color: color,
        child: new IconButton(
          color: Colors.white,
           iconSize: 40,
          icon: Icon(
              icon
          ),
          alignment: Alignment.center,
          onPressed: () {
            setState(() {
              activeIconIdx = idx;
            });
          },
        )
      )
      );
  }

  getColorButton(Color color, int idx, bool select) {
    return Container(
      color: (select == true) ? Colors.black:
        Colors.white,
     padding: EdgeInsets.all(5),
     child:FlatButton(
      child: Text(''),
      color: color,
      onPressed: () {
        setState(() {
          activeColor = color;
          activeColorIdx = idx;
        });
      },
    )
    );
  }

  getColorGrid() {
    return GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        padding: EdgeInsets.all(10.0),
        children: List.generate(colors.length, (index) {
          return getColorButton(colors[index], index, index == activeColorIdx);
        })
    );
  }

  getIconGrid() {
    return GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        padding: EdgeInsets.all(10.0),
        children: List.generate(iconNames.length, (index) {
          return getIconButton(iconNames[index], activeColor, index ,index == activeIconIdx);
        })
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //       // mainAxisSize : MainAxisSize.max,
  //       children: <Widget>[
  //         Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: <Widget>[
  //               OutlineButton(
  //                 onPressed: () { setState(() {
  //                   colorMode = true;
  //                 });} ,
  //                 child: Text("Color"),
  //               ),
  //               OutlineButton(onPressed: () { setState(() {
  //                 colorMode = false;
  //               });} ,
  //                 child: Text("Icon"),
  //               ),
  //             ]),
  //         Container(
  //           height: 200,
  //                 child: (colorMode == true) ? getColorGrid() : getIconGrid()
  //             )
  //       ]);
  // }

  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("      Color      "),
    1: Text("      Icons      ")
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize : MainAxisSize.max,
        children: <Widget>[
          CupertinoSlidingSegmentedControl(
            // padding: EdgeInsets.symmetric(vertical: 1, horizontal: 50),
            groupValue: tabIndex,
            children: myTabs,
            onValueChanged: (i) {
              setState(() {
                tabIndex = i;
              });
            },
          ),
          Container(
              height: 200,
              child: (tabIndex == 0) ? getColorGrid() : getIconGrid()
          )
        ]);
  }
}
