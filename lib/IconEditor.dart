import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MaterialResources {
  static List <IconData> iconNames =
  [
    Icons.accessibility,
    Icons.account_balance,
    Icons.account_circle,
    Icons.article,
    Icons.android,
    Icons.build,
    Icons.credit_card,
    Icons.dashboard,
    Icons.done_outline,
    Icons.eco,
    Icons.explore,
    Icons.extension,
    Icons.face,
    Icons.fingerprint,
    Icons.leaderboard,
    Icons.question_answer,
    Icons.reorder,
    Icons.room,
    Icons.settings,
    Icons.shopping_cart,
    Icons.sticky_note_2,
    Icons.sports_esports,
    Icons.videogame_asset,
    Icons.movie,
    Icons.web,
    Icons.chat_bubble,
    Icons.email,
    Icons.qr_code,
    Icons.flag,
    Icons.send,
    Icons.folder,
    Icons.desktop_mac,
    Icons.smartphone,
    Icons.wb_sunny,
    Icons.map,
    Icons.time_to_leave,
    Icons.navigation,
    Icons.flight,
    Icons.lunch_dining,
    Icons.all_inclusive,
    Icons.sd_card,
    Icons.book,
    Icons.menu_book,
    Icons.star,
  ];

  static List <Color> colors =
  [
    Colors.purple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.deepOrange,
    Colors.red,
  ];

  static int getColorIndex(int colorVal) {
    int idx = 0;
    colors.asMap().forEach((index, color) {
      if (color.value == colorVal){
        idx = index;
      }
    });
    return idx; // default to zero
  }

  static int getIconIndex(int codePoint) {
    // find the index
    int idx = 0;
    iconNames.asMap().forEach((index, icon) {
      if (icon.codePoint == codePoint) {
        idx = index;
      }
    });
    return idx; // default to zero
  }

  // acquiring the index from both colorVal and codePoint

  // TODO: check index bounds
  static int getColorFromIdx(int colorIdx) {
    return colors[colorIdx].value;
  }

  // TODO: check index bounds
  static int getIconFromIdx(int iconIdx) {
    return iconNames[iconIdx].codePoint;
  }
  //acquiring the icon or color name from the index

}

// TODO: how to access state ?
class IconEditor extends StatefulWidget {
  IconEditorState state;
  int colorIdx;
  int iconIdx;
  IconEditor(int colorIdx, int iconIdx) {
    this.colorIdx = colorIdx;
    this.iconIdx = iconIdx;
  }
  // setting icon and color index for the IconEditor

  void setColorIdx(int colIdx) {
    this.colorIdx = colIdx;
  }

  void setIconIdx(int iconIdx) {
    this.iconIdx = iconIdx;
  }

  @override
  State<StatefulWidget> createState() {
    state = new IconEditorState(this.colorIdx, this.iconIdx);
    return state;
  }

  int getColor() {
    return state.getColor();
  }

  int getIcon(){
    return state.getIcon();
  }
}
class IconEditorState extends State<IconEditor> {

  int tabIndex = 0;
  var activeColor = Colors.blue;
  var activeIconIdx = 0;
  var activeColorIdx = 0;

  //creating active variables that need to be able to automatically refresh

  IconEditorState(int colorIdx, int iconIdx){
    this.activeColorIdx = colorIdx;
    this.activeIconIdx = iconIdx;
  }

  int getColor() {
    return MaterialResources.getColorFromIdx(activeColorIdx);
  }

  int getIcon() {
    return MaterialResources.getIconFromIdx(activeIconIdx);
  }

  getIconButton(IconData icon, Color color, int idx, bool select) {
    return Container(
        color: (select == true) ? Colors.black :
        Colors.white,
        padding: EdgeInsets.all(2),
        child: Container(
            color: color,
            child: new IconButton(
              color: Colors.white,
              iconSize: 34,
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
        color: (select == true) ? Colors.black :
        Colors.white,
        padding: EdgeInsets.all(2),
        child: FlatButton(
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
        scrollDirection: Axis.horizontal,
        crossAxisCount: 2,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
        children: List.generate(MaterialResources.colors.length, (index) {
          return getColorButton(MaterialResources.colors[index], index, index == activeColorIdx);
        })
    );
  }

  getIconGrid() {
    return GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 2,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        padding: EdgeInsets.all(8),
        children: List.generate(MaterialResources.iconNames.length, (index) {
          return getIconButton(
            MaterialResources.iconNames[index], activeColor, index, index == activeIconIdx,);
        })
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
              height: 120,
              child: (tabIndex == 0) ? getColorGrid() : getIconGrid()
          )
        ]);
  }
}
