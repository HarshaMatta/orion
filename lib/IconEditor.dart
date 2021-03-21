import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// TODO: how to access state ?
class IconEditor extends StatefulWidget {
  IconEditorState state;
  @override
  State<StatefulWidget> createState() {
    state = new IconEditorState();
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

  List <IconData> iconNames =
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

  List <Color> colors =
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

  int getColor() {
    return colors[activeColorIdx].value;
  }

  int getIcon() {
    return iconNames[activeIconIdx].codePoint;
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
        children: List.generate(colors.length, (index) {
          return getColorButton(colors[index], index, index == activeColorIdx);
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
        children: List.generate(iconNames.length, (index) {
          return getIconButton(
            iconNames[index], activeColor, index, index == activeIconIdx,);
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
